-- Statement just for development phase
DROP SCHEMA IF EXISTS Erics;
CREATE SCHEMA Erics;
USE Erics;

CREATE TABLE AUTHORIZED_MEMBER(
	Member_ID INT,
    Is_Preferred BOOLEAN,
	-- If we are required to pull a list of who follows who, may have to add new table
    Num_Following INT,
    Ranking INT,
    Address VARCHAR(50),
    User_Name VARCHAR(15),
    User_Password VARCHAR(50),
    Email VARCHAR(30),
    
    PRIMARY KEY (Member_ID)
);

CREATE TABLE TRIP_PLAN(
	Plan_ID INT,
    Member_ID INT, -- Foreign Key refering to PK of AUTHORIZED_MEMBER, add contraint later
    Potential_Cost FLOAT(10,2),
    Start_Date DATE,
    End_Date DATE,
    Duration TINYINT UNSIGNED,
    Trip_Name VARCHAR(30),
    Purpose TEXT,
    
    PRIMARY KEY (Plan_ID)
);

CREATE TABLE IMAGES(
	Image_ID INT,
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Image_link VARCHAR(100)
);

CREATE TABLE RATE(
	Plan_ID INT, --Foreign Key referring to PK of TRIP_PLAN, add constraint later
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Rating INT
);

CREATE TABLE USER_ACTION(
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Comment_ID INT, -- Foreign Key referring to PK of COMMENTS, add constraint later
	User_Likes BOOLEAN,
	User_Dislikes BOOLEAN,
	User_Reply TEXT
);

CREATE TABLE EDIT(
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Destination_ID INT, -- Foreign Key referring to PK of DESTINATION, add constraint later
	Date_Modified BOOLEAN
);

CREATE TABLE ASSOCIATED_MEMBERS(
	Plan_ID INT, -- Foreign Key referring to PK of TRIP_PLAN, add constraint later
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
);

CREATE TABLE PLANNED_ATTRACTIONS(
	Plan_ID INT, -- Foreign Key referring to PK of TRIP_PLAN, add constraint later
	Attraction_ID INT, -- Foreign Key referring to PK TRAVEL_ATTRACTIONS, add constraint later
	Arrival_Date DATE,
	Arrival_Time TIME,
	Departure_Date DATE,
	Departure_Time TIME
);
