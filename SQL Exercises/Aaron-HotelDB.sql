DROP DATABASE IF EXISTS HotelDB;

CREATE DATABASE HotelDB;

USE HotelDB;

CREATE TABLE RoomType (
	`type_id` int primary key,
    `RoomType` varchar(10) not null
);

CREATE TABLE Amenities (
	`am_id` int primary key,
    `Microwave` bool not null,
    `Jacuzzi` bool not null,
    `Refrigerator` bool not null,
    `Oven` bool not null
);

CREATE TABLE OccupancyPrice (
	`op_id` int primary key,
    `Standard_Occupancy` int not null,
    `Max_Occupancy` int not null,
    `Base_Price` int not null,
    `Extra_Person_Cost` int null
);

CREATE TABLE CityState (
	`Zip` char(5) primary key,
    `City` varchar(20) not null,
    `State` char(2) not null
);

CREATE TABLE Guest (
	`guest_id` int auto_increment primary key,
    `FirstName` varchar(20) not null,
    `LastName` varchar(20) not null,
    `FullName` varchar(50) generated always as (concat(`FirstName`," ",`LastName`)) virtual,
    `Address` varchar(50) not null,
    `Zip` char(5) not null,
    `Phone` varchar(20) not null,
    Foreign Key FK_Guest_Zip (`Zip`)
		References CityState(`Zip`)
	);
    
    CREATE TABLE RoomData (
		`room` int primary key,
        `type_id` int not null,
        `am_id` int not null,
        `ADA` bool not null,
        `op_id` int not null,
        Foreign Key FK_RoomData_type_id (`type_id`)
			References RoomType(`type_id`),
		Foreign Key FK_RoomData_am_id (`am_id`)
			References Amenities(`am_id`),
		Foreign Key FK_RoomData_op_id (`op_id`)
			References OccupancyPrice(`op_id`)
	);
    
    CREATE TABLE Reservations (
		`reservationid` int auto_increment primary key,
        `room` int not null,
        `guest_id` int not null,
        `start_date` date not null,
        `end_date` date not null,
		`totaldays` int generated always as (datediff(`end_date`,`start_date`)) virtual,
        `Adults` int not null,
        `Children` int not null,
        `totalcost` decimal(19,2) not null,
        Foreign Key FK_Reservations_room (`room`)
			References RoomData(`room`),
		Foreign Key FK_Reservations_guest_id (`guest_id`)
			References Guest(`guest_id`)
	);
    

