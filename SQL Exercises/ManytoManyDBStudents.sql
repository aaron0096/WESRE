## Many to many relationship DB for students
DROP DATABASE IF EXISTS StudentMany;

CREATE DATABASE StudentMany;

USE StudentMany;

CREATE TABLE StudentDetails (
	StudentID char(9) not null unique,
    FirstName varchar(20) not null,
    LastName varchar(20) not null,
    Address varchar(50) null,
    Phone varchar(15) not null,
    Primary Key (`StudentID`)
    );

CREATE TABLE Student (
	StudentID char(9) not null unique,
    StudentName varchar(20) not null,
    Primary Key (`StudentID`),
	Foreign Key fk_Student_StudentID (StudentID)
		References StudentDetails(`StudentID`)
);

CREATE TABLE Class (
	ClassID int auto_increment,
    ClassIndex char(14) generated always as (CONCAT(`YearOffered`,`SemOffered`,`ClassCode`)),
    `YearOffered` char(4) not null,
    `SemOffered` char(2) not null,
    ClassCode char(8) not null,
    Primary Key (`ClassID`)
);

CREATE TABLE Enrollment (
	StudentID char(9) not null unique,
    ClassID int not null,
    Primary Key (`StudentID`,`ClassID`),
    Foreign Key fk_Enrollment_StudentID (`StudentID`)
		References Student(`StudentID`),
	Foreign Key fk_Enrollment_ClassID (`ClassID`)
		References Class(`ClassID`)
);

	