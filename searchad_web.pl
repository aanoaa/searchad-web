{
    name => 'searchad-web',
    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header => 1,
    default_view => 'Bootstrap',
    'View::Bootstrap' => {
        PRE_CHOMP          => 1,
        POST_CHOMP         => 1,
        ENCODING           => 'utf8',
        TEMPLATE_EXTENSION => '.tt',
        INCLUDE_PATH => [
            '__path_to(root/templates/bootstrap/src)__',
            '__path_to(root/templates/bootstrap/lib)__',
        ],
        PRE_PROCESS => 'config/main',
        WRAPPER     => 'site/wrapper',
        COMPILE_DIR => '__path_to(root/tt_cache)__',
        COMPILE_EXT => '.ttc',
        TIMER       => 0,
        ERROR       => 'error.tt',
        render_die  => 1,
    },
    'Model::DBIC' => {
        class => 'SearchAd::DBIC',
        args  => {
            connect_info => {
                dsn => "dbi:SQLite:db/searchad.db",
            }
        }
    },
}
