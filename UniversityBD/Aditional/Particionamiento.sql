--Particionamiento de la tabla Staff por nombre

--Agregar ndf o ldf a UniversityBD
USE UniversityBD
GO

--Add group file
ALTER DATABASE UniversityBD  
ADD FILEGROUP groupFile_01;  
GO  
ALTER DATABASE UniversityBD  
ADD FILEGROUP groupFile_02;  
GO  
ALTER DATABASE UniversityBD  
ADD FILEGROUP groupFile_03;  
GO 


--Creación de File
ALTER DATABASE UniversityBD   
ADD FILE   
(  
    NAME = file01,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\file01.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP groupFile_01; 

ALTER DATABASE UniversityBD   
ADD FILE   
(  
    NAME = file02,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\file02.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)  
TO FILEGROUP groupFile_02; 

ALTER DATABASE UniversityBD   
ADD FILE   
(  
    NAME = file03,  
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\file03.ndf',  
    SIZE = 5MB,  
    MAXSIZE = 100MB,  
    FILEGROWTH = 5MB  
)
TO FILEGROUP groupFile_03;



--partition funtion
CREATE PARTITION FUNCTION pfStaff (varchar(100))  
    AS RANGE LEFT FOR VALUES ('G', 'M') ;  


--partition scheme
CREATE PARTITION SCHEME mySchemeStaff 
    AS PARTITION pfStaff 
    TO (groupFile_01, groupFile_02, groupFile_03) ; 



--Creates a partitioned table
CREATE TABLE TtblStaff
(
	[staffId] [int],
	[staffDepartmentId] [int] NULL,
	[staffGender] [varchar](10) NOT NULL,
	[staffDOB] [date] NOT NULL,
	[staffFirst] [varchar](100) NOT NULL,
	[staffLast] [varchar](100) NOT NULL,
	[staffSuburb] [varchar](100) NOT NULL,
	[staffAddress] [varchar](max) NOT NULL,
	[staffEmail] [varchar](150) NULL,
	[staffSalary] [int] NULL,
	CONSTRAINT [staffFirstPK] PRIMARY KEY ([staffId], [staffFirst])
) 
    ON mySchemeStaff([staffFirst]);  
GO 


--Insert the data
INSERT INTO dbo.TtblStaff 
SELECT*FROM university.tblStaff
GO

SELECT* FROM dbo.TtblStaff


--Verify partition
SELECT [staffId], [staffFirst], 
$partition.pfStaff ([staffFirst]) AS particion
FROM TtblStaff
GO