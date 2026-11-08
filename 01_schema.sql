-- ============================================================
-- Crownfield Eye Hospital - Ophthalmology Database
-- 01_schema.sql - DDL: Create all tables
-- ============================================================

CREATE DATABASE IF NOT EXISTS crownfield_eye_hospital;
USE crownfield_eye_hospital;

-- ============================================================
-- 1. CLINIC
-- ============================================================
CREATE TABLE Clinic (
    Clinic_ID       INT             NOT NULL AUTO_INCREMENT,
    Clinic_Name     VARCHAR(100)    NOT NULL,
    Address         VARCHAR(255)    NOT NULL,
    Phone_Number    VARCHAR(20),
    CONSTRAINT pk_clinic PRIMARY KEY (Clinic_ID)
);

-- ============================================================
-- 2. SPECIALTY
-- ============================================================
CREATE TABLE Specialty (
    Specialty_ID    INT             NOT NULL AUTO_INCREMENT,
    Specialty_Name  VARCHAR(100)    NOT NULL,
    Description     VARCHAR(255),
    CONSTRAINT pk_specialty PRIMARY KEY (Specialty_ID)
);

-- ============================================================
-- 3. PATIENT
-- ============================================================
CREATE TABLE Patient (
    Patient_ID      VARCHAR(10)     NOT NULL,
    First_Name      VARCHAR(50)     NOT NULL,
    Last_Name       VARCHAR(50)     NOT NULL,
    Date_Of_Birth   DATE,
    Phone_Number    VARCHAR(20),
    Email           VARCHAR(100),
    CONSTRAINT pk_patient PRIMARY KEY (Patient_ID)
);

-- ============================================================
-- 4. CLINICIAN
-- ============================================================
CREATE TABLE Clinician (
    Clinician_ID    INT             NOT NULL AUTO_INCREMENT,
    Specialty_ID    INT             NOT NULL,
    Clinic_ID       INT             NOT NULL,
    First_Name      VARCHAR(50)     NOT NULL,
    Last_Name       VARCHAR(50)     NOT NULL,
    Phone_Number    VARCHAR(20),
    Email           VARCHAR(100),
    CONSTRAINT pk_clinician     PRIMARY KEY (Clinician_ID),
    CONSTRAINT fk_clin_spec     FOREIGN KEY (Specialty_ID) REFERENCES Specialty(Specialty_ID),
    CONSTRAINT fk_clin_clinic   FOREIGN KEY (Clinic_ID)    REFERENCES Clinic(Clinic_ID)
);

-- ============================================================
-- 5. APPOINTMENT
-- ============================================================
CREATE TABLE Appointment (
    Appointment_ID      INT             NOT NULL AUTO_INCREMENT,
    Patient_ID          VARCHAR(10)     NOT NULL,
    Clinic_ID           INT             NOT NULL,
    Clinician_ID        INT             NOT NULL,
    Appointment_Date    DATETIME        NOT NULL,
    Status              VARCHAR(20)     NOT NULL DEFAULT 'Scheduled',
    CONSTRAINT pk_appointment       PRIMARY KEY (Appointment_ID),
    CONSTRAINT fk_appt_patient      FOREIGN KEY (Patient_ID)    REFERENCES Patient(Patient_ID),
    CONSTRAINT fk_appt_clinic       FOREIGN KEY (Clinic_ID)     REFERENCES Clinic(Clinic_ID),
    CONSTRAINT fk_appt_clinician    FOREIGN KEY (Clinician_ID)  REFERENCES Clinician(Clinician_ID),
    CONSTRAINT chk_status           CHECK (Status IN ('Scheduled','Completed','Cancelled','No-Show'))
);

-- ============================================================
-- 6. DIAGNOSIS
-- ============================================================
CREATE TABLE Diagnosis (
    Diagnosis_ID    INT             NOT NULL AUTO_INCREMENT,
    Diagnosis_Name  VARCHAR(100)    NOT NULL,
    Description     VARCHAR(255),
    CONSTRAINT pk_diagnosis PRIMARY KEY (Diagnosis_ID)
);

-- ============================================================
-- 7. APPOINTMENT_DIAGNOSIS (junction table)
-- ============================================================
CREATE TABLE Appointment_Diagnosis (
    Appointment_ID  INT NOT NULL,
    Diagnosis_ID    INT NOT NULL,
    CONSTRAINT pk_appt_diag     PRIMARY KEY (Appointment_ID, Diagnosis_ID),
    CONSTRAINT fk_ad_appt       FOREIGN KEY (Appointment_ID)   REFERENCES Appointment(Appointment_ID),
    CONSTRAINT fk_ad_diag       FOREIGN KEY (Diagnosis_ID)     REFERENCES Diagnosis(Diagnosis_ID)
);

-- ============================================================
-- 8. PRESCRIPTION
-- ============================================================
CREATE TABLE Prescription (
    Prescription_ID     INT     NOT NULL AUTO_INCREMENT,
    Appointment_ID      INT     NOT NULL,
    Prescription_Date   DATE    NOT NULL,
    Notes               VARCHAR(255),
    CONSTRAINT pk_prescription  PRIMARY KEY (Prescription_ID),
    CONSTRAINT fk_presc_appt    FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID)
);

-- ============================================================
-- 9. MEDICINE
-- ============================================================
CREATE TABLE Medicine (
    Medicine_ID     INT             NOT NULL AUTO_INCREMENT,
    Medicine_Name   VARCHAR(100)    NOT NULL,
    Description     VARCHAR(255),
    Unit_Price      DECIMAL(10,2)   NOT NULL,
    CONSTRAINT pk_medicine PRIMARY KEY (Medicine_ID)
);

-- ============================================================
-- 10. PRESCRIPTION_ITEM
-- ============================================================
CREATE TABLE Prescription_Item (
    Prescription_Item_ID    INT             NOT NULL AUTO_INCREMENT,
    Prescription_ID         INT             NOT NULL,
    Medicine_ID             INT             NOT NULL,
    Quantity                INT             NOT NULL,
    Dosage                  VARCHAR(50),
    Frequency               VARCHAR(50),
    Route                   VARCHAR(50),
    Duration                VARCHAR(50),
    CONSTRAINT pk_presc_item        PRIMARY KEY (Prescription_Item_ID),
    CONSTRAINT fk_pi_prescription   FOREIGN KEY (Prescription_ID)   REFERENCES Prescription(Prescription_ID),
    CONSTRAINT fk_pi_medicine       FOREIGN KEY (Medicine_ID)       REFERENCES Medicine(Medicine_ID)
);

-- ============================================================
-- 11. FOLLOW_UP
-- ============================================================
CREATE TABLE Follow_Up (
    Followup_ID     INT             NOT NULL AUTO_INCREMENT,
    Appointment_ID  INT             NOT NULL,
    Followup_Date   DATE            NOT NULL,
    Notes           VARCHAR(255),
    Status          VARCHAR(20)     DEFAULT 'Pending',
    CONSTRAINT pk_followup      PRIMARY KEY (Followup_ID),
    CONSTRAINT fk_fu_appt       FOREIGN KEY (Appointment_ID) REFERENCES Appointment(Appointment_ID),
    CONSTRAINT chk_fu_status    CHECK (Status IN ('Pending','Completed','Cancelled'))
);
