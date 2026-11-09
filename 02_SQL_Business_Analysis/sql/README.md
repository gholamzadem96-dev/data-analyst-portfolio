
====================================================
PROJECT 03: HEALTHCARE OPERATIONS ANALYSIS
Database: SQLite
Dataset: Synthetic Healthcare Operations Data
Year: 2025

Tables:
1. Departments
2. Doctors
3. Patients
4. Appointments
5. Visits
6. Payments

Analysis Areas:
1. Department Performance
2. Waiting Time Analysis
3. Consultation Duration Analysis
4. Monthly Appointment Trends
5. Booking Channel Performance
6. Appointment Type Performance
7. Payment Method Analysis
8. Patient Age Group Analysis
9. Patient Distribution by City
10. Doctor Performance Analysis
11. Data Quality Checks

Note: This project uses synthetic data for portfolio demonstration.
====================================================
*/


-- ==================================================
-- 1. DEPARTMENT PERFORMANCE
-- ==================================================

SELECT
    D.Department_Name,
    COUNT(A.Appointment_ID) AS Total_Appointments,
    SUM(CASE
        WHEN A.Appointment_Status = 'Completed' THEN 1
        ELSE 0
    END) AS Completed_Appointments,
    ROUND(
        SUM(CASE
            WHEN A.Appointment_Status = 'Completed' THEN 1.0
            ELSE 0
        END) * 100.0 / COUNT(A.Appointment_ID),
        2
    ) AS Completion_Rate
FROM Departments D
JOIN Doctors DR
    ON D.Department_ID = DR.Department_ID
JOIN Appointments A
    ON DR.Doctor_ID = A.Doctor_ID
GROUP BY D.Department_ID, D.Department_Name
ORDER BY Completion_Rate DESC;


-- ==================================================
-- 2. WAITING TIME ANALYSIS
-- Waiting time = Consultation start - Check-in
-- ==================================================

SELECT
    D.Department_Name,
    COUNT(V.Visit_ID) AS Total_Visits,
    ROUND(
        AVG(
            (strftime('%s', V.Consultation_Start_Time) -
             strftime('%s', V.Check_In_Time)) / 60.0
        ),
        2
    ) AS Average_Waiting_Time_Minutes
FROM Departments D
JOIN Doctors DR
    ON D.Department_ID = DR.Department_ID
JOIN Appointments A
    ON DR.Doctor_ID = A.Doctor_ID
JOIN Visits V
    ON A.Appointment_ID = V.Appointment_ID
WHERE V.Check_In_Time IS NOT NULL
  AND V.Consultation_Start_Time IS NOT NULL
GROUP BY D.Department_ID, D.Department_Name
ORDER BY Average_Waiting_Time_Minutes DESC;


-- ==================================================
-- 3. CONSULTATION DURATION ANALYSIS
-- Duration = Consultation end - Consultation start
-- ==================================================

SELECT
    D.Department_Name,
    COUNT(V.Visit_ID) AS Total_Visits,
    ROUND(
        AVG(
            (strftime('%s', V.Consultation_End_Time) -
             strftime('%s', V.Consultation_Start_Time)) / 60.0
        ),
        2
    ) AS Average_Consultation_Duration_Minutes
FROM Departments D
JOIN Doctors DR
    ON D.Department_ID = DR.Department_ID
JOIN Appointments A
    ON DR.Doctor_ID = A.Doctor_ID
JOIN Visits V
    ON A.Appointment_ID = V.Appointment_ID
WHERE V.Consultation_Start_Time IS NOT NULL
  AND V.Consultation_End_Time IS NOT NULL
GROUP BY D.Department_ID, D.Department_Name
ORDER BY Average_Consultation_Duration_Minutes DESC;


-- ==================================================
-- 4. MONTHLY APPOINTMENT TRENDS
-- ==================================================

SELECT
    strftime('%Y-%m', Appointment_Date) AS Appointment_Month,
    COUNT(Appointment_ID) AS Total_Appointments,
    SUM(CASE
        WHEN Appointment_Status = 'Completed' THEN 1
        ELSE 0
    END) AS Completed_Appointments,
    ROUND(
        SUM(CASE
            WHEN Appointment_Status = 'Completed' THEN 1.0
            ELSE 0
        END) * 100.0 / COUNT(Appointment_ID),
        2
    ) AS Completion_Rate
FROM Appointments
GROUP BY strftime('%Y-%m', Appointment_Date)
ORDER BY Appointment_Month;


-- ==================================================
-- 5. BOOKING CHANNEL PERFORMANCE
-- ==================================================

SELECT
    Booking_Channel,
    COUNT(Appointment_ID) AS Total_Appointments,
    SUM(CASE
        WHEN Appointment_Status = 'Completed' THEN 1
        ELSE 0
    END) AS Completed_Appointments,
    ROUND(
        SUM(CASE
            WHEN Appointment_Status = 'Completed' THEN 1.0
            ELSE 0
        END) * 100.0 / COUNT(Appointment_ID),
        2
    ) AS Completion_Rate
FROM Appointments
GROUP BY Booking_Channel
ORDER BY Completion_Rate DESC;


-- ==================================================
-- 6. APPOINTMENT TYPE PERFORMANCE
-- ==================================================

SELECT
    Appointment_Type,
    COUNT(Appointment_ID) AS Total_Appointments,
    SUM(CASE
        WHEN Appointment_Status = 'Completed' THEN 1
        ELSE 0
    END) AS Completed_Appointments,
    ROUND(
        SUM(CASE
            WHEN Appointment_Status = 'Completed' THEN 1.0
            ELSE 0
        END) * 100.0 / COUNT(Appointment_ID),
        2
    ) AS Completion_Rate
FROM Appointments
GROUP BY Appointment_Type
ORDER BY Completion_Rate DESC;


-- ==================================================
-- 7. PAYMENT METHOD ANALYSIS
-- Revenue includes only payments marked as Paid.
-- ==================================================

SELECT
    Payment_Method,
    COUNT(Payment_ID) AS Total_Transactions,
    SUM(CASE
        WHEN Payment_Status = 'Paid' THEN 1
        ELSE 0
    END) AS Paid_Transactions,
    ROUND(
        SUM(CASE
            WHEN Payment_Status = 'Paid' THEN Payment_Amount
            ELSE 0
        END),
        2
    ) AS Total_Revenue
FROM Payments
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;


-- ==================================================
-- 8. PATIENT AGE GROUP ANALYSIS
-- ==================================================

SELECT
    CASE
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END AS Age_Group,
    COUNT(Patient_ID) AS Total_Patients,
    ROUND(AVG(Age), 1) AS Average_Age
FROM Patients
GROUP BY
    CASE
        WHEN Age < 18 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END
ORDER BY
    CASE Age_Group
        WHEN 'Under 18' THEN 1
        WHEN '18-30' THEN 2
        WHEN '31-45' THEN 3
        WHEN '46-60' THEN 4
        ELSE 5
    END;


-- ==================================================
-- 9. PATIENT DISTRIBUTION BY CITY
-- ==================================================

SELECT
    City,
    COUNT(Patient_ID) AS Total_Patients,
    ROUND(
        COUNT(Patient_ID) * 100.0 /
        (SELECT COUNT(*) FROM Patients),
        2
    ) AS Patient_Percentage
FROM Patients
GROUP BY City
ORDER BY Total_Patients DESC;


-- ==================================================
-- 10. DOCTOR PERFORMANCE ANALYSIS
-- ==================================================

SELECT
    DR.Doctor_Name,
    D.Department_Name,
    COUNT(A.Appointment_ID) AS Total_Appointments,
    SUM(
        CASE
            WHEN A.Appointment_Status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS Completed_Appointments,
    ROUND(
        SUM(
            CASE
                WHEN A.Appointment_Status = 'Completed' THEN 1.0
                ELSE 0
            END
        ) * 100.0 / COUNT(A.Appointment_ID),
        2
    ) AS Completion_Rate
FROM Doctors DR
JOIN Departments D
    ON DR.Department_ID = D.Department_ID
JOIN Appointments A
    ON DR.Doctor_ID = A.Doctor_ID
GROUP BY
    DR.Doctor_ID,
    DR.Doctor_Name,
    D.Department_Name
ORDER BY Completion_Rate DESC;


-- ==================================================
-- 11. DATA QUALITY CHECKS
-- Each query should return zero rows or zero count
-- when the corresponding check passes.
-- ==================================================

-- Check 1: Completed appointments without a visit
SELECT
    A.Appointment_ID
FROM Appointments A
LEFT JOIN Visits V
    ON A.Appointment_ID = V.Appointment_ID
WHERE A.Appointment_Status = 'Completed'
  AND V.Visit_ID IS NULL;


-- Check 2: Visits linked to appointments not marked Completed
SELECT
    V.Visit_ID,
    V.Appointment_ID,
    A.Appointment_Status
FROM Visits V
JOIN Appointments A
    ON V.Appointment_ID = A.Appointment_ID
WHERE A.Appointment_Status <> 'Completed';


-- Check 3: Payments linked to appointments not marked Completed
SELECT
    P.Payment_ID,
    P.Appointment_ID,
    A.Appointment_Status
FROM Payments P
JOIN Appointments A
    ON P.Appointment_ID = A.Appointment_ID
WHERE A.Appointment_Status <> 'Completed';


-- Check 4: Duplicate payment records per appointment
SELECT
    Appointment_ID,
    COUNT(*) AS Payment_Count
FROM Payments
GROUP BY Appointment_ID
HAVING COUNT(*) > 1;


-- Check 5: Duplicate visit records per appointment
SELECT
    Appointment_ID,
    COUNT(*) AS Visit_Count
FROM Visits
GROUP BY Appointment_ID
HAVING COUNT(*) > 1;


-- Check 6: Foreign key integrity
PRAGMA foreign_key_check;


-- Check 7: Invalid payment records
SELECT
    Payment_ID,
    Appointment_ID,
    Payment_Amount,
    Payment_Date,
    Payment_Method,
    Payment_Status
FROM Payments
WHERE Payment_Amount IS NULL
   OR Payment_Amount <= 0
   OR Payment_Date IS NULL
   OR Payment_Method IS NULL
   OR Payment_Status IS NULL;


-- Check 8: Invalid visit timings
SELECT
    Visit_ID,
    Check_In_Time,
    Consultation_Start_Time,
    Consultation_End_Time
FROM Visits
WHERE Check_In_Time IS NULL
   OR Consultation_Start_Time IS NULL
   OR Consultation_End_Time IS NULL
   OR strftime('%s', Consultation_Start_Time) <
      strftime('%s', Check_In_Time)
   OR strftime('%s', Consultation_End_Time) <
      strftime('%s', Consultation_Start_Time);
