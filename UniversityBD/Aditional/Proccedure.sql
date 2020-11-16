--Lista estudiantes y detalles de inscripción
CREATE PROCEDURE spViewAllEnrolments
AS
BEGIN
	SELECT
		st.studentFirst as [Student First Name],
		st.studentLast as [Student Last Name],
		'$' + CAST(c.courseCost AS VARCHAR) as [Course Cost],
		e.enrolmentDate as [Course Enrolment Date],
		c.courseName as [Course Name],
		d.departmentName as [Departmeent Name],
		s.staffFirst as [Teacher First Name],
		s.staffLast as [Teacher Last Name]
	FROM
		student.tblEnrolmentDetail ed
		JOIN student.tblEnrolment e ON e.enrolmentId = ed.detailEnrolmentId
		JOIN student.tblStudent st ON st.studentId = e.enrolmentStudentId
		JOIN university.tblCourse c ON c.courseId = ed.detailCourseId
		JOIN university.tblStaff s ON s.staffId = ed.detailStaffId
		JOIN university.tblDepartment d ON d.departmentId = c.courseDepartmentId
END
GO
--EXECUTE spViewAllEnrolments




--Detalles de un estudiante por id
CREATE PROCEDURE spFindSingleStudent
@id int
AS
BEGIN
	SELECT
		studentId as [Student Unique Id],
		studentFirst as [Student First Name],
		studentLast as [Student Last Name],
		DATEDIFF(YEAR, studentDOB,GETDATE()) as [Age],
		studentSuburb as Suburb,
		studentAddress as [Address],
		StudentEmail as [Student Email]
	FROM
		student.tblStudent
	WHERE studentId = @id
END
GO
--EXECUTE spFindSingleStudent 123





--Alumnos inscritos por id o nombre del curso
CREATE PROCEDURE spFindStudentsByCourse
@courseid int = NULL,
@coursename varchar(100) = NULL
AS
BEGIN
	SELECT
		s.studentId as [Student Unique Id],
		s.studentFirst as [First Name],
		s.studentLast as [Last Name],
		DATEDIFF(YEAR, s.studentDOB,GETDATE()) as [Age],
		s.studentSuburb as Suburb,
		s.studentAddress as [Address],
		s.StudentEmail as [Student Email],
		e.enrolmentDate as [Enrolment Date],
		c.courseId as [Course Id],
		c.courseName as [Course Name],
		g.gradeScore as [Semestre],
		ed.detailScore as [Nota]
	FROM
		student.tblStudent s 
		JOIN student.tblEnrolment e ON e.enrolmentStudentId = s.studentId
		JOIN student.tblEnrolmentDetail ed ON ed.detailEnrolmentId = e.enrolmentId
		JOIN university.tblCourse c ON c.courseId = ed.detailCourseId
		JOIN university.tblCourseType ct ON ct.courseTypeId = c.courseTypeId
		JOIN student.tblGrade g ON g.gradeEnrolmentId =e.enrolmentId
	WHERE
		(c.courseId = @courseid OR @courseid IS NULL) AND
		(c.courseName = @coursename OR @coursename IS NULL)
	ORDER BY
		s.studentId
END
GO
--EXECUTE spFindStudentsByCourse NULL, 'SOA'




--Lista docentes por nombre del departamento
CREATE PROCEDURE spFindTeacherByDepartment 
@depname varchar(100)
AS
BEGIN
	SELECT
		st.staffId as [Staff Unique Id],
		st.staffFirst as [First Name],
		st.staffLast as [Last Name],
		st.staffEmail as [Email],
		DATEDIFF(YEAR, st.staffDOB, GETDATE()) as [Age],
		d.departmentName as [Department],
		c.courseName as [Course Name],
		s.schoolName as [School]
	FROM
		university.tblStaff st
		JOIN university.tblDepartment d ON d.departmentId = st.staffDepartmentId
		JOIN university.tblSchool s ON s.schoolId = d.departmentSchoolId
		JOIN university.tblCourse c ON c.courseDepartmentId = d.departmentId
	WHERE
		@depname = d.departmentName
	ORDER BY
		st.staffId
END
GO
--EXECUTE spFindTeacherByDepartment 'Legal'