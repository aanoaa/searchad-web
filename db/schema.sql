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
    rank       INTEGER DEFAULT 15,
    interval   INTEGER DEFAULT 60, -- minutes
    refresh_at INTEGER  -- epoch time
);
