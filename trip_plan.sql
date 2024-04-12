-- Statement just for development phase
DROP SCHEMA IF EXISTS Erics;
CREATE SCHEMA Erics;
USE Erics;
/*REORGINZED the table attributes with following format PK, Foreign key , reaming attributes */
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
	Image_link VARCHAR(100),

    PRIMARY KEY (Image_ID)
);

CREATE TABLE RATE(
	Plan_ID INT, -- Foreign Key referring to PK of TRIP_PLAN, add constraint later
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
    Business_Name VARCHAR(30),
    Business_Type VARCHAR(30), -- CHANGED type attribute to business type for clarity
    Phone_Number  VARCHAR(20), -- Phone number often have special characters and numbers such as 1+903-xxx-xxx
    Contact_Info VARCHAR(30), --  THIS is our "contact person" should i change this to contanct person im not sure where this contact info

    PRIMARY KEY (Owner_ID)
);

CREATE TABLE DESTINATION(
    Destination_ID INT,
    Destination_Description TEXT,
    Country_Name VARCHAR(20),
    Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBERS, add constraint later

PRIMARY KEY (Destination_ID)
);

CREATE TABLE STATE(
    State_ID INT,
    State_name VARCHAR(20),
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
    Attraction_name VARCHAR(25),
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

    PRIMARY KEY (Ways_of_travel)
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
    Attraction_ID INT, -- Foreign Key. I removed the "s" Eric-O
    City_ID INT, -- Foreign Key
    Ticket_Price INT,

    PRIMARY KEY(Sight_ID)
);

CREATE TABLE SHOPPING_MALLS(
   Mall_ID INT,
   Attraction_ID INT, -- Foreign Key. I removed the "s" Eric-O
   City_ID INT, -- Foreign Key

   PRIMARY KEY(Mall_ID)
);

CREATE TABLE COUNTRY(
    Country_Name VARCHAR(25),
    
    PRIMARY KEY( Country_Name)
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

ALTER TABLE ASSOCIATED_MEMBERS
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

-- ALTER TABLE BUISINESS_OWNER ? NO NEED TO ALTER BUISNESS OWNER TABLE 

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
ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS(Attraction_ID) -- Wrong double check the naming i think thats the issue. I removed the "s" Eric-O
ON DELETE CASCADE
ON UPDATE CASCADE,
ADD FOREIGN KEY (City_ID) REFERENCES CITY(City_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;


ALTER TABLE SHOPPING_MALLS
ADD FOREIGN KEY (Attraction_ID) REFERENCES TRAVEL_ATTRACTIONS(Attraction_ID) -- Wrong double check the naming. I removed the "s" Eric-O
ON DELETE CASCADE
ON UPDATE CASCADE,
ADD FOREIGN KEY (City_ID) REFERENCES CITY(City_ID)
ON DELETE CASCADE
ON UPDATE CASCADE;


-- Eric O's Alter Table Statements

-- No Foreign Key needed for AUTHORIZED_MEMBER

-- No Foreign Key needed for COUNTRY 
    
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


/*Country Relation data */
INSERT INTO COUNTRY (Country_Name) VALUES 
('USA'), ('Canada'), ('Mexico');

/*Authorized Member data
    Member_ID, Is_Preferred, Num_Following, Ranking, Address, User_Name, User_Password, Emails
*/
INSERT INTO AUTHORIZED_MEMBER VALUES
(1, TRUE, 10, 1, '123 Maple Street', 'user1', 'pass123', 'user1@example.com'),
(2, FALSE, 5, 2, '456 Oak Lane', 'user2', 'password2', 'user2@example.com'),
(3, TRUE, 15, 3, '789 Pine Road', 'user3', 'password3', 'user3@example.com'),
(4, FALSE, 8, 4, '101 Apple Blvd', 'user4', 'password4', 'user4@example.com'),
(5, TRUE, 12, 5, '202 Berry Street', 'user5', 'password5', 'user5@example.com'),
(6, FALSE, 4, 6, '303 Cherry Avenue', 'user6', 'password6', 'user6@example.com'),
(7, TRUE, 20, 7, '404 Date Drive', 'user7', 'password7', 'user7@example.com'),
(8, FALSE, 9, 8, '505 Elm Street', 'user8', 'password8', 'user8@example.com'),
(9, TRUE, 11, 9, '606 Fir Lane', 'user9', 'password9', 'user9@example.com'),
(10, FALSE, 7, 10, '707 Grape Road', 'user10', 'password10', 'user10@example.com'),
(11, TRUE, 18, 11, '808 Hickory Blvd', 'user11', 'password11', 'user11@example.com'),
(12, FALSE, 3, 12, '909 Ivy Street', 'user12', 'password12', 'user12@example.com'),
(13, TRUE, 14, 13, '1010 Jasmine Avenue', 'user13', 'password13', 'user13@example.com'),
(14, FALSE, 6, 14, '1111 Kiwi Drive', 'user14', 'password14', 'user14@example.com'),
(15, TRUE, 17, 15, '1212 Lemon Lane', 'user15', 'password15', 'user15@example.com');

/*
    Buisness owner data (Owner_ID, Business_Name, Business_Type, Phone_Number, Contact_Info)
    This makes it seem like its buisnesses not buisness owners 
*/
Insert Into BUSINESS_OWNER VALUES
(1, 'Cafe of Death', 'Restaurant', '123-456-7890', 'Eric Gutierrez'),
(2, 'Moonlit Grille', 'Restaurant', '234-567-8901', 'Jane Doe'), 
(3, 'Broadway Mall', 'Shopping Mall', '345-678-9012', 'Eric Gutierrez'),
(4, 'Mount Rushmore', 'Sight', '456-789-0123', 'Eric Gutierrez'), 
(5, 'Lakeside Eats', 'Restaurant', '567-890-1234', 'Alex Johnson'),
(6, 'Market Square Mall', 'Shopping Mall', '678-901-2345', 'Mike Brown'),
(7, 'Historic Castle Tours', 'Sight', '789-012-3456', 'Mike Brown'),
(8, 'Cheddars', 'Restaurant', '890-123-4567', 'Mario Lopez'),
(9, 'Starlight Diner', 'Restaurant', '901-234-5678', 'Sarah Connor'),
(10, 'Vista Ridge Mall', 'Shopping Mall', '912-345-6789', 'Luis Martinez'),
(11, 'Crystal Lake View', 'Sight', '923-456-7890', 'Anna Rivera'),
(12, 'Summit Peak Mall', 'Shopping Mall', '934-567-8901', 'Carlos Esteban'),
(13, 'Ancient Ruins Excursion', 'Sight', '945-678-9012', 'Fiona Grace'),
(14, 'National Yellow Park','Sight','911-234-5678','Farensi Luclata'),
(15, 'City Lights Mall', 'Shopping Mall', '977-901-2345', 'Emily Clark');
/*
    STATE data (State_ID, State_name, Country_Name)
*/

INSERT INTO STATE VALUES
(1, 'Texas', 'USA'),
(2, 'Ontario', 'Canada'),
(3, 'Jalisco', 'Mexico'),
(4, 'Sonora', 'Mexico'),
(5, 'Florida', 'USA'),
(6, 'New York', 'USA'),
(7, 'Guerrero', 'Mexico'),
(8, 'Alberta', 'Canada');

-- (City_ID = INT, State_ID = INT, "CITY_NAME")
INSERT INTO CITY VALUES
(1, 1, 'San Antonio'),
(2, 1, 'Dallas'),
(3, 2, 'Poutine'),
(4, 2, 'Le France'),
(5, 3, 'Caliente'),
(6, 3, 'Muy Caliente'),
(7, 4, 'Es Frio'),
(8, 4, 'Muy Mal'),
(9, 5, 'Miami'),
(10, 5, 'Tallahassee');

-- Destinations (Destination_ID, Destination_Description, Country_Name, Member_ID)
INSERT INTO DESTINATION VALUES 
(1, 'A great place to experience some freedom', 'USA', 1),
(2, 'Discover a hidden world within ancient landscapes where nature whispers old secrets.', 'USA', 2),
(3, 'Step into the heart of neon lights where the pulse of the city hides its true face.', 'USA', 3),
(4, 'Unravel the tales of the earth carved deep into this vast and enigmatic chasm.', 'USA', 4),
(5, 'Wander through mystical valleys and serene cliffs where natures untouched beauty reigns.', 'USA', 5),
(6, 'Venture into the heart of traditions where ancient ruins tell stories of timeless splendor.', 'Mexico', 6),
(7, 'Experience the enigmatic beauty of cenotes, where water mirrors the sky in hidden depths.', 'Mexico', 7),
(8, 'Immerse yourself in the vibrant streets where each corner offers a new mystery to unravel.', 'Mexico', 8),
(9, 'Descubre un paraíso escondido donde la naturaleza y la cultura se entrelazan en una danza eterna.', 'Mexico', 9),  -- This is in Spanish
(10, 'Trace the echoes of civilizations past among the shadows of pyramids shrouded in mystery.', 'Mexico', 10),
(11, 'A vibrant city with diverse culture', 'Canada', 11),
(12, 'A blend of historic charm and modern flair', 'Canada', 12),
(13, 'Surrounded by stunning natural beauty', 'Canada', 13),
(14, 'Gateway to the Canadian Rockies', 'Canada', 14),
(15, 'Rich in history and home to iconic landmarks', 'Canada', 15);


-- (Attraction_ID = int, City ID = int, attraction_name ='', attraction description = '', attraction_address = '', 
-- rating = int, Opening_hours = '', Phone_number = '')
INSERT INTO TRAVEL_ATTRACTIONS VALUES
-- Att ID, CityID, BusinessID
(1, 1, 1, 'Cafe of Death', 'A unique cafe with a spooky theme, serving delicious food and drinks.', 
'123 Main Street, San Antonio, Texas', 4, '9:00 AM', '123-456-7890'),
(2, 2, 2, 'Moonlit Grille', 'Enjoy fine dining under the moonlight at this elegant restaurant.', 
'456 Park Avenue, Dallas, Texas', 5, '6:00 PM', '234-567-8901'),
(3, 3, 3, 'Broadway Mall', 'A bustling shopping destination featuring a wide variety of stores and boutiques.', 
'789 Broadway Blvd, Poutine, Ontario', 4, '10:00 AM', '345-678-9012'),
(4, 4, 4, 'Mount Rushmore', 'Marvel at the iconic faces carved into the mountainside at this historic landmark.', 
'Mount Rushmore National Memorial, Le France, Ontario', 5, '8:00 AM', '456-789-0123'),
(5, 5, 5, 'Lakeside Eats', 'Relax by the lake and savor delicious food at this waterfront restaurant.', 
'123 Lakeview Drive, Caliente, Jalisco', 4, '11:00 AM', '567-890-1234'),
(6, 6, 6, 'Market Square Mall', 'Shop til you drop at this expansive mall offering a wide range of stores and dining options.', 
'101 Market Street, Muy Caliente, Jalisco', 4, '9:00 AM', '678-901-2345'),
(7, 7, 7, 'Historic Castle Tours', 'Embark on a journey through history with guided tours of ancient castles.', 
'1 Castle Road, Es Frio, Sonora', 5, '10:00 AM', '789-012-3456'),
(8, 8, 8, 'Cheddars', 'Experience delicious American cuisine in a cozy and inviting atmosphere.', 
'123 Oak Street, Muy Mal, Sonora', 4, '11:00 AM', '890-123-4567'),
(9, 9, 9, 'Starlight Diner', 'Step back in time and enjoy classic diner fare at this nostalgic eatery.', 
'456 Elm Avenue, Miami, Florida', 3, '6:00 AM', '901-234-5678'),
(10, 10, 10, 'Vista Ridge Mall', 'Shop til you drop at this expansive mall offering a wide range of stores and dining options.', 
'789 Maple Lane, Tallahassee, Florida', 5, '10:00 AM', '912-345-6789'),
(11, 1, 11, 'Crystal Lake View', 'Marvel at the stunning vistas overlooking Crystal Lake.', 
'101 Pine Street, San Antonio, Texas', 4, '8:00 AM', '923-456-7890'),
(12, 2, 12, 'Summit Peak Mall', 'Explore a variety of shops and entertainment options at Summit Peak Mall.', 
'202 Cedar Drive, Dallas, Texas', 4, '9:00 AM', '934-567-8901'),
(13, 3, 13, 'Ancient Ruins Excursion', 'Embark on an adventure to explore ancient ruins and uncover the mysteries of the past.', 
'303 Walnut Road, Poutine, Ontario', 5, '9:00 AM', '945-678-9012'),
(14, 4, 14, 'National Yellow Park', 'Discover the beauty of nature at National Yellow Park.', 
'404 Birch Boulevard, Le France, Ontario', 4, '7:00 AM', '911-234-5678'),
(15, 5, 15, 'City Lights Mall', 'Experience the vibrant energy of the city at City Lights Mall, offering a diverse selection of shops and entertainment.', 
'505 Chestnut Street, Caliente, Sonora', 5, '11:00 AM', '977-901-2345');

--  TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL (Attraction_ID, Way_of_Travel) FOR SIMPLICITY ways of travel, vehicle, walking , bus, helicopter, donkey ride 
-- Using 'INSERT IGNORE' to avoid errors due to duplicate entries.
-- Duplicate entries might exist because each attraction can only have each mode of transport listed once.
INSERT IGNORE INTO TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL VALUES
(1, 'Vehicle'),
(1, 'Bus'),
(1, 'Walking'),
(1, 'Donkey Ride'),
(2, 'Helicopter'),
(2, 'Vehicle'),
(3, 'Bus'),
(4, 'Helicopter'),
(4, 'Bus'),
(5, 'Vehicle'),
(6, 'Walking'),
(7, 'Donkey Ride'),
(8, 'Vehicle'),
(9, 'Vehicle'),
(10, 'Bus'),
(11, 'Helicopter'),
(12, 'Vehicle'),
(13, 'Helicopter'),
(14, 'Helicopter'),
(14, 'Bus'),
(15, 'Vehicle');

/* SHOPPING_MALLS (Mall_ID, Attraction_ID, City_ID) */
INSERT INTO SHOPPING_MALLS VALUES
  (1, 3, 3),
  (2, 6, 6),
  (3, 10, 10),
  (4, 12, 2),
  (5, 15, 5);

  INSERT INTO IMAGES VALUES
  (1, 1, 'Imagelink0001' ),
  (2, 2, 'Imagelink0002' ),
  (3, 3, 'Imagelink0003' ),
  (4, 4, 'Imagelink0004' ),
  (5, 5, 'Imagelink0005' ),
  (6, 6, 'Imagelink0006' ),
  (7, 7, 'Imagelink0007' ),
  (8, 8, 'Imagelink0008' ),
  (9, 9, 'Imagelink0009' ),
  (10, 10, 'Imagelink0010' ),
  (11, 11, 'Imagelink0011' ),
  (12, 12, 'Imagelink0012' ),
  (13, 13, 'Imagelink0013' ),
  (14, 14, 'Imagelink0014' ),
  (15, 15, 'Imagelink0015' );
 
INSERT INTO RATE VALUES
-- (PLAN_ID = INT, MEMBER_ID = INT, RATING)
()

/*CREATE TABLE RATE(
	Plan_ID INT, -- Foreign Key referring to PK of TRIP_PLAN, add constraint later
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Rating INT
);*/