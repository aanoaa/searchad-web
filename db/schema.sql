PRAGMA fireign_keys = ON;

DROP TABLE bundle;
DROP TABLE client;

CREATE TABLE client (
    id       INTEGER,
    username TEXT,
    password TEXT,
    PRIMARY KEY (id),
    UNIQUE (username)
);

CREATE TABLE bundle (
    id         INTEGER PRIMARY KEY,
    client_id  INTEGER REFERENCES client(id) ON DELETE CASCADE ON UPDATE CASCADE,
    name       TEXT,
    rank       INTEGER,
    interval   INTEGER, -- minutes
    refresh_at INTEGER  -- epoch time
);
