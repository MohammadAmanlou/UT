CREATE TABLE Customer (
  CID INTEGER,
  name_ TEXT,
  contact_info TEXT,
  PRIMARY KEY (CID)
);

CREATE TABLE UniStudent (
  CID INTEGER,
  StudentID INTEGER,
  University TEXT,
  Discount TEXT,
  PRIMARY KEY (CID),
  FOREIGN KEY (CID) REFERENCES Customer (CID) ON DELETE CASCADE
);

CREATE TABLE Admin_ (
  ADID INTEGER,
  name_ TEXT,
  Role_ TEXT,
  Salary TEXT,
  PRIMARY KEY (ADID)
);

CREATE TABLE BoardGame (
  BID INTEGER,
  Title TEXT,
  Version_ TEXT,
  Publisher TEXT,
  ADID INTEGER NOT NULL,
  Status_ TEXT,
  PRIMARY KEY (BID),
  FOREIGN KEY (ADID) REFERENCES Admin_ (ADID) ON DELETE NO ACTION
);

CREATE TABLE Review (
  CID INTEGER,
  BID INTEGER,
  rating FLOAT,
  PRIMARY KEY (BID, CID),
  FOREIGN KEY (BID) REFERENCES BoardGame (BID),
  FOREIGN KEY (CID) REFERENCES Customer (CID)
);

CREATE TABLE Genre (
  genre varchar(100),
  PRIMARY KEY (genre)
);

CREATE TABLE HasGenre (
  genre varchar(100),
  BID INTEGER,
  PRIMARY KEY (BID, genre),
  FOREIGN KEY (BID) REFERENCES BoardGame (BID),
  FOREIGN KEY (genre) REFERENCES Genre (genre)
);

CREATE TABLE Physical_BoardGame (
  BID INTEGER,
  Price FLOAT,
  PRIMARY KEY (BID),
  FOREIGN KEY (BID) REFERENCES BoardGame (BID) ON DELETE CASCADE
);

CREATE TABLE Digital_BoardGame (
  BID INTEGER,
  Price FLOAT,
  PRIMARY KEY (BID),
  FOREIGN KEY (BID) REFERENCES BoardGame (BID) ON DELETE CASCADE
);

CREATE TABLE Downloads (
  BID INTEGER,
  CID INTEGER,
  Date_ date,
  PRIMARY KEY (BID, CID),
  FOREIGN KEY (BID) REFERENCES Digital_BoardGame (BID),
  FOREIGN KEY (CID) REFERENCES Customer (CID)
);


CREATE TABLE Delivery (
  DID INTEGER,
  contact_info TEXT,
  type_ TEXT,
  name_ TEXT,
  commission FLOAT,
  PRIMARY KEY (DID)
);

CREATE TABLE Order_ (
  CID INTEGER NOT NULL,
  OID_ INTEGER,
  DID INTEGER NOT NULL,
  shipping_rate FLOAT,
  total_cost FLOAT,
  delivery_date date,
  PRIMARY KEY (OID_, CID),
  FOREIGN KEY (CID) REFERENCES Customer (CID) ON DELETE CASCADE,
  FOREIGN KEY (DID) REFERENCES Delivery (DID) ON DELETE NO ACTION
);

CREATE TABLE Physical_Order (
  BID INTEGER,
  OID_ INTEGER,
  CID INTEGER,
  Date_ date,
  PRIMARY KEY (BID, OID_, CID),
  FOREIGN KEY (BID) REFERENCES Physical_BoardGame (BID),
  FOREIGN KEY (OID_, CID) REFERENCES Order_ (OID_, CID)
);