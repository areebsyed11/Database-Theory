-- QUESTION # 3

-- (1)
CREATE TABLE Patient (
    Patient_ID INT PRIMARY KEY,
    Name VARCHAR(20) NOT NULL,
    Gender VARCHAR(1) CHECK (Gender IN ('M', 'F')),
    DOB DATE,
    Phone INT,
    Email VARCHAR(40) UNIQUE,
    Username VARCHAR(50),
    Password VARCHAR(40)
);

CREATE TABLE Doctor (
    Doctor_ID INT PRIMARY KEY,
    Name VARCHAR(20),
    Specialization VARCHAR(20),
    Username VARCHAR(50),
    Password VARCHAR(40)
);

CREATE TABLE Appointment (
    Appointment_ID INT PRIMARY KEY,
    Appointment_Date DATE,
    Appointment_Time INT,
    Status VARCHAR(15) CHECK (Status IN ('WAITING', 'CHECKED')),
    Clinic_Number INT,
    Patient_ID INT,
    Doctor_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE TABLE Prescription (
    Prescription_ID INT PRIMARY KEY,
    Prescription_Date DATE,
    Doctor_Advice VARCHAR(50),
    Followup_Required VARCHAR(3) CHECK (Followup_Required IN ('YES','NO')),
    Patient_ID INT,
    Doctor_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor(Doctor_ID)
);

CREATE TABLE Invoice (
    Invoice_ID INT PRIMARY KEY,
    Invoice_Date DATE,
    Amount INT,
    Payment_Status VARCHAR(10) CHECK (Payment_Status IN ('PAID','NOT PAID')),
    Payment_Method VARCHAR(4) CHECK (Payment_Method IN ('CASH','CARD')),
    Patient_ID INT,
    FOREIGN KEY (Patient_ID) REFERENCES Patient(Patient_ID)
);

CREATE TABLE Tests (
    Test_ID INT PRIMARY KEY,
    Blood_Test NUMBER(1),
    X_Ray NUMBER(1),
    MRI NUMBER(1),
    CT_Scan NUMBER(1)
);

-- (2)
INSERT INTO Patient VALUES (1, 'Aman Ullah', 'M', TO_DATE('10-05-1990','DD-MM-YYYY'), 123456789, 'aman@xyz.com','aman_ul','pass123');
INSERT INTO Patient VALUES (2, 'Shahryar Baig', 'F', TO_DATE('22-03-1985','DD-MM-YYYY'), 987654321, 'sherry@xyz.com','baig_sh','pass234');
INSERT INTO Patient VALUES (3, 'Moosa Memon', 'M', TO_DATE('15-07-1992','DD-MM-YYYY'), 555111222, 'moosa@xyz.com','moosa_mem','pass367');

INSERT INTO Doctor VALUES (1, 'Dr. Areeb', 'Orthopedic', 'areeb_syd', 'doc234');
INSERT INTO Doctor VALUES (2, 'Dr. Sabeeh', 'Neurology', 'sabeeh_m', 'doc123');

INSERT INTO Appointment VALUES (1, TO_DATE('01-09-2025','DD-MM-YYYY'), 1000, 'WAITING', 101,1,1);
INSERT INTO Appointment VALUES (2, TO_DATE('02-09-2025','DD-MM-YYYY'), 1200, 'CHECKED', 102,2,2);
INSERT INTO Appointment VALUES (3, TO_DATE('03-09-2025','DD-MM-YYYY'), 1400, 'WAITING', 103,3,1);

INSERT INTO Prescription VALUES (1, TO_DATE('02-09-2025','DD-MM-YYYY'), 'Take medicine A', 'YES',1,1);
INSERT INTO Prescription VALUES (2, TO_DATE('02-09-2025','DD-MM-YYYY'), 'Take medicine B', 'NO',2,2);
INSERT INTO Prescription VALUES (3, TO_DATE('04-09-2025','DD-MM-YYYY'), 'Take medicine C', 'YES',3,1);

INSERT INTO Invoice VALUES (1, TO_DATE('01-09-2025','DD-MM-YYYY'), 5000, 'NOT PAID', 'CASH', 1);
INSERT INTO Invoice VALUES (2, TO_DATE('02-09-2025','DD-MM-YYYY'), 7000, 'PAID', 'CARD', 2);
INSERT INTO Invoice VALUES (3, TO_DATE('03-09-2025','DD-MM-YYYY'), 3000, 'NOT PAID', 'CASH', 3);

INSERT INTO Tests VALUES (1,1,0,0,0);
INSERT INTO Tests VALUES (2,0,1,0,0);
INSERT INTO Tests VALUES (3,0,0,1,0);

-- (3)
  -- (a)
UPDATE Patient SET Phone=123456, Email='alikhan@gmail.com' WHERE Patient_ID=1;

  -- (b)
UPDATE Invoice SET Payment_Status='PAID' WHERE Payment_Status='NOT PAID' AND Invoice_ID=1;

  -- (c)
DELETE FROM Appointment WHERE Status='CANCELLED';

  -- (d)
DELETE FROM Invoice WHERE Payment_Status='REFUNDED';

  -- (e)
SELECT * FROM Appointment WHERE Status='WAITING';

  -- (f)
SELECT * FROM Invoice WHERE Payment_Status='NOT PAID';

  -- (g)
SELECT * FROM Tests WHERE Blood_Test=1;

  -- (h)
SELECT * FROM Prescription WHERE Prescription_Date=TO_DATE('2025-09-02','YYYY-MM-DD');

-- 4
  -- (a)
SELECT P.Name AS Patient_Name, D.Name AS Doctor_Name
FROM Appointment A
JOIN Patient P ON A.Patient_ID=P.Patient_ID
JOIN Doctor D ON A.Doctor_ID=D.Doctor_ID;

  -- (b)
SELECT P.Name AS Patient_Name, T.*, D.Name AS Doctor_Name
FROM Tests T
JOIN Patient P ON T.Test_ID=P.Patient_ID
JOIN Appointment A ON P.Patient_ID=A.Patient_ID
JOIN Doctor D ON A.Doctor_ID=D.Doctor_ID;

  -- (c)
SELECT PR.Doctor_Advice
FROM Prescription PR
JOIN Patient P ON PR.Patient_ID=P.Patient_ID
WHERE P.Name='Ali Khan';

  -- (d)
SELECT PR.Doctor_Advice, D.Name AS Doctor_Name
FROM Prescription PR
JOIN Doctor D ON PR.Doctor_ID=D.Doctor_ID
WHERE PR.Followup_Required='YES';