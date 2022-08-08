DROP DATABASE IF EXISTS MovieCatalogue;

CREATE DATABASE MovieCatalogue;

USE MovieCatalogue;

CREATE TABLE Genre (
	`GenreID` int not null auto_increment,
    `GenreName` varchar(30) not null,
    Primary Key (`GenreID`)
);

CREATE TABLE Director (
	`DirectorID` int not null auto_increment,
	`FirstName` varchar(30) not null,
	`LastName` varchar(30) not null,
	`BirthDate` date null,
	Primary Key (`DirectorID`)
);

CREATE TABLE Rating (
	`RatingID` int not null auto_increment,
	`RatingName` char(5) not null,
	Primary Key (`RatingID`)
);

CREATE TABLE Actor (
	`ActorID` int not null auto_increment,
	`FirstName` varchar(30) not null,
	`LastName` varchar(30) not null,
	`BirthDate` date null,
    Primary Key (`ActorID`)
);

CREATE TABLE Movie (
	`MovieID` int not null auto_increment,
	`GenreID` int not null,
	`DirectorID` int null,
	`RatingID` int null,
	`Title` varchar(128) not null,
	`ReleaseDate` date null,
	Primary Key (`MovieID`),
	Foreign Key fk_Movie_GenreID (GenreID)
		References Genre(GenreID),
	Foreign Key fk_Movie_DirectorID (DirectorID)
		References Director(DirectorID),
	Foreign Key fk_Movie_RatingID (RatingID)
		References Rating(RatingID)
);

CREATE TABLE CastMembers (
	`CastMemberID` int not null auto_increment,
	`ActorID` int not null,
	`MovieID` int not null,
	`Role` varchar(50) not null,
	Primary Key (`CastMemberID`),
	Foreign Key fk_CastMembers_ActorID (ActorID)
		References Actor(ActorID),
	Foreign Key fk_CastMembers_MovieID (MovieID)
		References Movie(MovieID)
);
