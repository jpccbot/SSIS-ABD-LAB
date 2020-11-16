-- transferir tabla a otro esquema ...1° esquema 2° tabla
ALTER SCHEMA student TRANSFER dbo.tblStudent
ALTER SCHEMA student TRANSFER dbo.tblEnrolment
ALTER SCHEMA student TRANSFER dbo.tblEnrolmentDetail
ALTER SCHEMA student TRANSFER dbo.tblStudentpayment
ALTER SCHEMA student TRANSFER dbo.tblGrade

ALTER SCHEMA university TRANSFER dbo.tblBuilding
ALTER SCHEMA university TRANSFER dbo.tblCourse
ALTER SCHEMA university TRANSFER dbo.tblCourseType
ALTER SCHEMA university TRANSFER dbo.tblDepartment
ALTER SCHEMA university TRANSFER dbo.tblSchool
ALTER SCHEMA university TRANSFER dbo.tblStaff
GO


--Vista que muestra los detalles de cada Escuela

CREATE VIEW vwSchoolDepartmentBuilding
AS
SELECT
	s.schoolName [School Name],
	d.departmentName [Department Name],
	b.buildingAddress [Address]
FROM
	university.tblDepartment d
	JOIN university.tblSchool s ON s.schoolId = d.departmentSchoolId
	JOIN university.tblBuilding b ON b.buildingId = s.schoolBuildingId
GO

--SELECT * FROM vwSchoolDepartmentBuilding








--información de contacto del personal y el departamento al que pertenecen Los docentes
CREATE VIEW vwStaffDetails 
	WITH SCHEMABINDING
AS
	SELECT 
	tblStaff.staffFirst [First Name],
	tblStaff.staffLast [Last Name],
	tblStaff.staffEmail [Email]
	FROM university.tblStaff 
GO


CREATE UNIQUE CLUSTERED INDEX IdxStaffDetailsView
   ON vwStaffDetails ([First Name], [Last Name], [Email]);

--SELECT [First Name], [Last Name], [Email] FROM vwStaffDetails


--índice NONCLUSTERED
CREATE NONCLUSTERED INDEX idxStudent
ON student.tblStudent(studentFirst)
GO


--SELECT studentFirst FROM tblStudent 