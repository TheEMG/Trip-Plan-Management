USE Erics;
SET SQL_SAFE_UPDATES = 0;
DROP VIEW IF EXISTS Restaurants_San_Antonio_Texas_USA;
DROP VIEW IF EXISTS View_CountriesAndMembersVisited;
DROP VIEW IF EXISTS Iteneraries_To_France;
DROP VIEW IF EXISTS COUNTRIES_VISITED_WITH_US;
SET SQL_SAFE_UPDATES = 1;


-- View 1
-- Retrieve all restaurants in San Antonio, Texas, USA
CREATE VIEW Restaurants_San_Antonio_Texas_USA AS
SELECT 
    R.Restaurant_ID,
    R.Restaurant_name,
    R.Restaurant_address,
    R.Rating
FROM 
    RESTAURANTS R
JOIN 
    TRAVEL_ATTRACTIONS TA ON R.Attraction_ID = TA.Attraction_ID
JOIN
    CITY C ON TA.City_ID = C.City_ID
JOIN
    STATE S ON C.State_ID = S.State_ID
JOIN 
    COUNTRY CTR ON S.Country_Name = CTR.Country_Name
WHERE 
    CTR.Country_Name = 'USA' 
    AND S.State_name = 'Texas'
    AND C.City_Name = 'San Antonio';



-- View 2
CREATE VIEW View_CountriesAndMembersVisited AS
SELECT 
    COUNTRY.Country_Name,
    AUTHORIZED_MEMBER.FName,
    AUTHORIZED_MEMBER.LName
FROM 
    COUNTRY
JOIN 
    STATE ON COUNTRY.Country_Name = STATE.Country_Name
JOIN 
    CITY ON STATE.State_ID = CITY.State_ID
JOIN 
    TRAVEL_ATTRACTIONS ON CITY.City_ID = TRAVEL_ATTRACTIONS.City_ID
JOIN 
    PLANNED_ATTRACTIONS ON TRAVEL_ATTRACTIONS.Attraction_ID = PLANNED_ATTRACTIONS.Attraction_ID
JOIN 
    TRIP_PLAN ON PLANNED_ATTRACTIONS.Plan_ID = TRIP_PLAN.Plan_ID
JOIN 
    AUTHORIZED_MEMBER ON TRIP_PLAN.Member_ID = AUTHORIZED_MEMBER.Member_ID
GROUP BY 
    COUNTRY.Country_Name, AUTHORIZED_MEMBER.FName, AUTHORIZED_MEMBER.LName
ORDER BY 
    COUNTRY.Country_Name, AUTHORIZED_MEMBER.LName, AUTHORIZED_MEMBER.FName;



-- View 3: Retrieve itineraries to France.
CREATE VIEW Iteneraries_To_France AS
	SELECT TP.Plan_ID, TP.Trip_Name FROM TRIP_PLAN TP
	INNER JOIN PLANNED_ATTRACTIONS PA ON TP.Plan_ID = PA.Plan_ID
	INNER JOIN TRAVEL_ATTRACTIONS TA ON PA.Attraction_ID = TA.Attraction_ID
	INNER JOIN CITY C ON TA.City_ID = C.City_ID
	INNER JOIN STATE S ON C.State_ID = S.State_ID
	WHERE S.Country_Name LIKE "France"
	GROUP BY TP.Plan_ID, TP.Trip_Name;



-- View 4: Retrieve the country(s) visited by whom also visits/visited the US on the same trip (within 15 days).
CREATE VIEW COUNTRIES_VISITED_WITH_US AS
SELECT S1.Country_Name
FROM 
    PLANNED_ATTRACTIONS P1 -- Gets PLANNED_ATTRACTIONS
JOIN 
    TRAVEL_ATTRACTIONS TA1 ON P1.Attraction_ID = TA1.Attraction_ID  -- Joins PLANNED_ATTRACTIONS and TRAVEL_ATTRACIONS
JOIN 
    CITY C1 ON TA1.City_ID = C1.City_ID  -- Joins TRAVEL_ATTRACTIONS and CITY
JOIN 
    STATE S1 ON C1.State_ID = S1.State_ID  -- Joins CITY and STATE
WHERE S1.Country_Name <> 'USA' AND EXISTS (SELECT * -- Makes sure S1 is not in the USA and compares to another date
			  FROM 
					PLANNED_ATTRACTIONS P2   -- GETS PLANNED_ATTRACTIONS
			 RIGHT JOIN 
					TRAVEL_ATTRACTIONS TA2 ON P2.Attraction_ID = TA2.Attraction_ID  -- Connects PLANNED_ATTRACTIONS and TRAVEL_ATTRACTIONS
			 RIGHT JOIN 
					CITY C2 ON TA2.City_ID = C2.City_ID  -- Joins TRAVEL_ATTRACTIONS and CITY
			 RIGHT JOIN 
					STATE S2 ON C2.State_ID = S2.State_ID  -- Joins CITY and STATE
							  WHERE P1.Plan_ID = P2.Plan_ID AND S2.Country_Name = 'USA' -- Makes sure S2 is in the USA
							  AND (P2.Arrival_Date BETWEEN DATE_ADD(P1.Arrival_Date, INTERVAL -15 DAY)
												   AND DATE_ADD(P1.Arrival_Date, INTERVAL 15 DAY) 
							  OR P2.Departure_Date BETWEEN DATE_ADD(P1.Departure_Date, INTERVAL -15 DAY)
												   AND DATE_ADD(P1.Departure_Date, INTERVAL 15 DAY)));