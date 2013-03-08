{
    name => 'searchad-web',
    ## Disable deprecated behavior needed by old applications
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
                sqlite_unicode => 1,
                quote_char     => q{`},
            }
        }
    },
    authentication => {
        default_realm => "users",
        realms        => {
            users => {
                # Catalyst::Authentication::Credential::Password
                credential => {
                    class              => "Password",
                    password_field     => "password",
                    password_type      => 'hashed',
                    password_hash_type => 'SHA-1'
                },
                store => {
                    class       => "DBIx::Class",
                    user_model  => "DBIC::User",
                },
            }
        }
    },
    session => {
        flash_to_stash => 1,
        storage        => "__path_to(tmp/storage/session)__",
        expires        => 60 * 60 * 24,
        unlink_on_exit => 0,
    },
    validator => {
        options  => { charset => "utf8" },
        messages => "__path_to(misc/messages.yml)__",
    },
}
