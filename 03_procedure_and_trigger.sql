-- ============================================================
-- Crownfield Eye Hospital - Ophthalmology Database
-- 03_procedure_and_trigger.sql - Part C: Queries 5-6
-- ============================================================

USE crownfield_eye_hospital;

-- ============================================================
-- QUERY 5: Stored Procedure with input parameter
-- Question: Retrieve all appointment details for a given patient ID.
-- ============================================================
DELIMITER $$

CREATE PROCEDURE GetPatientAppointments(IN p_patient_id VARCHAR(10))
BEGIN
    SELECT
        a.Appointment_ID,
        a.Appointment_Date,
        CONCAT(cl.First_Name, ' ', cl.Last_Name)    AS Clinician_Name,
        sp.Specialty_Name,
        cli.Clinic_Name,
        a.Status,
        fu.Followup_Date,
        fu.Status                                   AS Followup_Status
    FROM Appointment a
    JOIN Clinician   cl  ON a.Clinician_ID  = cl.Clinician_ID
    JOIN Specialty   sp  ON cl.Specialty_ID = sp.Specialty_ID
    JOIN Clinic      cli ON a.Clinic_ID     = cli.Clinic_ID
    LEFT JOIN Follow_Up fu ON a.Appointment_ID = fu.Appointment_ID
    WHERE a.Patient_ID = p_patient_id
    ORDER BY a.Appointment_Date;
END$$

DELIMITER ;

-- Test the procedure:
CALL GetPatientAppointments('OP001');

-- ============================================================
-- QUERY 6: Trigger to enforce a business rule
-- Business rule: When a new appointment is inserted with status
-- 'Completed', automatically create a follow-up record with
-- status 'Pending' and a default follow-up date of 6 weeks later.
-- ============================================================
DELIMITER $$

CREATE TRIGGER trg_auto_followup
AFTER INSERT ON Appointment
FOR EACH ROW
BEGIN
    IF NEW.Status = 'Completed' THEN
        INSERT INTO Follow_Up (Appointment_ID, Followup_Date, Notes, Status)
        VALUES (
            NEW.Appointment_ID,
            DATE_ADD(NEW.Appointment_Date, INTERVAL 6 WEEK),
            'Auto-generated follow-up from completed appointment',
            'Pending'
        );
    END IF;
END$$

DELIMITER ;

-- Test the trigger by inserting a completed appointment:
INSERT INTO Appointment (Patient_ID, Clinic_ID, Clinician_ID, Appointment_Date, Status)
VALUES ('OP010', 1, 1, '2026-10-20 10:00:00', 'Completed');

-- Verify the follow-up was automatically created:
SELECT * FROM Follow_Up WHERE Appointment_ID = LAST_INSERT_ID();
