SELECT p.provider_name,
       COUNT(*) AS total_appointments,
       SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
       ROUND(100.0 * SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate
FROM appointments a
JOIN providers p ON a.provider_id = p.provider_id
GROUP BY p.provider_name
ORDER BY no_show_rate DESC;



SELECT pr.specialty,
       ROUND(AVG(v.visit_minutes), 1) AS avg_visit_minutes
FROM visits v
JOIN providers pr ON v.provider_id = pr.provider_id
GROUP BY pr.specialty
ORDER BY avg_visit_minutes DESC;



SELECT city,
       COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;
SELECT d.icd10_code,
       d.diagnosis_description,
       COUNT(*) AS diagnosis_count
FROM diagnoses d
GROUP BY d.icd10_code, d.diagnosis_description
ORDER BY diagnosis_count DESC
LIMIT 10;



SELECT c.primary_payer,
       ROUND(SUM(c.paid_amount), 2) AS total_paid,
       ROUND(SUM(c.billed_amount), 2) AS total_billed,
       ROUND(SUM(c.write_off), 2) AS total_write_off
FROM claims c
GROUP BY c.primary_payer
ORDER BY total_paid DESC;



SELECT city,
       COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;



SELECT p.provider_name,
       COUNT(*) AS total_appointments,
       SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
       ROUND(100.0 * SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate
FROM appointments a
JOIN providers p ON a.provider_id = p.provider_id
GROUP BY p.provider_name
ORDER BY no_show_rate DESC;



SELECT pr.specialty,
       ROUND(AVG(v.visit_minutes), 1) AS avg_visit_minutes
FROM visits v
JOIN providers pr ON v.provider_id = pr.provider_id
GROUP BY pr.specialty
ORDER BY avg_visit_minutes DESC;



SELECT d.icd10_code,
       d.diagnosis_description,
       COUNT(*) AS diagnosis_count
FROM diagnoses d
GROUP BY d.icd10_code, d.diagnosis_description
ORDER BY diagnosis_count DESC
LIMIT 10;



SELECT c.primary_payer,
       ROUND(SUM(c.paid_amount), 2) AS total_paid,
       ROUND(SUM(c.billed_amount), 2) AS total_billed,
       ROUND(SUM(c.write_off), 2) AS total_write_off
FROM claims c
GROUP BY c.primary_payer
ORDER BY total_paid DESC;


SELECT city,
       COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;


SELECT 'patients' t, COUNT(*) c FROM patients UNION ALL
SELECT 'providers', COUNT(*) FROM providers UNION ALL
SELECT 'appointments', COUNT(*) FROM appointments UNION ALL
SELECT 'visits', COUNT(*) FROM visits UNION ALL
SELECT 'diagnoses', COUNT(*) FROM diagnoses UNION ALL
SELECT 'claims', COUNT(*) FROM claims;




SELECT * FROM patients LIMIT 10;
SELECT * FROM providers LIMIT 10;
SELECT * FROM appointments LIMIT 10;
SELECT * FROM visits LIMIT 10;
SELECT * FROM diagnoses LIMIT 10;
SELECT * FROM claims LIMIT 10;



-- Count patients by sex
SELECT sex, COUNT(*) FROM patients GROUP BY sex;

-- Count providers by specialty
SELECT specialty, COUNT(*) FROM providers GROUP BY specialty;




-- Show the first 20 appointments with patient + provider info
SELECT a.appointment_id, p.first_name, p.last_name, pr.provider_name, a.status, a.scheduled_date
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN providers pr ON a.provider_id = pr.provider_id
LIMIT 20;


--  Most common diagnosis codes
SELECT d.icd10_code, d.diagnosis_description, COUNT(*) AS diagnosis_count
FROM diagnoses d
GROUP BY d.icd10_code, d.diagnosis_description
ORDER BY diagnosis_count DESC
LIMIT 10;



-- Top 5 cities by claims billed
SELECT p.city, ROUND(SUM(c.billed_amount),2) AS total_billed
FROM claims c
JOIN patients p ON c.patient_id = p.patient_id
GROUP BY p.city
ORDER BY total_billed DESC
LIMIT 5;


--  Average appointment duration by specialty
SELECT pr.specialty, ROUND(AVG(a.duration_minutes),1) AS avg_duration
FROM appointments a
JOIN providers pr ON a.provider_id = pr.provider_id
GROUP BY pr.specialty
ORDER BY avg_duration DESC;



SELECT * FROM patients    LIMIT 10;
SELECT * FROM providers   LIMIT 10;
SELECT * FROM appointments LIMIT 10;
SELECT * FROM visits      LIMIT 10;
SELECT * FROM diagnoses   LIMIT 10;
SELECT * FROM claims      LIMIT 10;



SELECT
    CASE 
        WHEN age < 18 THEN 'Child'
        WHEN age BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN age BETWEEN 36 AND 55 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY age_group
ORDER BY patient_count DESC;



SELECT 
    status,
    COUNT(*) AS total_appointments,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM appointments),
        2
    ) AS percentage
FROM appointments
GROUP BY status;



SELECT 
    pr.specialty,
    ROUND(AVG(a.duration_minutes), 2) AS avg_duration
FROM appointments a
JOIN providers pr 
    ON a.provider_id = pr.provider_id
GROUP BY pr.specialty
ORDER BY avg_duration DESC;



SELECT * FROM patients LIMIT 10;
SELECT * FROM providers LIMIT 10;
SELECT * FROM appointments LIMIT 10;
SELECT * FROM visits LIMIT 10;
SELECT * FROM diagnoses LIMIT 10;
SELECT * FROM claims LIMIT 10;



SELECT
    CASE 
        WHEN age < 18 THEN 'Child'
        WHEN age BETWEEN 18 AND 35 THEN 'Young Adult'
        WHEN age BETWEEN 36 AND 55 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY age_group
ORDER BY patient_count DESC;




-- Preview 10 rows from each table
SELECT * FROM patients LIMIT 10;

SELECT * FROM providers LIMIT 10;

SELECT * FROM appointments LIMIT 10;

SELECT * FROM visits LIMIT 10;

SELECT * FROM diagnoses LIMIT 10;

SELECT * FROM claims LIMIT 10;



SELECT city, 
       COUNT(*) AS patient_count
FROM patients
GROUP BY city
ORDER BY patient_count DESC;



SELECT pr.specialty,
       ROUND(AVG(a.duration_minutes), 2) AS avg_duration
FROM appointments a
JOIN providers pr 
    ON a.provider_id = pr.provider_id
GROUP BY pr.specialty
ORDER BY avg_duration DESC;



SELECT 
    primary_payer,
    SUM(billed_amount) AS total_billed,
    SUM(paid_amount) AS total_paid,
    SUM(billed_amount - paid_amount) AS total_unpaid
FROM claims
GROUP BY primary_payer
ORDER BY total_paid DESC;



SELECT 
    icd10_code,
    diagnosis_description,
    COUNT(*) AS diagnosis_count
FROM diagnoses
GROUP BY icd10_code, diagnosis_description
ORDER BY diagnosis_count DESC
LIMIT 10;



SELECT 
  status,
  COUNT(*) AS total_appointments,
  ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM appointments), 2) AS pct
FROM appointments
GROUP BY status
ORDER BY pct DESC;


SELECT 
  p.provider_name,
  COUNT(*) AS total_appts,
  SUM(CASE WHEN a.status='No-Show' THEN 1 ELSE 0 END) AS no_shows,
  ROUND(100.0 * SUM(CASE WHEN a.status='No-Show' THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_pct
FROM appointments a
JOIN providers p ON p.provider_id = a.provider_id
GROUP BY p.provider_name
ORDER BY no_show_rate_pct DESC;
