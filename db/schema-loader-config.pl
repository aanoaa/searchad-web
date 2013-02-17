{
    schema_class => "SearchAd::Schema",
    connect_info => {
        dsn               => "dbi:SQLite:db/searchad.db",
    },
    loader_options => {
        dump_directory     => 'lib',
        naming             => { ALL => 'v8' },
        skip_load_external => 1,
        relationships      => 1,
        use_moose          => 1,
        only_autoclean     => 1,
        col_collision_map  => 'column_%s',
        overwrite_modifications => 1,
        datetime_undef_if_invalid => 1,
    },
}
