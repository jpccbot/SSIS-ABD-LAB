CREATE TRIGGER trDeleteCourse
ON university.tblCourse
FOR DELETE
AS
	DECLARE @courseId int
	PRINT 'Modified table: tblEnrolmentDetail'

	DELETE FROM [student].[tblEnrolmentDetail]
    WHERE detailCourseId = @courseId
GO




--DELETE FROM tblCourse WHERE courseId = 1;












CREATE TRIGGER Prevenction_Delete
ON student.tblStudent
FOR DELETE
AS
	PRINT('A user want delete a date of a table')
	ROLLBACK;
GO

--DELETE FROM student.tblStudent WHERE tblStudent.studentId = 1