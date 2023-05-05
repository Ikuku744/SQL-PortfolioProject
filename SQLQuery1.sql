--select *
--from EmployeeDemographics as demo
--full outer join ChemistEmployeeDemographics as chem
--on demo.EmployeeID = Chem.EmployeeID
--order by 1
--select employeeid, FirstName + ' ' + lastname as FullName, Age, Gender,
--case 
--when age != 22 then 'old' 
--else 'young'
--end 
--from ChemistEmployeeDemographics
--where Age is not null and Gender is not null
--order by Age

--select JobTitle, avg(Salary) as Salary_AVG
--from EmployeeDemographics as demo
--full outer join EmployeeSalary as sal
--on sal.EmployeeID = demo.EmployeeID
----group by JobTitle

--order by Salary_AVG

--with cte_employee as 
--(select FirstName, LastName, Gender, Salary,
--COUNT(gender) over (partition by gender) as gender_sum,
--AVG(salary) over (partition by salary) as AvgSalary
--from EmployeeDemographics as demo
--join EmployeeSalary as sal
--on demo.EmployeeID =  sal.EmployeeID
--where Salary = 75000
--)
--select firstname, lastname,salary
--from cte_employee



--select * 
--from EmployeeSalary
--select firstname
--from EmployeeDemographics


--CREATE TABLE #TEM_EMPLOYEE (EmployeeID int, FirstName Varchar(50), LastName varchar(50),
--Age int, Gender varchar(20), Salary int
)
--select * 
--from #TEM_EMPLOYEE

--insert into  #TEM_EMPLOYEE values
--(1001, 'Jim', 'Halpert', 30, 'Male', 46000),
--(1002, 'Kingsley', 'Enilama', 40, 'Male', 78000),
--(1003, 'Ujomu', 'Ivie', 34, 'Female',57000),
--(1004, 'Joyce', 'Namagambe', 31, 'Female', 98000),
--(1005, 'Ebikhumi', 'Marian', 27, 'Female',78000)

--create table #tem_chemist(
--EmployeeID int, firstName varchar(255), LastName varchar(255), Age int, Gender varchar(255)
--)
--select * from #tem_chemist
--insert into #tem_chemist
--select * 
--from ChemistEmployeeDemographics
--select * from #tem_chemist

--Drop Table EmployeeErrors;

CREATE TABLE EmployeeErrors(EmployeeID int, FirstName Varchar(50), LastName varchar(50)

insert into EmployeeErrors values
('1001', 'Jumbo', 'IK-Alex'),
('1003', 'Lubega', 'Titus'),
('1005', 'Victor', 'Chito')

select * from EmployeeErrors


CREATE TABLE EmployeeErrors(EmployeeID int, FirstName Varchar(50), LastName varchar(50)
)

insert into EmployeeErrors values
('1007  ', 'Jumbo', 'IK - Alex'),
('  1008', 'Lubega', 'Titus'),
('1009', 'Victor', 'ChitO')

select * from EmployeeErrors
CREATE TABLE EmployeeErrors(EmployeeID VARCHAR(100), FirstName Varchar(50), LastName varchar(50)
)
DROP TABLE EmployeeErrors
insert into EmployeeErrors values
('1001 ', 'Jumbo', 'IK-Alex'),
(' 1003', 'Lubega', 'Titus'),
('1005', 'Victor', 'Chito')

select EmployeeID, TRIM(EmployeeID) as IDTRIM 
from EmployeeErrors 


select EmployeeID, LTRIM(EmployeeID) as IDLTRIM 
from EmployeeErrors 

select EmployeeID, RTRIM(EmployeeID) as IDRTRIM 
from EmployeeErrors 

SELECT LASTNAME, REPLACE(LASTNAME, '-Alex', '') as LastNameFixed
from EmployeeErrors

SELECT SUBSTRING(LASTNAME,3,3)
from EmployeeErrors

SELECT lOWER(LASTNAME)
from EmployeeErrors


SELECT UPPER(LASTNAME)
from EmployeeErrors

CREATE PROCEDURE TEST
AS 
SELECT * 
FROM EmployeeDemographics


CREATE PROCEDURE Temp_Employee
AS 
CREATE TABLE #TEMP_EMPLOYEE (
JOBTITLE VARCHAR(100), EMPLOYEESPERJOB INT, AVGAGE INT, AVGSALARY INT
)
INSERT INTO TEMP_EMPLOYEE VALUES (
'ACCOUNTANT', 2, 31, 44500),
('HR', 1, 32, 50000),
('RECEPTIONIST', 1, 30, 36000),
('REGIONAL MANAGER', 1, 35, 65000),
('SALESMAN', 3, 32, 52000),
('SUPPLIER RELATIONS', 1, 32, 41000)

INSERT INTO #TEMP_EMPLOYEE
SELECT JOBTITLE, COUNT(JOBTITLE), AVG(AGE), AVG(SALARY)
FROM ChemistEmployeeDemographics EMP
JOIN EmployeeSalary SAL
ON EMP.EmployeeID = SAL.EmployeeID
GROUP BY JobTitle

SELECT *
FROM #TEMP_EMPLOYEE
EXEC Temp_Employee @JOBTITLE = 'ACCOUNTANT'


INSERT INTO TEMP_EMPLOYEE VALUES (
'ACCOUNTANT', 2, 31, 44500),
('HR', 1, 32, 50000),
('RECEPTIONIST', 1, 30, 36000),
('REGIONAL MANAGER', 1, 35, 65000),
('SALESMAN', 3, 32, 52000),
('SUPPLIER RELATIONS', 1, 32, 41000)