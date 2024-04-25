DROP SCHEMA IF EXISTS Erics;
CREATE SCHEMA Erics;
USE Erics;

CREATE TABLE AUTHORIZED_MEMBER(
	FName VARCHAR(50),
    MInit VARCHAR(1),
    LName VARCHAR(50),
	Member_ID INT,
    Is_Preferred BOOLEAN,
    Num_Following INT,
    Ranking INT,
    Address VARCHAR(50),
    User_Name VARCHAR(30),
    User_Password VARCHAR(50),
    Email VARCHAR(30),
    
    PRIMARY KEY (Member_ID)
);

CREATE TABLE TRIP_PLAN(
	Plan_ID INT,
    Member_ID INT, -- FK --> PK of AUTHORIZED_MEMBER
    Potential_Cost DECIMAL(10,2),
    Start_Date DATE,
    End_Date DATE,
    Duration TINYINT UNSIGNED,
    Trip_Name VARCHAR(50),
    Purpose TEXT,
    
    PRIMARY KEY (Plan_ID)
);

CREATE TABLE IMAGES(
	Image_ID INT,
	Member_ID INT, -- FK --> PK of AUTHORIZED_MEMBER
	Image_link VARCHAR(100),
    PRIMARY KEY (Image_ID)
);

CREATE TABLE RATE(
	Plan_ID INT, -- FK --> PK of TRIP_PLAN
	Member_ID INT, -- FK --> PK of AUTHORIZED_MEMBER
	Rating INT
);

CREATE TABLE USER_ACTION(
	Member_ID INT, -- FK --> PK of AUTHORIZED_MEMBER
	Comment_ID INT, -- FK --> PK of COMMENTS
	User_Likes BOOLEAN,
	User_Dislikes BOOLEAN,
	User_Reply TEXT,
    
    PRIMARY KEY(Member_ID, Comment_ID)
);

CREATE TABLE EDIT(
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Destination_ID INT, -- Foreign Key referring to PK of DESTINATION, add constraint later
	Date_Modified DATE
);

CREATE TABLE ASSOCIATED_MEMBER(
	Plan_ID INT, -- Foreign Key referring to PK of TRIP_PLAN, add constraint later
	Member_ID INT -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
);

CREATE TABLE PLANNED_ATTRACTIONS(
	Plan_ID INT, -- Foreign Key referring to PK of TRIP_PLAN, add constraint later
	Attraction_ID INT, -- Foreign Key referring to PK TRAVEL_ATTRACTIONS, add constraint later
	Arrival_Date DATE,
	Arrival_Time TIME,
	Departure_Date DATE,
	Departure_Time TIME
);

CREATE TABLE COMMENTS(
    Comment_ID INT,
    Destination_ID INT,
    Member_ID INT, 
    Dislikes INT, 
    Likes INT,
    Content_Rating INT,
    Comment_Date Date,
    Posting_Time TIME,
    PRIMARY KEY (Comment_ID)
);

CREATE TABLE BUSINESS_OWNER(
    Owner_ID INT,
    Business_Name VARCHAR(50),
    Business_Type VARCHAR(30), -- CHANGED type attribute to business type for clarity
    Phone_Number  VARCHAR(20), -- Phone number often have special characters and numbers such as 1+903-xxx-xxx
    Contact_Info VARCHAR(30),
    PRIMARY KEY (Owner_ID)
);

CREATE TABLE DESTINATION(
    Destination_ID INT,
    Destination_Description TEXT,
    Country_Name VARCHAR(20),
    Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
    PRIMARY KEY (Destination_ID)
);

CREATE TABLE STATE(
    State_ID INT,
    State_name VARCHAR(30),
    Country_Name VARCHAR(25), -- Foreign Key referring to PK of COUNTRY, add constraint later
    
    PRIMARY KEY (State_ID)
);

CREATE TABLE CITY(
    City_ID INT,
    State_ID INT, -- Foreign Key referring to PK of STATE, add constraint later
    City_Name VARCHAR(25),
    PRIMARY KEY (City_ID)
);

CREATE TABLE TRAVEL_ATTRACTIONS (
    Attraction_ID INT, -- Primary key
    City_ID INT, -- Foreign Key referring to PK of CITY, add constraint
    Owner_ID INT, -- Foreign Key referring to PK of BUSINESS_OWNER, add constraint later
    Attraction_name VARCHAR(35),
    Attraction_description VARCHAR(250),
    Attraction_address VARCHAR(100),
    Rating INT,
    Opening_hours VARCHAR(10), -- Assuming something like "9:00 AM"
    Phone_number VARCHAR(25),
    PRIMARY KEY (Attraction_ID)
);

CREATE TABLE TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL (
    Attraction_ID INT, -- Foreign key referring to PK of ATTRACTION, add constraint later
    Ways_of_travel VARCHAR(30),
    PRIMARY KEY (Attraction_ID, Ways_of_travel)
);

CREATE TABLE RESTAURANTS (
    Restaurant_ID INT,
    Attraction_ID INT, -- Foreign key referring to PK of ATTRACTIONS, add constraint later
    City_ID INT, -- Foreign key referring to PK of CITY, add constraint later
    Restaurant_name VARCHAR(30),
    Restaurant_description VARCHAR(250),
    Restaurant_address VARCHAR(100),
    Rating INT,
    Opening_hours VARCHAR(10),
    Phone_number VARCHAR(25),
    Restaurant_Type VARCHAR(30),
    Price_range VARCHAR(10),
    Web_link VARCHAR(30),
    PRIMARY KEY (Restaurant_ID)
);

CREATE TABLE SIGHTS(
    Sight_ID INT,
    Attraction_ID INT,
    City_ID INT, -- Foreign Key
    Ticket_Price DECIMAL(10, 4),
    PRIMARY KEY(Sight_ID, Attraction_ID)
);

CREATE TABLE SHOPPING_MALLS(
   Mall_ID INT,
   Attraction_ID INT, -- FK
   City_ID INT, -- FK
   PRIMARY KEY(Mall_ID)
);

CREATE TABLE COUNTRY(
    Country_Name VARCHAR(25),
    
    PRIMARY KEY(Country_Name)
);

/* Emilio's Branch Changes Start */
ALTER TABLE USER_ACTION
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (Comment_ID) REFERENCES COMMENTS (Comment_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE EDIT
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (Destination_ID) REFERENCES DESTINATION (Destination_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE ASSOCIATED_MEMBER
    ADD FOREIGN KEY (Plan_ID) REFERENCES TRIP_PLAN (Plan_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE PLANNED_ATTRACTIONS
    ADD FOREIGN KEY (Plan_ID) REFERENCES TRIP_PLAN (Plan_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS (Attraction_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
/* Emilio's Branch Changes End */

/*Zach's ALTER TABLES*/
ALTER TABLE CITY
    ADD FOREIGN KEY (State_ID) REFERENCES STATE (State_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE TRAVEL_ATTRACTIONS
    ADD FOREIGN KEY (City_ID) REFERENCES CITY (City_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (Owner_ID) REFERENCES BUSINESS_OWNER (Owner_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL
    ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS (Attraction_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE RESTAURANTS
    ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS (Attraction_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (City_ID) REFERENCES CITY (City_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
    
/*Eric Alter Table*/
ALTER TABLE COMMENTS
	ADD FOREIGN KEY (Destination_ID) REFERENCES DESTINATION (Destination_ID)
     ON DELETE CASCADE
     ON UPDATE CASCADE,
	ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
	 ON DELETE CASCADE
     ON UPDATE CASCADE;
/*Eric Alter Table END */

/*Nick Alter Table*/
ALTER TABLE DESTINATION
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE STATE
    ADD FOREIGN KEY (Country_Name) REFERENCES COUNTRY (Country_Name)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE CITY
    ADD FOREIGN KEY (State_ID) REFERENCES STATE (State_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

/*Johnny Alter Table*/
ALTER TABLE SIGHTS
ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS(Attraction_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
ADD FOREIGN KEY (City_ID) REFERENCES CITY(City_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE SHOPPING_MALLS
ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS(Attraction_ID)
ON DELETE CASCADE
ON UPDATE CASCADE,
ADD FOREIGN KEY (City_ID) REFERENCES CITY(City_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- Eric O's Alter Table Statements    
ALTER TABLE TRIP_PLAN
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;
    
ALTER TABLE IMAGES
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;    
    
ALTER TABLE RATE
    ADD FOREIGN KEY (Member_ID) REFERENCES AUTHORIZED_MEMBER (Member_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
    ADD FOREIGN KEY (Plan_ID) REFERENCES TRIP_PLAN (Plan_ID)
    ON DELETE CASCADE
    ON UPDATE CASCADE;    
-- End of Eric O's Alter Table Statements 