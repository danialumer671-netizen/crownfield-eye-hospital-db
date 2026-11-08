-- ============================================================
-- Crownfield Eye Hospital - Ophthalmology Database
-- 02_individual_queries.sql - Part C: Queries 1-4
-- ============================================================

USE crownfield_eye_hospital;

-- ============================================================
-- QUERY 1: Aggregate with GROUP BY and HAVING
-- Question: Which clinicians have conducted more than 1 completed
--           appointment, and how many have they done?
-- ============================================================
SELECT
    c.Clinician_ID,
    CONCAT(c.First_Name, ' ', c.Last_Name)  AS Clinician_Name,
    s.Specialty_Name,
    COUNT(a.Appointment_ID)                 AS Total_Completed
FROM Appointment a
JOIN Clinician c ON a.Clinician_ID = c.Clinician_ID
JOIN Specialty  s ON c.Specialty_ID  = s.Specialty_ID
WHERE a.Status = 'Completed'
GROUP BY c.Clinician_ID, Clinician_Name, s.Specialty_Name
HAVING COUNT(a.Appointment_ID) > 1
ORDER BY Total_Completed DESC;

-- ============================================================
-- QUERY 2: INNER JOIN across 3+ related tables
-- Question: Show full appointment details including patient name,
--           clinician name, clinic name and diagnosis for all
--           completed appointments.
-- ============================================================
SELECT
    a.Appointment_ID,
    a.Appointment_Date,
    CONCAT(p.First_Name, ' ', p.Last_Name)  AS Patient_Name,
    CONCAT(cl.First_Name, ' ', cl.Last_Name) AS Clinician_Name,
    sp.Specialty_Name,
    cli.Clinic_Name,
    d.Diagnosis_Name,
    a.Status
FROM Appointment a
INNER JOIN Patient              p   ON a.Patient_ID     = p.Patient_ID
INNER JOIN Clinician            cl  ON a.Clinician_ID   = cl.Clinician_ID
INNER JOIN Specialty            sp  ON cl.Specialty_ID  = sp.Specialty_ID
INNER JOIN Clinic               cli ON a.Clinic_ID      = cli.Clinic_ID
INNER JOIN Appointment_Diagnosis ad ON a.Appointment_ID = ad.Appointment_ID
INNER JOIN Diagnosis             d  ON ad.Diagnosis_ID  = d.Diagnosis_ID
WHERE a.Status = 'Completed'
ORDER BY a.Appointment_Date;

-- ============================================================
-- QUERY 3: LEFT JOIN to reveal optional/missing data
-- Question: Which appointments do NOT have a follow-up plan?
--           (reveals optional relationship)
-- ============================================================
SELECT
    a.Appointment_ID,
    a.Appointment_Date,
    CONCAT(p.First_Name, ' ', p.Last_Name)  AS Patient_Name,
    a.Status,
    fu.Followup_ID,
    fu.Followup_Date,
    fu.Status                                AS Followup_Status
FROM Appointment a
LEFT JOIN Patient  p  ON a.Patient_ID    = p.Patient_ID
LEFT JOIN Follow_Up fu ON a.Appointment_ID = fu.Appointment_ID
WHERE fu.Followup_ID IS NULL
ORDER BY a.Appointment_Date;

-- ============================================================
-- QUERY 4: Subquery (CTE)
-- Question: Which patients have had more than one appointment,
--           and what is the total number of prescriptions issued
--           to them?
-- ============================================================
WITH Patient_Appointment_Count AS (
    SELECT
        Patient_ID,
        COUNT(Appointment_ID) AS Num_Appointments
    FROM Appointment
    GROUP BY Patient_ID
    HAVING COUNT(Appointment_ID) > 1
)
SELECT
    pac.Patient_ID,
    CONCAT(p.First_Name, ' ', p.Last_Name)  AS Patient_Name,
    pac.Num_Appointments,
    COUNT(pr.Prescription_ID)               AS Total_Prescriptions
FROM Patient_Appointment_Count pac
JOIN Patient      p  ON pac.Patient_ID    = p.Patient_ID
JOIN Appointment  a  ON pac.Patient_ID    = a.Patient_ID
LEFT JOIN Prescription pr ON a.Appointment_ID = pr.Appointment_ID
GROUP BY pac.Patient_ID, Patient_Name, pac.Num_Appointments
ORDER BY pac.Num_Appointments DESC;
