PRAGMA fireign_keys = ON;

DROP TABLE bundle;
DROP TABLE client;
DROP TABLE user;
DROP TABLE role;
DROP TABLE user_role;
DROP TABLE day;
DROP TABLE bundle_day;
DROP TABLE history;

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

INSERT INTO role VALUES (1, 'user');
INSERT INTO role VALUES (2, 'admin');

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
    `limit`    INTEGER DEFAULT NULL,
    interval   INTEGER DEFAULT 60, -- minutes
    active     INTEGER DEFAULT 1,
    refresh_at INTEGER  -- epoch time
);

CREATE TABLE day (
    id  INTEGER PRIMARY KEY,
    day TEXT
);

INSERT INTO day VALUES (1, 'Mon');
INSERT INTO day VALUES (2, 'Tue');
INSERT INTO day VALUES (3, 'Wed');
INSERT INTO day VALUES (4, 'Thu');
INSERT INTO day VALUES (5, 'Fri');
INSERT INTO day VALUES (6, 'Sat');
INSERT INTO day VALUES (7, 'Sun');

CREATE TABLE bundle_day (
    bundle_id INTEGER REFERENCES bundle(id) ON DELETE CASCADE ON UPDATE CASCADE,
    day_id INTEGER REFERENCES day(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (bundle_id, day_id)
);

CREATE TABLE history (
    id INTEGER PRIMARY KEY,
    bundle_id INTEGER REFERENCES bundle(id) ON DELETE CASCADE ON UPDATE CASCADE,
    status INTEGER DEFAULT 1,
    created_at INTEGER -- epoch time
);
