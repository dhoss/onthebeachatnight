sub finalize {
    my $c = shift;

    $c->NEXT::finalize();

    if ( my $scope = delete $c->stash->{__kioku_scope} ) {
        my @live_objects = $scope->live_objects->live_objects;

        my $msg = "Loaded " . scalar(@live_objects) . " objects";

        if ( $c->debug ) {
            require Text::SimpleTable;
            my $t = Text::SimpleTable->new( [ 60, 'Class' ], [ 8, 'Count' ] );

            my %counts;
            $counts{ref($_)}++ for @live_objects;

            foreach my $class ( sort { $counts{$b} <=> $counts{$a} } keys %counts ) {
                $t->row( $class, $counts{$class} );
            }

            $msg .= "\n" . $t->draw;
        }

        $c->log->debug($msg);

        undef $scope;
    }

    %{ $c->stash } = ();

    my $l = $c->model("Kioku")->db->live_objects;

    # anything still live at this point is a leak
    if ( my @live = $l->live_objects ) {
        require Data::Dumper;
        #$c->log->warn("leaked objects: ", Data::Dumper::Dumper(@live));
    }

    $l->clear();
}

