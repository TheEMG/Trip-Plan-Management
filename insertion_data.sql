USE Erics;

 -- Run Trip_Plan script to create database tables
 -- Run this script to insert data into tables
SET SQL_SAFE_UPDATES = 0;
DELETE FROM COUNTRY;
DELETE FROM AUTHORIZED_MEMBER;
DELETE FROM BUSINESS_OWNER;
DELETE FROM STATE;
DELETE FROM CITY;
DELETE FROM DESTINATION;
DELETE FROM TRAVEL_ATTRACTIONS;
DELETE FROM TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL;
DELETE FROM SHOPPING_MALLS;
DELETE FROM IMAGES;
DELETE FROM TRIP_PLAN;
DELETE FROM PLANNED_ATTRACTIONS;
DELETE FROM RESTAURANTS;
DELETE FROM SIGHTS;
DELETE FROM COMMENTS;
DELETE FROM USER_ACTION;
DELETE FROM ASSOCIATED_MEMBER;
DELETE FROM RATE;
DELETE FROM EDIT;
SET SQL_SAFE_UPDATES = 1;

/* COUNTRY: Country_Name */
INSERT INTO COUNTRY VALUES
    ('Canada'), 
    ('France'), 
    ('Mexico'),
    ('USA');

/* AUTHORIZED_MEMBER: FName, MInit, LName, Member_ID, Is_Preferred, Num_Following, Ranking, Address, User_Name, User_Password, Email */
INSERT INTO AUTHORIZED_MEMBER VALUES
    ("Emma","J","Smith", 1, TRUE, 100, 1, '123 Maple Street', 'user1', 'pass123', 'user1@example.com'),
    ("Liam","M","Johnson", 2, FALSE, 5, 2, '456 Oak Lane', 'user2', 'password2', 'user2@example.com'),
    ("Olivia","N","Williams", 3, TRUE, 25, 3, '789 Pine Road', 'user3', 'password3', 'user3@example.com'),
    ("Noah","R","Brown", 4, FALSE, 8, 4, '101 Apple Blvd', 'user4', 'password4', 'user4@example.com'),
    ("Ava","S","Jones", 5, TRUE, 53, 5, '202 Berry Street', 'user5', 'password5', 'user5@example.com'),
    ("William","L","Garcia", 6, FALSE, 4, 6, '303 Cherry Avenue', 'user6', 'password6', 'user6@example.com'),
    ("Sophia","K","Miller", 7, TRUE, 27, 7, '404 Date Drive', 'user7', 'password7', 'user7@example.com'),
    ("James","P","Davis", 8, FALSE, 9, 8, '505 Elm Street', 'user8', 'password8', 'user8@example.com'),
    ("Isabella","T","Rodriguez", 9, TRUE, 73, 9, '606 Fir Lane', 'user9', 'password9', 'user9@example.com'),
    ("Benjamin","A","Martinez", 10, FALSE, 7, 10, '707 Grape Road', 'user10', 'password10', 'user10@example.com'),
    ("Mia","B","Hernandez", 11, TRUE, 81, 11, '808 Hickory Blvd', 'user11', 'password11', 'user11@example.com'),
    ("Alexander","C","Lopez", 12, FALSE, 3, 12, '909 Ivy Street', 'user12', 'password12', 'user12@example.com'),
    ("Charlotte","E","Gonzalez", 13, TRUE, 41, 13, '1010 Jasmine Avenue', 'user13', 'password13', 'user13@example.com'),
    ("Amelia","G","Anderson", 14, FALSE, 6, 14, '1111 Kiwi Drive', 'user14', 'password14', 'user14@example.com'),
    ("Vicente", "", "Fernandez", 15, TRUE, 71, 15, '1212 Lemon Lane', 'user15', 'password15', 'user15@example.com'),
    ("Ethan", "Q", "Morris", 16, FALSE, 7, 16, '1313 Mango Street', 'user16', 'password16', 'user16@example.com'),
    ("Natalie", "M", "Roberts", 17, TRUE, 72, 17, '1414 Orange Avenue', 'user17', 'password17', 'user17@example.com'),
    ("Lucas", "T", "Evans", 18, FALSE, 8, 18, '1515 Papaya Place', 'user18', 'password18', 'user18@example.com'),
    ("Lucas", "T", "Evans", 19, TRUE, 8, 19, '1515 Papaya Place', 'user19', 'password19', 'user119@example.com');

/* BUSINESS_OWNER: Owner_ID, Business_Name, Business_Type, Phone_Number, Contact_Info */
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
    (15, 'NovaVoyage Travel Corporation', 'Shopping Mall', '977-901-2345', 'Emily Clark'),
    (16, 'Jimmy Johns', 'Restaurant', '246-935-7890', 'Eric Gutierrez'),
    (17, 'Pizza Hut', 'Restaurant', '246-850-7890', 'Eric Gutierrez'),
    (18, 'McDonalds', 'Restaurant', '246-936-4455', 'Eric Oliver');

/* STATE: State_ID, State_name, Country_Name */
INSERT INTO STATE VALUES
    (1, 'Texas', 'USA'),
    (2, 'Ontario', 'Canada'),
    (3, 'Jalisco', 'Mexico'),
    (4, 'Sonora', 'Mexico'),
    (5, 'Florida', 'USA'),
    (6, 'New York', 'USA'),
    (7, 'Guerrero', 'Mexico'),
	(8, 'Île-de-France', 'France'),
    (9, 'Auvergne-Rhône-Alpes', 'France'),
    (10, 'Hauts-de-France', 'France'),
    (11, 'Provence-Alpes-Côte d''Azur', 'France'),
    (12, 'Grand Est', 'France'),
    (13, 'Occitanie', 'France'),
    (14, 'Nouvelle-Aquitaine', 'France'),
    (15, 'Brittany', 'France'),
    (16, 'Pays de la Loire', 'France'),
    (17, 'Centre-Val de Loire', 'France'),
    (18, 'Normandy', 'France'),
    (19, 'Bourgogne-Franche-Comté', 'France'),
    (20, 'Corsica', 'France'),
    (21, 'French Guiana', 'France'),
    (22, 'Guadeloupe', 'France'),
    (23, 'Martinique', 'France'),
    (24, 'Mayotte', 'France'),
    (25, 'Réunion', 'France');

/* CITY: City_ID, State_ID, City_Name */
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
    (10, 5, 'Tallahassee'),
    (11, 8, 'Paris'),
    (12, 9, 'Lyon'),
    (13, 10, 'Lille'),
    (14, 11, 'Marseille'),
    (15, 12, 'Strasbourg'),
    (16, 13, 'Toulouse'),
    (17, 14, 'Bordeaux'),
    (18, 15, 'Rennes'),
    (19, 16, 'Nantes'),
    (20, 17, 'Tours'),
    (21, 18, 'Rouen'),
    (22, 19, 'Dijon'),
    (23, 20, 'Ajaccio'),
    (24, 21, 'Cayenne'),
    (25, 22, 'Basse-Terre'),
    (26, 23, 'Fort-de-France'),
    (27, 24, 'Mamoudzou'),
    (28, 25, 'Saint-Denis');


/* DESTINATION: Destination_ID, Destination_Description, Country_Name, Member_ID */
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
    (11, 'A vibrant city with diverse culture', 'France', 11),
    (12, 'A blend of historic charm and modern flair', 'France', 12),
    (13, 'Surrounded by stunning natural beauty', 'France', 13),
    (14, 'Gateway to the Canadian Rockies', 'France', 14),
    (15, 'Rich in history and home to iconic landmarks', 'France', 15);

/* TRAVEL_ATTRACTIONS: Attraction_ID, City_ID, Owner_ID, Attraction_name, Attraction_description, Attraction_address, Rating, Opening_hours, Phone_number */
INSERT INTO TRAVEL_ATTRACTIONS VALUES
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
    '505 Chestnut Street, Caliente, Sonora', 5, '11:00 AM', '977-901-2345'),
    (16, 11, 14, 'Eiffel Tower', 'Iconic wrought-iron lattice tower offering city views & visitors can ascend by stairs or elevator.', 'Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France', 4, '9:00 AM', '+33 892 70 12 39'),
    (17, 12, 15, 'Basilique Notre-Dame de Fourvière', '19th-century basilica with Byzantine architecture, a large golden statue of the Virgin Mary & city views.', '8 Place de Fourvière, 69005 Lyon, France', 5, '10:00 AM', '+33 4 78 25 86 31'),
    (18, 13, 14, 'Vieux-Lille', 'Historic district with Flemish architecture, boutiques, cafes, and the Palais des Beaux-Arts de Lille museum.', 'Vieux-Lille, Lille, France', 4, '9:30 AM', '+33 3 20 49 60 06'),
    (19, 14, 14, 'Vieux Port', 'Historic harbor offering boat tours & seafood restaurants, plus landmarks like Fort Saint-Jean & Abbaye Saint-Victor.', 'Quai du Port, 13002 Marseille, France', 4, '10:00 AM', '+33 4 91 39 57 82'),
    (20, 15, 4, 'La Petite France', 'Picturesque medieval quarter with narrow streets, half-timbered houses, canals, and historic buildings.', '67000 Strasbourg, France', 4, '9:00 AM', '+33 3 88 52 28 28'),
    (21, 16, 7, 'Cité de l\'Espace', 'Interactive exhibits & attractions focused on space exploration & astronomy, plus an IMAX theater.', 'Avenue Jean Gonord, 31500 Toulouse, France', 4, '10:00 AM', '+33 5 67 22 23 24'),
    (22, 17, 11, 'La Cité du Vin', 'Modern, multimedia museum on all things wine, with exhibits, tastings & a wine bar with panoramic views.', '134 Quai de Bacalan, 33300 Bordeaux, France', 4, '10:00 AM', '+33 5 56 16 20 20'),
    (23, 18, 14, 'Parc du Thabor', 'Botanical garden with themed gardens, a greenhouse, statues & an aviary, plus walking paths & a playground.', 'Place Saint-Mélaine, 35000 Rennes, France', 4, '7:30 AM', '+33 2 23 62 17 42'),
    (24, 19, 4, 'Machines of the Isle of Nantes', 'Museum with huge, animatronic animal sculptures (a 12m-tall elephant!), plus a carousel & boat rides.', 'Parc des Chantiers, Boulevard Léon Bureau, 44200 Nantes, France', 4, '10:00 AM', '+33 2 40 12 10 00'),
    (25, 20, 7, 'Musée des Beaux-Arts d''Ajaccio', 'Art museum featuring Corsican, Italian & French works, plus sculptures, drawings & decorative arts.', '8 Rue Mazarine, 20000 Ajaccio, France', 4, '10:00 AM', '+33 4 95 21 09 86'),
    (26, 21, 11, 'Fort Cépérou', '17th-century fortification offering panoramic views of the city, plus cultural exhibits & guided tours.', 'Route de la Madeleine, 97300 Cayenne, French Guiana', 4, '9:00 AM', '+594 594 30 94 47'),
    (27, 22, 14, 'Fort Delgrès', 'Historic fort offering panoramic views of the sea & city, plus a museum on local history & culture.', 'Route de la Riviera, 97100 Basse-Terre, Guadeloupe', 4, '9:00 AM', '+590 590 89 18 27'),
    (28, 23, 4, 'La Savane', 'City park with wide lawns, walking paths & statues, plus a monument to Empress Josephine & a botanical garden.', 'Avenue Général de Gaulle, Fort-de-France, Martinique', 4, '6:00 AM', '+596 596 75 03 65'),
    (29, 24, 7, 'Plage de N\'Gouja', 'Scenic beach known for its clear waters & white sand, plus opportunities for snorkeling & sea turtle spotting.', 'N\'Gouja Beach, Mayotte', 4, '6:00 AM', '+262 639 21 83 44'),
    (30, 25, 11, 'Plage de l\'Hermitage', 'Popular beach with calm waters, white sand & palm trees, plus nearby cafes & shops.', 'Plage de l''Hermitage, Réunion', 4, '7:00 AM', '+262 262 21 05 00'),
    (31, 26, 14, 'Musée Départemental de Mayotte', 'Museum featuring exhibits on the history, culture, and natural environment of Mayotte, including artifacts and displays.', 'Maison Cœffier, 5 Rue du Maréchal Leclerc, Mamoudzou, Mayotte', 4, '9:00 AM', '+262 269 61 19 72'),
    (32, 27, 4, 'Fort Boyard', 'Historic fortification located between the Île-d''Aix and the Île d''Oléron in the Pertuis d''Antioche straits.', '1 Fort Boyard, 17300 Île-d''Aix, France', 4, '10:00 AM', '+33 5 46 84 08 00'),
    (33, 28, 7, 'La Soufrière', 'Active stratovolcano located on the island of Basse-Terre in Guadeloupe. Popular hiking destination.', 'La Soufrière, Basse-Terre, Guadeloupe', 4, '6:00 AM', '+590 590 93 86 46'),
    (34, 1, 16, 'Jimmy Johns', 'A sandwhich shop with New Jersey Flair',  
    '246 Wall Street, San Antonio, Texas', 3, '10:00 AM', '246-935-7890'),
    (35, 1, 17, 'Pizza Hut', 'A Pizza buffet and store', 
    '675 Broadway street, San Antonio, Texas', 2, '11:00 AM', '246-850-7890'),
    (36, 1, 18, 'McDonalds', 'A fastfood burger restaurant, with greath deals', 
    '325 London street, San Antonio, Texas', 2, '6:00 AM', '246-936-4455');

/* TRAVEL_ATTRACTIONS_WAYS_OF_TRAVEL: Attraction_ID, Ways_of_travel */
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

/* SHOPPING_MALLS: Mall_ID, Attraction_ID, City_ID, Price_range*/
INSERT INTO SHOPPING_MALLS VALUES
  (1, 3, 3, 500.00),
  (2, 6, 6, 700.00),
  (3, 10, 10, 350.00),
  (4, 12, 2, 215.00),
  (5, 15, 5, 99.99);

/* IMAGES: Image_ID, Member_ID, Image_link */
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
  (15, 15, 'Imagelink0015' ),
  (16, 15, 'Imagelink0016'),
  (17, 7, 'Imagelink0017'),
  (18, 2, 'Imagelink0018'),
  (19, 2, 'Imagelink0019');

/* TRIP_PLAN: Plan_ID, Member_ID, Potential_Cost, Start_Date, End_Date, Duration, Trip_Name, Purpose */
INSERT INTO TRIP_PLAN VALUES
  (1, 1, 10000.00, '2018-12-02', '2018-12-10', 10, 'Super Awesome Vacation', "Awesome vacation with the entire family."),
  (2, 2, 1250.00, '2019-01-02', '2019-01-04', 2, 'Weekend Trip', "Went on a trip over the weekend of Oct. 2nd."),
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
  (15, 15, 750.00, '2008-09-09', '2009-10-10', 31, 'My vacation', "Decided to take a vacation for the end of summer"),
  (16, 16, 29000.00, '2024-05-10', '2024-06-10', 31, 'Vicente Fernandez Musical Tour in France', 'Embark on a musical journey across France, exploring the vibrant culture and heritage through the iconic songs of Vicente Fernandez.'),
  (17, 17, 800.00, '2009-01-15', '2009-02-15', 31, 'Winter Break', "Taking a break this winter"),
  (18, 18, 900.00, '2009-04-10', '2009-05-11', 31, 'Spring Getaway', "Spring getaway to rejuvenate"),
  (19, 19, 850.00, '2009-07-20', '2009-08-20', 31, 'Summer Escape', "Escape the city for summer");

/* PLANNED_ATTRACTIONS: Plan_ID, Attraction_ID, Arrival_Date, Arrival_Time, Departure_Date, Departure_Time */
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
    (15, 15, '2024-04-28', '11:00', '2024-04-28', '15:00'), -- City Lights Mall exploration
    (16, 16, '2024-05-10', '09:00:00', '2024-05-10', '12:00:00'), -- Eiffel Tower in Paris
    (16, 17, '2024-05-11', '10:00:00', '2024-05-11', '13:00:00'), -- Basilique Notre-Dame de Fourvière in Lyon
    (16, 18, '2024-05-12', '09:30:00', '2024-05-12', '12:30:00'), -- Vieux-Lille in Lille
    (16, 19, '2024-05-13', '10:00:00', '2024-05-13', '13:00:00'), -- Vieux Port in Marseille
    (16, 20, '2024-05-14', '09:00:00', '2024-05-14', '12:00:00'), -- La Petite France in Strasbourg
    (16, 21, '2024-05-15', '10:00:00', '2024-05-15', '13:00:00'), -- Cité de l'Espace in Toulouse
    (16, 22, '2024-05-16', '09:30:00', '2024-05-16', '12:30:00'), -- La Cité du Vin in Bordeaux
    (16, 23, '2024-05-17', '09:00:00', '2024-05-17', '12:00:00'), -- Parc du Thabor in Rennes
    (16, 24, '2024-05-18', '10:00:00', '2024-05-18', '13:00:00'), -- Machines of the Isle of Nantes in Nantes
    (16, 25, '2024-05-19', '09:00:00', '2024-05-19', '12:00:00'), -- Musée des Beaux-Arts d'Ajaccio in Ajaccio
    (16, 25, '2024-05-19', '09:00:00', '2024-05-19', '12:00:00'), -- Musée des Beaux-Arts d'Ajaccio in Ajaccio
    (16, 26, '2024-05-20', '10:00:00', '2024-05-20', '13:00:00'), -- Fort Cépérou in Cayenne
    (16, 27, '2024-05-21', '09:30:00', '2024-05-21', '12:30:00'), -- Fort Boyard in Île-d'Aix
    (16, 28, '2024-05-22', '09:00:00', '2024-05-22', '12:00:00'), -- La Soufrière in Basse-Terre
    (16, 29, '2024-05-23', '10:00:00', '2024-05-23', '13:00:00'), -- Plage de N'Gouja in Mayotte
    (16, 30, '2024-05-24', '09:00:00', '2024-05-24', '12:00:00'), -- Plage de l'Hermitage in Réunion
    (16, 31, '2024-05-25', '10:00:00', '2024-05-25', '13:00:00'), -- Musée Départemental de Mayotte in Mamoudzou
    (16, 32, '2024-05-26', '09:30:00', '2024-05-26', '12:30:00'), -- Fort Boyard in Île-d'Aix
    (16, 33, '2024-05-27', '09:00:00', '2024-05-27', '12:00:00'), -- La Soufrière in Basse-Terre
    (16, 1, '2024-05-29', '08:00:00', '2024-05-31', '12:00:00'), -- Visit to Cafe of Death
    (3, 1, '2024-04-12', '09:30:00', '2024-04-13', '10:00:00'), -- Visit to Cafe of Death
    (15, 15, '2024-04-28', '11:00', '2024-04-28', '15:00'), -- City Lights Mall exploration
    (16, 15, '2024-04-29', '10:00', '2024-04-29', '14:00'),
    (17, 17, '2024-04-30', '09:00', '2024-04-30', '13:00'),
    (12, 18, '2024-05-01', '12:00', '2024-05-01', '16:00'),
    (12, 18, '2024-05-01', '12:00', '2024-05-01', '16:00');

/* RESTAURANTS: Restaurant_ID, Attraction_ID, City_ID, Restaurant_name, Restaurant_description, Restaurant_address, Rating, Opening_hours, Phone_number, Restaurant_Type, Price_range, Web_link */
INSERT INTO RESTAURANTS VALUES
    (1, 1, 1, 'Cafe of Death', 'A unique cafe with a spooky theme, serving delicious food and drinks.', '123 Main Street, San Antonio, Texas', 4, '9:00 AM', '123-456-7890', 'Cafe', 100.00, 'www.cafeofdeath.com'),
    (2, 2, 2, 'Moonlit Grille', 'Enjoy fine dining under the moonlight at this elegant restaurant.', '456 Park Avenue, Dallas, Texas', 5, '6:00 PM', '234-567-8901', 'Fine Dining', 2500.00, 'www.moonlitgrille.com'),
    (3, 5, 5, 'Lakeside Eats', 'Relax by the lake and savor delicious food at this waterfront restaurant.', '123 Lakeview Drive, Caliente, Jalisco', 4, '11:00 AM', '567-890-1234', 'Waterfront', 50.00, 'www.lakesideeats.com'),
    (4, 8, 8, 'Cheddars', 'Experience delicious American cuisine in a cozy and inviting atmosphere.', '123 Oak Street, Muy Mal, Sonora', 4, '11:00 AM', '890-123-4567', 'American', 35.00, 'www.cheddars.com'),
    (5, 9, 9, 'Starlight Diner', 'Step back in time and enjoy classic diner fare at this nostalgic eatery.', '456 Elm Avenue, Miami, Florida', 3, '6:00 AM', '901-234-5678', 'Diner', 15.00, 'www.starlightdiner.com'),
    (6, 16, 8, 'Le Champs de Mars', 'Charming French restaurant with a view of the Eiffel Tower, offering classic French cuisine and fine wines.', '1 Rue de la Comète, 75007 Paris, France', 4, '11:00 AM', '+33 1 47 05 37 60', 'French', 50.00, 'www.restaurantlechampsdemars.com'),
    (7, 17, 9, 'Le Basilique Bistro', 'Cozy bistro located near the Basilique Notre-Dame de Fourvière, serving traditional French dishes with a modern twist.', '12 Rue du Bon Pasteur, 69001 Lyon, France', 4, '12:00 PM', '+33 4 78 25 89 99', 'French', 40.00, 'www.lebasiliquebistro.com'),
    (8, 18, 8, 'Vieux-Lille Brasserie', 'Lively brasserie in the heart of Vieux-Lille, offering a wide selection of Belgian and French beers along with hearty regional cuisine.', '18 Rue de la Monnaie, 59000 Lille, France', 4, '10:30 AM', '+33 3 20 06 06 06', 'French, Belgian', 35.00, 'www.vieuxlillebrasserie.com'),
    (9, 19, 10, 'Portside Bistro', 'Quaint bistro overlooking the Vieux Port, specializing in fresh seafood dishes and Provencal cuisine.', '2 Quai de Rive Neuve, 13007 Marseille, France', 4, '11:30 AM', '+33 4 91 90 07 78', 'French, Seafood', 60.00, 'www.portsidebistromarseille.com'),
    (10, 20, 5, 'La Petite France Café', 'Charming café nestled in the heart of La Petite France, serving freshly brewed coffee, homemade pastries, and light French fare.', '10 Rue du Bain aux Plantes, 67000 Strasbourg, France', 4, '8:00 AM', '+33 3 88 36 43 64', 'French, Café', 20.00, 'www.lapetitefrancecafe.com'),
    (11, 21, 8, 'Galactic Café', 'Space-themed café located within the Cité de l\'Espace, offering a unique dining experience with cosmic-inspired dishes and stellar views.', 'Space Street, 31500 Toulouse, France', 4, '10:30 AM', '+33 5 67 89 10 11', 'French, Café', 25.00, 'www.galacticcafe.com'),
    (12, 22, 12, 'Le Vin Rouge', 'Cozy wine bar situated in La Cité du Vin, offering an extensive selection of French wines paired with artisanal cheese and charcuterie.', '8 Rue de la Négresse, 33300 Bordeaux, France', 4, '5:00 PM', '+33 5 56 32 55 88', 'French, Wine Bar', 40.00, 'www.levinrougebordeaux.com'),
    (13, 23, 8, 'Thabor Garden Café', 'Relaxing café located within Parc du Thabor, serving freshly brewed coffee, homemade pastries, and light snacks amidst scenic greenery.', 'Avenue des Français Libres, 35000 Rennes, France', 4, '9:00 AM', '+33 2 99 59 60 61', 'French, Café', 15.00, 'www.thaborgardencafe.com'),
    (14, 24, 5, 'Mechanical Bistro', 'Quirky bistro inspired by the Machines of the Isle of Nantes, offering inventive dishes and craft cocktails in a steampunk ambiance.', '4 Rue des Machines, 44000 Nantes, France', 4, '12:00 PM', '+33 2 40 20 30 40', 'French, Fusion', 45.00, 'www.mechanicalbistronantes.com'),
    (15, 25, 8, 'Artisanal Café', 'Charming café located near Musée des Beaux-Arts d\'Ajaccio, offering artisanal coffee, freshly baked pastries, and light Mediterranean-inspired dishes.', '15 Rue Fesch, 20000 Ajaccio, France', 4, '8:30 AM', '+33 4 95 21 75 89', 'French, Café', 20.00, 'www.artisanalcafeajaccio.com'),
    (16, 34, 1, 'Jimmy Johns', 'A sandwhich shop with New Jersey Flair', '246 Wall Street, San Antonio, Texas', 3, '10:00 AM', '246-935-7890', 'Sandwhich Shop', 18.00, 'www.JimmyJohns.com'),
    (17, 35, 1, 'Pizza Hut', 'A Pizza buffet and restaurant', '675 Broadway street, San Antonio, Texas', 4, '11:00 AM', '246-850-7890','Pizza Store', 30.00, 'www.PizzaHut.com'),
    (18, 36, 1, 'Mcdonalds', 'A fastfood burger restaurant, with greath deals', '325 London street, San Antonio, Texas', 2, '6:00 AM', '246-936-4455','Fastfood', 15.00, 'www.McDonalds.com');

/* SIGHTS: Sight_ID, Attraction_ID, City_ID, Ticket_Price */
INSERT INTO SIGHTS VALUES
    (1, 4, 4, 26.69),
    (2, 7, 7, 32.69),
    (3, 11, 1, 4.2069),
    (4, 13, 3, 80.085),
    (5, 14, 4, 26.50),
    (6, 16, 11, 45.50),
    (7, 17, 12, 30.25),
    (8, 18, 13, 25.75),
    (9, 19, 14, 35.80),
    (10, 20, 15, 40.20),
    (11, 21, 16, 55.30),
    (12, 22, 17, 65.40),
    (13, 23, 18, 70.90),
    (14, 24, 19, 85.20),
    (15, 25, 20, 95.75),
    (16, 26, 21, 150.00),
    (17, 27, 22, 250.00),
    (18, 28, 23, 350.00),
    (19, 29, 24, 450.00),
    (20, 30, 25, 550.00),
    (21, 31, 26, 650.00),
    (22, 32, 27, 750.00),
    (23, 33, 28, 850.00);

/* COMMENTS: Comment_ID, Destination_ID, Member_ID, Dislikes, Likes, Content_Rating, Comment_Date, Posting_Time */
INSERT INTO COMMENTS VALUES
  (1, 1, 1, 5, 3, 2, '2018-12-02', '10:00:00'),
  (2, 2, 2, 10, 7, 3, '2018-12-15', '02:00:00'),
  (3, 3, 3, 15, 11, 4, '2019-01-31', '15:15:15'),
  (4, 4, 4, 20, 15, 5, '2021-10-02', '12:37:45'),
  (5, 5, 5, 25, 19, 6, '2022-11-11', '11:11:11');
  
/* USER_ACTION: Member_ID, Comment_ID, User_Likes, User_Dislikes, User_Reply */
INSERT INTO USER_ACTION VALUES
    (1, 1, TRUE, FALSE, "USER REPLY"),
    (2, 2, FALSE, TRUE, "USER REPLY"),
    (3, 3, TRUE, TRUE, "USER REPLY"),
    (4, 4, FALSE, TRUE, "USER REPLY"),
    (5, 5, TRUE, TRUE, "USER REPLY");

/* ASSOCIATED_MEMBER: Plan_ID, Member_ID */
INSERT INTO ASSOCIATED_MEMBER (Plan_ID, Member_ID) VALUES
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
  (15, 15),
  (16, 15);

/* RATE: Plan_ID, Member_ID, Rating */
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

/* EDIT: Member_ID, Destination_ID, Date_Modified */
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
