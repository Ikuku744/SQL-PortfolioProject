USE [SQL Tutorial ]
GO
/****** Object:  StoredProcedure [dbo].[Temp_Employee]    Script Date: 4/16/2023 7:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[Temp_Employee]
@JOBTITLE NVARCHAR(100)
AS 
CREATE TABLE #TEMP_EMPLOYEE (
JOBTITLE VARCHAR(100), EMPLOYEESPERJOB INT, AVGAGE INT, AVGSALARY INT
)


INSERT INTO #TEMP_EMPLOYEE
SELECT JOBTITLE, COUNT(JOBTITLE), AVG(AGE), AVG(SALARY)
FROM ChemistEmployeeDemographics EMP
JOIN EmployeeSalary SAL
ON EMP.EmployeeID = SAL.EmployeeID
WHERE JobTitle = 'ACCOUNTANT'
GROUP BY JobTitle

SELECT *
FROM #TEMP_EMPLOYEE

SELECT EmployeeID, Salary, AVG(SALARY) OVER () as OverallAvgSalary
FROM EmployeeSalary

SELECT EMPLOYEEID, JOBTITLE, SALARY
FROM EmployeeSalary
WHERE EmployeeID IN (SELECT EmployeeID
					FROM EmployeeDemographics
					WHERE Age <30)