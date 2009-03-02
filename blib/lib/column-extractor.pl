        $_[0]->dsn,
        create  => $_[0]->create,
        columns => [
            key => {
                data_type   => "varchar",
                is_nullable => 1,
                extract =>
                  sub { my $obj = shift; return $obj->key if $obj->can('key'); }
                ,
            },
        ],

    );