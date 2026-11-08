-- ============================================================
-- Crownfield Eye Hospital - Ophthalmology Database
-- 04_security.sql - Part D: Roles, Privileges & Data Protection
-- ============================================================

USE crownfield_eye_hospital;

-- ============================================================
-- TASK D1: CREATE USER ACCOUNTS (4 user types)
-- ============================================================

-- Administrator: full access
CREATE USER IF NOT EXISTS 'db_admin'@'localhost'       IDENTIFIED BY 'Admin@Secure123!';

-- Doctor (Clinician): read all clinical data, insert/update appointments & prescriptions
CREATE USER IF NOT EXISTS 'db_doctor'@'localhost'      IDENTIFIED BY 'Doctor@Secure123!';

-- Receptionist: manage patients and appointments only, no clinical/prescription data
CREATE USER IF NOT EXISTS 'db_receptionist'@'localhost' IDENTIFIED BY 'Recept@Secure123!';

-- Patient: read their own appointment and follow-up data only (view-level access)
CREATE USER IF NOT EXISTS 'db_patient'@'localhost'     IDENTIFIED BY 'Patient@Secure123!';

-- ============================================================
-- TASK D1: GRANT PRIVILEGES (Least Privilege Principle)
-- ============================================================

-- ADMINISTRATOR: full privileges on all tables
GRANT ALL PRIVILEGES ON crownfield_eye_hospital.* TO 'db_admin'@'localhost';

-- DOCTOR: select all, insert/update clinical tables
GRANT SELECT ON crownfield_eye_hospital.*                       TO 'db_doctor'@'localhost';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.Appointment     TO 'db_doctor'@'localhost';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.Prescription    TO 'db_doctor'@'localhost';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.Prescription_Item TO 'db_doctor'@'localhost';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.Appointment_Diagnosis TO 'db_doctor'@'localhost';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.Follow_Up       TO 'db_doctor'@'localhost';

-- RECEPTIONIST: manage patients and appointments only
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.Patient      TO 'db_receptionist'@'localhost';
GRANT SELECT, INSERT, UPDATE ON crownfield_eye_hospital.Appointment  TO 'db_receptionist'@'localhost';
GRANT SELECT ON crownfield_eye_hospital.Clinic                        TO 'db_receptionist'@'localhost';
GRANT SELECT ON crownfield_eye_hospital.Clinician                     TO 'db_receptionist'@'localhost';
GRANT SELECT ON crownfield_eye_hospital.Specialty                     TO 'db_receptionist'@'localhost';

-- PATIENT: read-only access to appointments and follow-ups only
GRANT SELECT ON crownfield_eye_hospital.Appointment  TO 'db_patient'@'localhost';
GRANT SELECT ON crownfield_eye_hospital.Follow_Up    TO 'db_patient'@'localhost';
GRANT SELECT ON crownfield_eye_hospital.Clinic       TO 'db_patient'@'localhost';

-- Apply privilege changes immediately
FLUSH PRIVILEGES;

-- ============================================================
-- ACCESS MATRIX SUMMARY (for report reference)
-- ============================================================
-- Table                | Admin | Doctor | Receptionist | Patient
-- ---------------------|-------|--------|--------------|--------
-- Patient              |  ALL  |   S    |    S,I,U     |   -
-- Clinician            |  ALL  |   S    |      S       |   -
-- Specialty            |  ALL  |   S    |      S       |   -
-- Clinic               |  ALL  |   S    |      S       |   S
-- Appointment          |  ALL  |  S,I,U |    S,I,U     |   S
-- Appointment_Diagnosis|  ALL  |  S,I,U |      -       |   -
-- Diagnosis            |  ALL  |   S    |      -       |   -
-- Prescription         |  ALL  |  S,I,U |      -       |   -
-- Prescription_Item    |  ALL  |  S,I,U |      -       |   -
-- Medicine             |  ALL  |   S    |      -       |   -
-- Follow_Up            |  ALL  |  S,I,U |      -       |   S
-- (S=SELECT, I=INSERT, U=UPDATE, ALL=full access)

-- ============================================================
-- TASK D2: DATA PROTECTION - Hashing sensitive patient data
-- ============================================================

-- Add a password_hash column to Patient table for demonstration
ALTER TABLE Patient
ADD COLUMN Password_Hash VARCHAR(255) DEFAULT NULL;

-- Use SHA2 (256-bit) to store hashed passwords (not plaintext)
-- In production, bcrypt/argon2 via application layer is preferred;
-- SHA2 demonstrates the concept within MySQL.
UPDATE Patient SET Password_Hash = SHA2(CONCAT(Patient_ID, 'SecurePass!'), 256)
WHERE Patient_ID IN ('OP001','OP002','OP003','OP004','OP005',
                     'OP006','OP007','OP008','OP009','OP010','OP011','OP012');

-- Verify: passwords are stored as hashes, never plaintext
SELECT Patient_ID, First_Name, Last_Name, Password_Hash FROM Patient LIMIT 5;

-- ============================================================
-- TASK D2 (Optional): SQL Injection Prevention
-- ============================================================

-- VULNERABLE query (DO NOT USE - shown for demonstration only):
-- SELECT * FROM Patient WHERE Patient_ID = '' OR '1'='1';
-- This would return ALL patient records - a classic injection attack.

-- SECURE approach: use Prepared Statements
-- MySQL stored procedure with parameterised input = injection-safe:

DELIMITER $$

CREATE PROCEDURE SecureGetPatient(IN p_id VARCHAR(10))
BEGIN
    -- Input is treated as a literal value, not executable SQL
    -- This prevents injection: input 'OP001; DROP TABLE Patient;--'
    -- is safely handled as a string, not executed
    SELECT Patient_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email
    FROM Patient
    WHERE Patient_ID = p_id;
END$$

DELIMITER ;

-- Test secure procedure (safe against injection):
CALL SecureGetPatient('OP001');
