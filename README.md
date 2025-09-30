# Healthcare SQL Project
A full healthcare SQL project where I designed tables, loaded CSV data, and ran analytical queries in PostgreSQL.

## 📂 Project Files
- `patients.csv` – patient demographics and insurance payer  
- `providers.csv` – provider details and specialties  
- `appointments.csv` – scheduled visits, statuses, and duration  
- `visits.csv` – details about completed visits  
- `diagnoses.csv` – ICD codes and descriptions  
- `claims.csv` – billed, paid, and write-off amounts  
- `analysis_queries_postgres.sql` – SQL queries used for analysis  

## 🔍 Key Analyses
1. **Patient Demographics**
   - Top cities by patient count → *Decatur (14), Sandy Springs (12), Smyrna (12)*  

2. **Appointments**
   - Appointment statuses (% Completed, No-Show, Canceled)  
   - Provider no-show rates → *Highest: Dr. Sophia Garcia (16.7%)*  
   - Average appointment duration by specialty  

3. **Financial Analysis**
   - Total billed, paid, and write-offs by payer  
   - Claims summary by patient and provider 
   - Example: Top payer "Blue Cross" billed $X, paid $Y, with $Z in wrie-offs* 

4. **Diagnoses**
   - Most common ICD-10 diagnosis codes  
   - Frequency of diagnoses across visits
   -  Example: *Top code M54.5( Low back pain) appeared in 42 visits*  

## 📊 Example Query
```sql
SELECT p.provider_name,
       COUNT(*) AS total_appts,
       SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) AS no_shows,
       ROUND(100.0 * SUM(CASE WHEN a.status = 'No-Show' THEN 1 ELSE 0 END) / COUNT(*), 2) AS no_show_rate_pct
FROM appointments a
JOIN providers p ON a.provider_id = p.provider_id
GROUP BY p.provider_name
ORDER BY no_show_rate_pct DESC;
