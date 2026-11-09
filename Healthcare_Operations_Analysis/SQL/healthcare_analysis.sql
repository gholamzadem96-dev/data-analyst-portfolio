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
