# Crownfield Eye Hospital - Ophthalmology Database
## CPU4:103 Introduction to Database - Individual Repository

### Setup Requirements
- MySQL Server 8.0+
- MySQL Workbench or any MySQL client

### File Execution Order

Run the files in this exact order:

| Order | File | Description |
|-------|------|-------------|
| 1 | `01_schema.sql` | Creates the database and all 11 tables with constraints |
| 2 | `02_data.sql` | Populates all 11 tables with synthetic sample data |
| 3 | `02_individual_queries.sql` | 4 individual SQL queries: GROUP BY+HAVING, INNER JOIN, LEFT JOIN, CTE |
| 4 | `03_procedure_and_trigger.sql` | Stored procedure with input parameter and auto follow-up trigger |
| 5 | `04_security.sql` | Creates user accounts, assigns roles/privileges, adds password hashing |

### How to Run

```sql
SOURCE 01_schema.sql;
SOURCE 02_data.sql;
SOURCE 02_individual_queries.sql;
SOURCE 03_procedure_and_trigger.sql;
SOURCE 04_security.sql;
```

### Database Schema (11 Tables)
- **Clinic** - Eye clinic locations
- **Specialty** - Medical specialties
- **Patient** - Patient records
- **Clinician** - Medical staff
- **Appointment** - Patient appointments
- **Diagnosis** - Diagnosis catalogue
- **Appointment_Diagnosis** - Many-to-many: appointments and diagnoses
- **Prescription** - Prescriptions issued per appointment
- **Medicine** - Medicine catalogue
- **Prescription_Item** - Medicines within each prescription
- **Follow_Up** - Post-appointment follow-up plans

### Assumptions
- Patient_ID uses the existing OP001 format from the unnormalised data
- Clinician_ID is auto-incremented as an integer (not tied to NHS staff numbers)
- All passwords are hashed using SHA2-256; plaintext is never stored
- The trigger in Query 6 auto-creates a follow-up only for 'Completed' appointments inserted after the trigger is active; existing data is unaffected
