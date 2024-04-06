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

CREATE TABLE COMMENTS(
Destination_ID INT,
Member_ID INT, 
Dislikes INT, 
Likes INT,
Content_Rating INT,
Comment_Date Date,
Posting_Time TIME
);

-- Added Owner_Id since the EER diagram doesnt have a primay key 
CREATE TABLE BUISNESS_OWNER(
Owner_ID INT,
Associated_Stores VARCHAR(30), -- shouldnt this be a new relation 
Buisness_Name VARCHAR(30),
Buisness_Type VARCHAR(30), -- CHANGED type attribute to buisness type for clarity
Phone_Number  VARCHAR(20), -- Phone number often have special characters and numbers such as 1+903-xxx-xxx
Contact_Info VARCHAR(30) --  THIS is our "contact person" should i change this to contanct person im not sure where this contact info
);
