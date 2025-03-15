CREATE TABLE members(
    username TEXT PRIMARY KEY,
    status INTEGER NOT NULL,
    type TEXT NOT NULL
);

CREATE TABLE locations(
    name TEXT PRIMARY KEY,
    latitude REAL NOT NULL,
    longitude REAL NOT NULL,
    traffic INTEGER NOT NULL
);

CREATE TABLE trips(
    id INTEGER PRIMARY KEY,
    status TEXT NOT NULL,
    price REAL NOT NULL,
    passenger_id TEXT NOT NULL,
    driver_id TEXT,
    origin_name TEXT NOT NULL,
    destination_name TEXT NOT NULL
);

INSERT INTO locations(name, latitude, longitude, traffic) VALUES('Enghelab', 35.70, 51.39, 2);
INSERT INTO locations(name, latitude, longitude, traffic) VALUES('SaadatAbad', 35.77, 51.36, 3);
INSERT INTO locations(name, latitude, longitude, traffic) VALUES('Farahzad', 35.78, 51.33, 1);
INSERT INTO locations(name, latitude, longitude, traffic) VALUES('Tehranpars', 35.72, 51.51, 4);
INSERT INTO locations(name, latitude, longitude, traffic) VALUES('Marzdaran', 35.73, 51.35, 6);
