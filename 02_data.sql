-- ============================================================
-- Crownfield Eye Hospital - Ophthalmology Database
-- 02_data.sql - INSERT synthetic data (10+ records per table)
-- ============================================================

USE crownfield_eye_hospital;

-- ============================================================
-- CLINIC
-- ============================================================
INSERT INTO Clinic (Clinic_Name, Address, Phone_Number) VALUES
('City Road Eye Clinic',        '162 City Road, London EC1V 2PD',       '020 7253 3411'),
('Bedford Eye Clinic',          '15 Kimbolton Road, Bedford MK40 2NT',  '01234 355122'),
('Croydon Eye Clinic',          '530 London Road, Croydon CR7 7YE',     '020 8401 3000'),
('Moorfields West End',         '98 Judd Street, London WC1H 9DN',      '020 7253 3411'),
('Kings Cross Ophthalmology',   '1 Euston Road, London NW1 2SD',        '020 7391 1200'),
('Stratford Eye Unit',          '12 Broadway, London E15 4BQ',          '020 8522 4000'),
('Hammersmith Clinic',          '72 Du Cane Road, London W12 0HS',      '020 8383 1000'),
('Southwark Vision Centre',     '55 Peckham Road, London SE5 8UH',      '020 7703 5100'),
('Hackney Eye Services',        '30 Morning Lane, London E9 6NA',       '020 8510 5555'),
('Greenwich Ophthalmology',     '20 Woolwich Road, London SE10 0JL',    '020 8836 6000');

-- ============================================================
-- SPECIALTY
-- ============================================================
INSERT INTO Specialty (Specialty_Name, Description) VALUES
('Glaucoma',            'Diagnosis and management of glaucoma and ocular hypertension'),
('Retina',              'Medical and surgical retinal diseases including macular degeneration'),
('Cornea',              'Corneal diseases, transplants and refractive conditions'),
('Oculoplastics',       'Eyelid, orbit and lacrimal surgery'),
('Paediatric',          'Eye conditions in children and young adults'),
('Neuro-Ophthalmology', 'Visual disturbances related to neurological conditions'),
('Cataract',            'Diagnosis and surgical removal of cataracts'),
('Uveitis',             'Inflammatory eye diseases'),
('Low Vision',          'Rehabilitation for patients with significant sight loss'),
('General Ophthalmology','Broad ophthalmic assessment and referral');

-- ============================================================
-- PATIENT
-- ============================================================
INSERT INTO Patient (Patient_ID, First_Name, Last_Name, Date_Of_Birth, Phone_Number, Email) VALUES
('OP001', 'Amina',    'Yusuf',    '1985-03-12', '07700900001', 'amina.yusuf@email.com'),
('OP002', 'Daniel',   'Reed',     '1973-07-24', '07700900002', 'daniel.reed@email.com'),
('OP003', 'Sofia',    'Bennett',  '1990-11-05', '07700900003', 'sofia.bennett@email.com'),
('OP004', 'Michael',  'Okoro',    '1968-02-18', '07700900004', 'michael.okoro@email.com'),
('OP005', 'Priya',    'Sharma',   '1995-06-30', '07700900005', 'priya.sharma@email.com'),
('OP006', 'James',    'Walker',   '1952-09-14', '07700900006', 'james.walker@email.com'),
('OP007', 'Fatima',   'Al-Hassan','1980-01-22', '07700900007', 'fatima.alhassan@email.com'),
('OP008', 'Robert',   'Chen',     '1964-12-03', '07700900008', 'robert.chen@email.com'),
('OP009', 'Grace',    'Okonkwo',  '2001-04-17', '07700900009', 'grace.okonkwo@email.com'),
('OP010', 'Thomas',   'Murray',   '1977-08-29', '07700900010', 'thomas.murray@email.com'),
('OP011', 'Layla',    'Hassan',   '1988-05-11', '07700900011', 'layla.hassan@email.com'),
('OP012', 'David',    'Patel',    '1971-10-07', '07700900012', 'david.patel@email.com');

-- ============================================================
-- CLINICIAN
-- ============================================================
INSERT INTO Clinician (Specialty_ID, Clinic_ID, First_Name, Last_Name, Phone_Number, Email) VALUES
(1, 1, 'Maya',    'Shah',     '07800100001', 'maya.shah@crownfield.nhs.uk'),
(2, 1, 'Leo',     'Grant',    '07800100002', 'leo.grant@crownfield.nhs.uk'),
(3, 3, 'Priya',   'Nair',     '07800100003', 'priya.nair@crownfield.nhs.uk'),
(4, 4, 'James',   'Obi',      '07800100004', 'james.obi@crownfield.nhs.uk'),
(5, 5, 'Sarah',   'Williams', '07800100005', 'sarah.williams@crownfield.nhs.uk'),
(6, 6, 'Ahmed',   'Khalil',   '07800100006', 'ahmed.khalil@crownfield.nhs.uk'),
(7, 2, 'Rachel',  'Moore',    '07800100007', 'rachel.moore@crownfield.nhs.uk'),
(8, 7, 'Tariq',   'Hussain',  '07800100008', 'tariq.hussain@crownfield.nhs.uk'),
(1, 2, 'Claire',  'Fox',      '07800100009', 'claire.fox@crownfield.nhs.uk'),
(2, 8, 'Samuel',  'Adeyemi',  '07800100010', 'samuel.adeyemi@crownfield.nhs.uk'),
(3, 9, 'Nina',    'Petrov',   '07800100011', 'nina.petrov@crownfield.nhs.uk'),
(10,10, 'Owen',   'Davies',   '07800100012', 'owen.davies@crownfield.nhs.uk');

-- ============================================================
-- APPOINTMENT
-- ============================================================
INSERT INTO Appointment (Patient_ID, Clinic_ID, Clinician_ID, Appointment_Date, Status) VALUES
('OP001', 1,  1,  '2026-10-05 09:00:00', 'Completed'),
('OP002', 1,  2,  '2026-10-05 09:30:00', 'Completed'),
('OP001', 2,  1,  '2026-11-16 10:15:00', 'Scheduled'),
('OP003', 1,  1,  '2026-10-06 11:00:00', 'Completed'),
('OP004', 3,  3,  '2026-10-07 14:00:00', 'Completed'),
('OP005', 4,  4,  '2026-10-08 10:00:00', 'Completed'),
('OP006', 5,  5,  '2026-10-09 13:30:00', 'Completed'),
('OP007', 1,  2,  '2026-10-10 09:00:00', 'Completed'),
('OP008', 6,  6,  '2026-10-11 11:30:00', 'Completed'),
('OP009', 7,  7,  '2026-10-12 14:00:00', 'Scheduled'),
('OP010', 2,  9,  '2026-10-13 09:45:00', 'Completed'),
('OP011', 8, 10,  '2026-10-14 10:30:00', 'Completed'),
('OP012', 9, 11,  '2026-10-15 15:00:00', 'No-Show'),
('OP005', 1,  8,  '2026-10-16 11:00:00', 'Completed');

-- ============================================================
-- DIAGNOSIS
-- ============================================================
INSERT INTO Diagnosis (Diagnosis_Name, Description) VALUES
('Ocular Hypertension',         'Raised intraocular pressure without optic nerve damage'),
('Diabetic Macular Oedema',     'Fluid accumulation in the macula due to diabetic retinopathy'),
('Glaucoma Suspect',            'Elevated IOP or suspicious disc; not confirmed glaucoma'),
('Keratoconus',                 'Progressive thinning and cone-shaped deformity of the cornea'),
('Age-related Macular Degeneration', 'Deterioration of the central portion of the retina'),
('Ptosis',                      'Drooping of the upper eyelid'),
('Amblyopia',                   'Reduced vision in one eye due to abnormal visual development'),
('Optic Neuritis',              'Inflammation of the optic nerve'),
('Dry Eye Syndrome',            'Insufficient tear production or poor tear quality'),
('Retinal Detachment',          'Separation of the retina from the underlying tissue'),
('Cataract',                    'Clouding of the natural lens of the eye'),
('Uveitis',                     'Inflammation of the uveal tract');

-- ============================================================
-- APPOINTMENT_DIAGNOSIS
-- ============================================================
INSERT INTO Appointment_Diagnosis (Appointment_ID, Diagnosis_ID) VALUES
(1,  1),
(2,  2),
(3,  1),
(4,  3),
(5,  4),
(6,  6),
(7,  7),
(8,  2),
(9,  8),
(10, 11),
(11, 1),
(12, 2),
(14, 12);

-- ============================================================
-- MEDICINE
-- ============================================================
INSERT INTO Medicine (Medicine_Name, Description, Unit_Price) VALUES
('Latanoprost',             'Prostaglandin analogue eye drops for glaucoma',         12.50),
('Timolol',                 'Beta-blocker eye drops to reduce intraocular pressure', 8.75),
('Aflibercept',             'Anti-VEGF injection for macular degeneration/DMO',      800.00),
('Sodium Chloride Drops',   'Saline eye drops for corneal oedema',                  5.00),
('Prednisolone',            'Corticosteroid eye drops for inflammation',             9.20),
('Dexamethasone',           'Corticosteroid for ocular inflammation',               11.00),
('Brimonidine',             'Alpha agonist eye drops to lower IOP',                 14.30),
('Dorzolamide',             'Carbonic anhydrase inhibitor for IOP reduction',       17.50),
('Cyclopentolate',          'Anticholinergic drops for pupil dilation',             6.80),
('Ranibizumab',             'Anti-VEGF injection for wet AMD',                      742.00),
('Lubricant Eye Drops',     'Artificial tears for dry eye syndrome',                4.50),
('Acetazolamide',           'Oral carbonic anhydrase inhibitor for acute glaucoma', 3.90);

-- ============================================================
-- PRESCRIPTION
-- ============================================================
INSERT INTO Prescription (Appointment_ID, Prescription_Date, Notes) VALUES
(1,  '2026-10-05', 'Review IOP at next appointment'),
(2,  '2026-10-05', 'OCT scan required before next review'),
(4,  '2026-10-06', 'Monitor visual fields'),
(5,  '2026-10-07', 'Corneal topography to be arranged'),
(6,  '2026-10-08', 'Eyelid surgery discussed'),
(7,  '2026-10-09', 'Patching therapy to continue'),
(8,  '2026-10-10', 'Intravitreal injection scheduled'),
(9,  '2026-10-11', 'MRI brain referral made'),
(11, '2026-10-13', 'IOP recheck in 6 weeks'),
(12, '2026-10-14', 'Second injection planned'),
(14, '2026-10-16', 'Steroid taper over 4 weeks');

-- ============================================================
-- PRESCRIPTION_ITEM
-- ============================================================
INSERT INTO Prescription_Item (Prescription_ID, Medicine_ID, Quantity, Dosage, Frequency, Route, Duration) VALUES
(1,  1,  1, '0.005%',   'Once daily',   'Topical', '3 months'),
(1,  2,  1, '0.5%',     'Twice daily',  'Topical', '3 months'),
(2,  3,  1, '2mg/0.05ml','Single dose', 'Intravitreal', '1 injection'),
(3,  1,  1, '0.005%',   'Once daily',   'Topical', '12 weeks'),
(4,  4,  1, '0.9%',     'Four times daily','Topical','8 weeks'),
(5,  5,  1, '1%',       'Four times daily','Topical','2 weeks'),
(6,  7,  1, '0.2%',     'Three times daily','Topical','6 weeks'),
(7,  6,  1, '0.1%',     'Four times daily','Topical','4 weeks'),
(8,  3,  1, '2mg/0.05ml','Single dose', 'Intravitreal', '1 injection'),
(9,  11, 2, 'Standard', 'Four times daily','Topical','Ongoing'),
(10, 1,  1, '0.005%',   'Once daily',   'Topical', '6 weeks'),
(11, 3,  1, '2mg/0.05ml','Single dose', 'Intravitreal', '1 injection');

-- ============================================================
-- FOLLOW_UP
-- ============================================================
INSERT INTO Follow_Up (Appointment_ID, Followup_Date, Notes, Status) VALUES
(1,  '2026-11-16', 'Review IOP, visual field test',         'Pending'),
(2,  '2026-11-02', 'OCT before review - urgent',            'Completed'),
(4,  '2027-04-06', 'Routine monitor - 26 weeks',            'Pending'),
(5,  '2026-12-02', 'Corneal topography at next visit',      'Pending'),
(6,  '2026-12-08', 'Post-operative review',                 'Pending'),
(7,  '2027-01-09', 'Vision assessment and patching review', 'Pending'),
(8,  '2026-11-07', 'Second injection appointment',          'Pending'),
(9,  '2026-11-11', 'MRI results review',                    'Pending'),
(10, '2026-12-12', 'Post-cataract surgery check',           'Pending'),
(11, '2026-11-24', 'IOP recheck',                           'Pending'),
(12, '2026-11-14', 'Third injection planned',               'Pending'),
(14, '2026-11-13', 'Steroid taper review',                  'Pending');

-- ============================================================
-- Demonstrate controlled UPDATE and DELETE (Part B requirement)
-- ============================================================

-- UPDATE: Change a follow-up status to Completed
UPDATE Follow_Up
SET Status = 'Completed', Notes = 'Patient reviewed; IOP stable'
WHERE Followup_ID = 2;

-- UPDATE: Correct a patient phone number
UPDATE Patient
SET Phone_Number = '07700999999'
WHERE Patient_ID = 'OP003';

-- DELETE: Remove a no-show appointment's follow-up safely
-- (Appointment 13 was a no-show, no prescription or diagnosis linked)
DELETE FROM Follow_Up
WHERE Appointment_ID = 13;
