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
    Potential_Cost DECIMAL(10,2),
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
	User_Reply TEXT,
    
    PRIMARY KEY(Member_ID, Comment_ID)
);

CREATE TABLE EDIT(
	Member_ID INT, -- Foreign Key referring to PK of AUTHORIZED_MEMBER, add constraint later
	Destination_ID INT, -- Foreign Key referring to PK of DESTINATION, add constraint later
	Date_Modified DATE
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

/*Country Relation data */
INSERT INTO COUNTRY VALUES -- (Country_Name) VALUES 
    ('USA'), 
    ('Canada'), 
    ('Mexico');

/*Authorized Member data
    Member_ID, Is_Preferred, Num_Following, Ranking, Address, User_Name, User_Password, Emails
*/
INSERT INTO AUTHORIZED_MEMBER VALUES
    (1, TRUE, 100, 1, '123 Maple Street', 'user1', 'pass123', 'user1@example.com'),
    (2, FALSE, 5, 2, '456 Oak Lane', 'user2', 'password2', 'user2@example.com'),
    (3, TRUE, 25, 3, '789 Pine Road', 'user3', 'password3', 'user3@example.com'),
    (4, FALSE, 8, 4, '101 Apple Blvd', 'user4', 'password4', 'user4@example.com'),
    (5, TRUE, 53, 5, '202 Berry Street', 'user5', 'password5', 'user5@example.com'),
    (6, FALSE, 4, 6, '303 Cherry Avenue', 'user6', 'password6', 'user6@example.com'),
    (7, TRUE, 27, 7, '404 Date Drive', 'user7', 'password7', 'user7@example.com'),
    (8, FALSE, 9, 8, '505 Elm Street', 'user8', 'password8', 'user8@example.com'),
    (9, TRUE, 73, 9, '606 Fir Lane', 'user9', 'password9', 'user9@example.com'),
    (10, FALSE, 7, 10, '707 Grape Road', 'user10', 'password10', 'user10@example.com'),
    (11, TRUE, 81, 11, '808 Hickory Blvd', 'user11', 'password11', 'user11@example.com'),
    (12, FALSE, 3, 12, '909 Ivy Street', 'user12', 'password12', 'user12@example.com'),
    (13, TRUE, 41, 13, '1010 Jasmine Avenue', 'user13', 'password13', 'user13@example.com'),
    (14, FALSE, 6, 14, '1111 Kiwi Drive', 'user14', 'password14', 'user14@example.com'),
    (15, TRUE, 71, 15, '1212 Lemon Lane', 'user15', 'password15', 'user15@example.com');

/*
    Buisness owner data (Owner_ID, Business_Name, Business_Type, Phone_Number, Contact_Info)
    This makes it seem like its buisnesses not buisness owners
*/
INSERT INTO BUSINESS_OWNER VALUES
    (1, 'FlavorFusion Restaurants Inc.', 'Restaurant', '123-456-7890', 'Eric Gutierrez'),
    (2, 'Infinity Plaza Holdings', 'Restaurant', '234-567-8901', 'Jane Doe'), 
    (3, 'SparklePeak Retail Enterprises', 'Shopping Mall', '345-678-9012', 'Eric Gutierrez'),
    (4, 'Wanderlust Travel Ventures', 'Sight', '456-789-0123', 'Eric Gutierrez'), 
    (5, 'Epicurean Eats Corporation', 'Restaurant', '567-890-1234', 'Alex Johnson'),
    (6, 'Tranquil Trails Hospitality Group', 'Shopping Mall', '678-901-2345', 'Mike Brown'),
    (7, 'UrbanGrove Mall Enterprises', 'Sight', '789-012-3456', 'Mike Brown'),
    (8, 'Enigma Expeditions Corporation', 'Restaurant', '890-123-4567', 'Mario Lopez'),
    (9, 'Serenity Cove Resorts Inc.', 'Restaurant', '901-234-5678', 'Sarah Connor'),
    (10, 'Gastronomica Global Holdings', 'Shopping Mall', '912-345-6789', 'Luis Martinez'),
    (11, 'Renaissance Retail Ventures', 'Sight', '923-456-7890', 'Anna Rivera'),
    (12, 'Coastal Breeze Hospitality Group', 'Shopping Mall', '934-567-8901', 'Carlos Esteban'),
    (13, 'FusionFlare Entertainment Inc.', 'Sight', '945-678-9012', 'Fiona Grace'),
    (14, 'LuxeLane Shopping Enterprises','Sight','911-234-5678','Farensi Luclata'),
    (15, 'NovaVoyage Travel Corporation', 'Shopping Mall', '977-901-2345', 'Emily Clark');

 -- STATE data (State_ID, State_name, Country_Name)
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

--  TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL (Attraction_ID, Ways_of_Travel)
INSERT INTO TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL VALUES
    (1, "Vehicle"),
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

/*TRIP_PLAN (Plan_ID, Member_ID, Potential_Cost, Start_Date, End_Date, Duration, Trip_Name, Purpose)*/
INSERT INTO TRIP_PLAN VALUES
  (1, 1, 10000.00, '2016-03-23', '2016-04-02', 10, 'Super Awesome Vacation', "Awesome vacation with the entire family."),
  (2, 2, 1250.00, '2019-10-02', '2019-10-04', 2, 'Weekend Trip', "Went on a trip over the weekend of Oct. 2nd."),
  (3, 3, 999999.99, '2020-12-01', '2020-12-25', 24, 'Fun Trip Across the World', "Insert text here."),
  (4, 4, 100.00, '2024-01-25', '2024-01-26', 1, 'Gas Station Trip',"Went to the gas station."),
  (5, 5, 500.00, '2023-02-15', '2023-02-28', 13, 'Around the US in 13 Days', "Very fast hot air balloon."),
  (6, 6, 45.00, '2024-03-01', '2024-04-05', 35, 'Very Long Trip', "Went across the street."),
  (7, 7, 1010.10, '2010-10-01', '2010-10-10', 10, '10 Day Trip', "Pretty basic trip."),
  (8, 8, 900.00, '2009-11-08', '2009-11-30', 22, 'Thanksgiving Trip', "Visited my family for Thanksgiving."),
  (9, 9, 30250.00, '2011-11-11', '2011-11-12', 1, 'Las Vegas', "Went to Vegas, lost it all :("),
  (10, 10, 1500.00, '2002-01-01', '2001-01-10', 10, 'Travel Bus Vacation', "Took a ride around with a travel bus."),
  (11, 11, 2500.00, '2005-7-15', '2005-7-17', 2, 'Fun Trip', "Went on a trip for a couple days."),
  (12, 12, 1000.00, '2019-05-06', '2005-06-07', 32, 'Month Long Trip', "Took a month long trip, it was really fun!"),
  (13, 13, 1500.00, '2001-01-01', '2001-01-02', 1, 'Day Trip', "Went on a trip for the day."),
  (14, 14, 4555.75, '2004-08-16', '2004-08-24', 4, '4 Day Trip', "Very fun!"),
  (15, 15, 750.00, '2008-09-09', '2009-10-10', 31, 'My vacation', "Decided to take a vacation for the end of summer");

  -- Planned ID (Plain_ID, Attraction_ID, Arrival_Date, Arrival time, departure date, Departure_time)
INSERT INTO PLANNED_ATTRACTIONS VALUES
    (1, 1, '2024-04-15', '09:00', '2024-04-15', '10:30'), -- Visit to Cafe of Death
    (2, 2, '2024-04-15', '20:00', '2024-04-15', '23:00'), -- Dinner at Moonlit Grille
    (3, 3, '2024-04-16', '12:00', '2024-04-16', '15:00'), -- Shopping at Broadway Mall
    (4, 4, '2024-04-17', '08:00', '2024-04-17', '11:00'), -- Mount Rushmore visit
    (5, 5, '2024-04-18', '11:00', '2024-04-18', '14:00'), -- Brunch at Lakeside Eats
    (6, 6, '2024-04-19', '09:00', '2024-04-19', '17:00'), -- Full day at Market Square Mall
    (7, 7, '2024-04-20', '10:00', '2024-04-20', '13:00'), -- Historic Castle Tours
    (8, 8, '2024-04-21', '12:00', '2024-04-21', '14:00'), -- Lunch at Cheddars
    (9, 9, '2024-04-22', '06:00', '2024-04-22', '07:30'), -- Breakfast at Starlight Diner
    (10, 10, '2024-04-23', '10:00', '2024-04-23', '17:00'), -- Shopping at Vista Ridge Mall
    (11, 11, '2024-04-24', '08:00', '2024-04-24', '09:30'), -- Sunrise at Crystal Lake View
    (12, 12, '2024-04-25', '09:00', '2024-04-25', '12:00'), -- Visit to Summit Peak Mall
    (13, 13, '2024-04-26', '09:00', '2024-04-26', '16:00'), -- Exploring Ancient Ruins
    (14, 14, '2024-04-27', '07:00', '2024-04-27', '10:00'), -- Morning in National Yellow Park
    (15, 15, '2024-04-28', '11:00', '2024-04-28', '15:00'); -- City Lights Mall exploration

INSERT INTO RESTAURANTS (Restaurant_ID, Attraction_ID, City_ID, Restaurant_name, Restaurant_description, Restaurant_address, Rating, Opening_hours, Phone_number, Restaurant_Type, Price_range, Web_link)
VALUES
    (1, 1, 1, 'Cafe of Death', 'A unique cafe with a spooky theme, serving delicious food and drinks.', '123 Main Street, San Antonio, Texas', 4, '9:00 AM', '123-456-7890', 'Cafe', '$$', 'www.cafeofdeath.com'),
    (2, 2, 2, 'Moonlit Grille', 'Enjoy fine dining under the moonlight at this elegant restaurant.', '456 Park Avenue, Dallas, Texas', 5, '6:00 PM', '234-567-8901', 'Fine Dining', '$$$', 'www.moonlitgrille.com'),
    (3, 5, 5, 'Lakeside Eats', 'Relax by the lake and savor delicious food at this waterfront restaurant.', '123 Lakeview Drive, Caliente, Jalisco', 4, '11:00 AM', '567-890-1234', 'Waterfront', '$$', 'www.lakesideeats.com'),
    (4, 8, 8, 'Cheddars', 'Experience delicious American cuisine in a cozy and inviting atmosphere.', '123 Oak Street, Muy Mal, Sonora', 4, '11:00 AM', '890-123-4567', 'American', '$$', 'www.cheddars.com'),
    (5, 9, 9, 'Starlight Diner', 'Step back in time and enjoy classic diner fare at this nostalgic eatery.', '456 Elm Avenue, Miami, Florida', 3, '6:00 AM', '901-234-5678', 'Diner', '$', 'www.starlightdiner.com');

INSERT INTO SIGHTS VALUES
-- (SIGHT_ID INT, ATTRACTION_ID = INT, CITY_ID = INT, Ticket_Price = $)
    (1, 4, 4, 26.69),
    (2, 7, 7, 32.69),
    (3, 11, 1, 4.2069),
    (4, 13, 3, 80.085),
    (5, 14, 4, 26.50);

INSERT INTO COMMENTS VALUES
  (1, 1, 1, 5, 3, 2, '2004-06-09', '10:00:00'),
  (2, 2, 2, 10, 7, 3, '2019-04-20', '02:00:00'),
  (3, 3, 3, 15, 11, 4, '2020-09-01', '15:15:15'),
  (4, 4, 4, 20, 15, 5, '2021-10-02', '12:37:45'),
  (5, 5, 5, 25, 19, 6, '2022-11-11', '11:11:11');
  
INSERT INTO USER_ACTION VALUES
    (1, 1, TRUE, FALSE, "USER REPLY"),
    (2, 2, FALSE, TRUE, "USER REPLY"),
    (3, 3, TRUE, TRUE, "USER REPLY"),
    (4, 4, FALSE, TRUE, "USER REPLY"),
    (5, 5, TRUE, TRUE, "USER REPLY");

INSERT INTO ASSOCIATED_MEMBERS VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5),
  (6, 6),
  (7, 7),
  (8, 8),
  (9, 9),
  (10, 10),
  (11, 11),
  (12, 12),
  (13, 13),
  (14, 14),
  (15, 15);

INSERT INTO RATE VALUES
  (1, 1, 4),
  (2, 2, 5),
  (3, 3, 4),
  (4, 4, 5),
  (5, 5, 4),
  (6, 6, 4),
  (7, 7, 4),
  (8, 8, 5),
  (9, 9, 4),
  (10, 10, 3),
  (11, 11, 5),
  (12, 12, 4),
  (13, 13, 4),
  (14, 14, 5),
  (15, 15, 5);

INSERT INTO EDIT VALUES		
    (1, 1, '2023-03-15'),
    (2, 2, '2023-06-22'),
    (3, 3, '2023-09-11'),
    (4, 4, '2023-02-28'),
    (5, 5, '2023-10-07'),
    (6, 6, '2023-08-19'),
    (7, 7, '2023-05-04'),
    (8, 8, '2023-12-30'),
    (9, 9, '2023-01-10'),
    (10, 10, '2023-07-26'),
    (11, 11, '2023-04-18'),
    (12, 12, '2023-11-14'),
    (13, 13, '2023-04-02'),
    (14, 14, '2023-11-25'),
    (15, 15, '2023-08-01');

-- PRINTS TABLES
SELECT * FROM COUNTRY;
SELECT * FROM AUTHORIZED_MEMBER;
SELECT * FROM BUSINESS_OWNER;
SELECT * FROM STATE;
SELECT * FROM CITY;
SELECT * FROM DESTINATION;
SELECT * FROM TRAVEL_ATTRACTIONS;
SELECT * FROM TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL;
SELECT * FROM SHOPPING_MALLS;
SELECT * FROM IMAGES;
SELECT * FROM TRIP_PLAN;
SELECT * FROM PLANNED_ATTRACTIONS;
SELECT * FROM RESTAURANTS;
SELECT * FROM SIGHTS;
SELECT * FROM COMMENTS;
SELECT * FROM USER_ACTION;
SELECT * FROM ASSOCIATED_MEMBERS;
SELECT * FROM RATE;
SELECT * FROM EDIT;
-- Commit test
