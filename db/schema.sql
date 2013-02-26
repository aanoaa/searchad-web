PRAGMA fireign_keys = ON;

DROP TABLE bundle;
DROP TABLE client;
DROP TABLE user;
DROP TABLE role;
DROP TABLE user_role;

CREATE TABLE user (
    id            INTEGER PRIMARY KEY,
    username      TEXT,
    password      TEXT,
    email_address TEXT,
    first_name    TEXT,
    last_name     TEXT,
    active        INTEGER
);

CREATE TABLE role (
    id   INTEGER PRIMARY KEY,
    role TEXT
);

CREATE TABLE user_role (
    user_id INTEGER REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,
    role_id INTEGER REFERENCES role(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (user_id, role_id)
);

CREATE TABLE client (
    id       INTEGER,
    user_id  INTEGER REFERENCES user(id) ON DELETE CASCADE ON UPDATE CASCADE,
    username TEXT,
    password TEXT,
    PRIMARY KEY (id),
    UNIQUE (username)
);

CREATE TABLE bundle (
    id         INTEGER PRIMARY KEY,
    client_id  INTEGER REFERENCES client(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name       TEXT,
    rank       INTEGER DEFAULT 15,
    interval   INTEGER DEFAULT 60, -- minutes
    active     INTEGER DEFAULT 1,
    refresh_at INTEGER  -- epoch time
);
