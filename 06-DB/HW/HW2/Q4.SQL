CREATE TABLE Patient (
  PID INTEGER,
  name_ TEXT,
  contact_info TEXT,
  age INTEGER,
  PRIMARY KEY (PID)
);


CREATE TABLE Department (
  DEID INTEGER,
  manager TEXT,
  specialization TEXT,
  PRIMARY KEY (DEID)
);


CREATE TABLE Doctor_WorksIn (
  DID INTEGER,
  name_ TEXT,
  contact_info TEXT,
  license TEXT,
  DEID INTEGER NOT NULL,
  from_ date,
  to_ date,
  PRIMARY KEY (DID),
  FOREIGN KEY (DEID) REFERENCES Department (DEID) ON DELETE NO ACTION
);


CREATE TABLE Appointment (
  DID INTEGER,
  PID INTEGER,
  Date_ date,
  total_cost FLOAT,
  PRIMARY KEY (DID, PID),
  FOREIGN KEY (DID) REFERENCES Doctor_WorksIn (DID),
  FOREIGN KEY (PID) REFERENCES Patient (PID)
);


CREATE TABLE MedicalRecord (
  MID_ INTEGER,
  diagnosis TEXT,
  PID INTEGER NOT NULL,
  DID INTEGER NOT NULL,
  PRIMARY KEY (MID_, PID),
  FOREIGN KEY (DID) REFERENCES Doctor_WorksIn (DID) ON DELETE NO ACTION,
  FOREIGN KEY (PID) REFERENCES Patient (PID) ON DELETE CASCADE
);


CREATE TABLE Treatment (
  Dosage FLOAT,
  Instructions varchar(100),
  Medication varchar(100),
  PRIMARY KEY (Dosage, Instructions, Medication)
);


CREATE TABLE MedicalRecord_Has_Treatment (
  MID_ INTEGER,
  PID INTEGER,
  Dosage FLOAT,
  Instructions varchar(100),
  Medication varchar(100),
  PRIMARY KEY (MID_, PID, Dosage, Instructions, Medication),
  FOREIGN KEY (MID_, PID) REFERENCES MedicalRecord (MID_, PID),
  FOREIGN KEY (Dosage, Instructions, Medication) REFERENCES Treatment (Dosage, Instructions, Medication)
);
