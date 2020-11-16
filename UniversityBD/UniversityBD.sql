USE master;
GO
CREATE DATABASE UniversityBD;
GO
USE UniversityBD;
GO

-- create schemas
CREATE SCHEMA student;
go

CREATE SCHEMA university;
go


Create table tblStudent(
	studentId int primary key not null identity(1,1),
	studentGender varchar(10) not null,
	studentDOB date not null,
	studentFirst varchar(100) not null,
	studentLast varchar(100) not null,
	studentMiddle varchar(100) not null,
	studentSuburb varchar(100) not null,
	studentAddress varchar(max) not null,
	studentEmail varchar(150) not null
)

Create table tblCourse(
	courseId int primary key not null identity(1,1),
	courseDepartmentId int,
	courseTypeId int,
	courseName varchar(max),
	courseDescription text,
	courseCost int
)


Create table tblCourseType(
	courseTypeId int primary key not null identity(1,1),
	courseTypeName varchar(150),
)

Create table tblBuilding(
	buildingId int primary key not null identity(1,1),
	buildingAddress varchar(max),
	buildingNumberOfRooms int not null
)



Create table tblEnrolmentDetail(
	detailCourseId int,
	detailEnrolmentId int,
	detailStaffId int,
	detailScore int
)


Create table tblSchool(
	schoolId int primary key not null identity(1,1),
	schoolBuildingId int,
	schoolName varchar(150),
	schoolDescription text
)


Create table tblDepartment(
	departmentId int primary key not null identity(1,1),
	departmentSchoolId int,
	departmentName varchar(max),
	departmentDescription text
)


Create table tblStaff(
	staffId int primary key not null identity(1,1),
	staffDepartmentId int,
	staffGender varchar(10) not null,
	staffDOB date not null,
	staffFirst varchar(100) not null,
	staffLast varchar(100) not null,
	staffSuburb varchar(100) not null,
	staffAddress varchar(max) not null,
	staffEmail varchar(150),
	staffSalary int
)


Create table tblEnrolment(
	enrolmentId int primary key not null identity(1,1),
	enrolmentStudentId int,
	enrolmentDate date
)


Create table tblGrade(
	gradetId int primary key not null identity(1,1),
	gradeEnrolmentId int,
	gradeScore int not null
)


Create table tblStudentPayment(
	paymentId int primary key not null identity(1,1),
	paymentStudentId int,
	paymentEnrolmentId int,
	paymentAmount int not null,
	paymentDate date
)



ALTER TABLE tblStaff ADD CONSTRAINT FK_staffdepartmentid
FOREIGN KEY (staffDepartmentId) references tblDepartment(departmentId) ON DELETE SET NULL;

ALTER TABLE tblSchool ADD CONSTRAINT FK_schoolbuildingid
FOREIGN KEY (schoolBuildingId) references tblBuilding(buildingId) ON DELETE SET NULL;

ALTER TABLE tblEnrolmentDetail ADD CONSTRAINT FK_detailcourseid
FOREIGN KEY (detailcourseId) references tblCourse(courseId) ON DELETE SET NULL;

ALTER TABLE tblEnrolmentDetail ADD CONSTRAINT FK_detailenrolmentid
FOREIGN KEY (detailEnrolmentId) references tblEnrolment(enrolmentId) ON DELETE SET NULL;

ALTER TABLE tblEnrolmentDetail ADD CONSTRAINT FK_detailstaffid
FOREIGN KEY (detailStaffId) references tblStaff(staffId) ON DELETE SET NULL;

ALTER TABLE tblDepartment ADD CONSTRAINT FK_departmentschoolid
FOREIGN KEY (departmentSchoolId) references tblSchool(schoolId) ON DELETE SET NULL;

ALTER TABLE tblCourse ADD CONSTRAINT FK_coursedepartmentId
FOREIGN KEY (courseDepartmentId) references tblDepartment(departmentId) ON DELETE SET NULL;

ALTER TABLE tblCourse ADD CONSTRAINT FK_coursetype
FOREIGN KEY (courseTypeId) references tblCourseType(courseTypeId) ON DELETE SET NULL;

ALTER TABLE tblStudentPayment ADD CONSTRAINT FK_paymentstudentid
FOREIGN KEY (paymentStudentId) references tblStudent(studentId) ON DELETE SET NULL;

ALTER TABLE tblStudentPayment ADD CONSTRAINT FK_paymentenrolmentid
FOREIGN KEY (paymentEnrolmentId) references tblEnrolment(enrolmentId) ON DELETE SET NULL;

ALTER TABLE tblEnrolment ADD CONSTRAINT FK_enrolmentStudentid
FOREIGN KEY (enrolmentStudentId) references tblStudent(studentId) ON DELETE SET NULL;

ALTER TABLE tblGrade ADD CONSTRAINT FK_gradeenrolment
FOREIGN KEY (gradeEnrolmentId) references tblEnrolment(enrolmentId) ON DELETE SET NULL;

