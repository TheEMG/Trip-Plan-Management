USE Erics;


-- Zachary's Queries :D

/* Query 5: For all country(s) visited by those who also visited the US 
on the same trip (within 15 days), retrieve the distinct names of the countries. */

SELECT DISTINCT S1.Country_Name
FROM 
    TRIP_PLAN TP1 -- sets a TRIP_PLAN
JOIN 
    PLANNED_ATTRACTIONS P1 ON TP1.Plan_ID = P1.Plan_ID  -- Joins TRIP_PLAN and PLANNED_ATTRACTIONS
JOIN 
    TRAVEL_ATTRACTIONS TA1 ON P1.Attraction_ID = TA1.Attraction_ID  -- Joins PLANNED_ATTRACTIONS and TRAVEL_ATTRACIONS
JOIN 
    CITY C1 ON TA1.City_ID = C1.City_ID  -- Joins TRAVEL_ATTRACTIONS and CITY
JOIN 
    STATE S1 ON C1.State_ID = S1.State_ID  -- Joins CITY and STATE
WHERE S1.Country_Name != 'USA' AND EXISTS (SELECT * -- Makes sure S1 is not in the USA and compares to another date
			  FROM TRIP_PLAN TP2 -- gets a TRIP_PLAN
			  JOIN 
					PLANNED_ATTRACTIONS P2 ON TP2.Plan_ID = P2.Plan_ID  -- Joins TRIP_PLAN And PLANNED_ATTRACTIONS
			  JOIN 
					TRAVEL_ATTRACTIONS TA2 ON P2.Attraction_ID = TA2.Attraction_ID  -- Connects PLANNED_ATTRACTIONS and TRAVEL_ATTRACTIONS
			  JOIN 
					CITY C2 ON TA2.City_ID = C2.City_ID  -- Joins TRAVEL_ATTRACTIONS and CITY
			  JOIN 
					STATE S2 ON C2.State_ID = S2.State_ID  -- Joins CITY and STATE
							  WHERE TP1.Plan_ID = TP2.Plan_ID AND S2.Country_Name = 'USA' -- Makes sure S2 is in the USA
							  AND (P2.Arrival_Date BETWEEN DATE_ADD(P1.Arrival_Date, INTERVAL -15 DAY)
												   AND DATE_ADD(P1.Arrival_Date, INTERVAL 15 DAY) 
							  OR P2.Departure_Date BETWEEN DATE_ADD(P1.Departure_Date, INTERVAL -15 DAY)
												   AND DATE_ADD(P1.Departure_Date, INTERVAL 15 DAY)));
                                                   
/* Query 6: Retrieve the contact information of the business owner 
who owns the most expensive restaurant and the owner who owns the most assets in the system.*/

SELECT BUSINESS_OWNER.Contact_Info
FROM BUSINESS_OWNER -- Gets BUSINESS_OWNER
JOIN 
		TRAVEL_ATTRACTIONS ON BUSINESS_OWNER.Owner_ID = TRAVEL_ATTRACTIONS.Owner_ID -- Joins TRAVEL_ATTRACTIONS and BUSINESS_OWNER
JOIN
		RESTAURANTS ON TRAVEL_ATTRACTIONS.Attraction_ID = RESTAURANTS.Attraction_ID -- Joins RESTAURANTS and TRAVEL_ATTRACTIONS
WHERE RESTAURANTS.Price_range = (SELECT MAX(RESTAURANTS.Price_range) -- Gets the BUSINESS_OWNER with the most expensive RESTAURANT
								 FROM RESTAURANTS); -- NEED TO FINISH FROM HERE

-- Query7: Retrieve the names of the 5 most desirable France cities to visit
SELECT 
    CITY.City_Name,  -- The name of the city from the CITY table
    COUNT(DISTINCT TRIP_PLAN.Plan_ID) AS NumberOfTrips  -- Counts unique trip plans per city
FROM 
    TRIP_PLAN  -- The table that contains details about each trip plan
JOIN 
    PLANNED_ATTRACTIONS ON TRIP_PLAN.Plan_ID = PLANNED_ATTRACTIONS.Plan_ID  -- Linking trip plans to attractions
JOIN 
    TRAVEL_ATTRACTIONS ON PLANNED_ATTRACTIONS.Attraction_ID = TRAVEL_ATTRACTIONS.Attraction_ID  -- Connects planned attractions to actual attractions
JOIN 
    CITY ON TRAVEL_ATTRACTIONS.City_ID = CITY.City_ID  -- Joins attractions to their cities
JOIN 
    STATE ON CITY.State_ID = STATE.State_ID  -- Joins cities to their states to filter by country
WHERE 
    STATE.Country_Name = 'France'  -- Filters cities to only include those in France
GROUP BY 
    CITY.City_Name  -- Groups results by city name
ORDER BY 
    NumberOfTrips DESC  -- Order cities by the number of trip plans, descending
LIMIT 5;  -- Limits results to the top 5 cities

-- Query 8. Retrieve the username and status of the member who either posted any comments or created any itinerary between 12/01/2018 and 1/31/2019.
SELECT DISTINCT AM.User_Name, AM.Is_Preferred
FROM AUTHORIZED_MEMBER AM
WHERE AM.Member_ID IN (
    -- Starting subquery to find member IDs from trip plans within specified date range
    SELECT TP.Member_ID
    FROM TRIP_PLAN TP
    WHERE TP.Start_Date BETWEEN '2018-12-01' AND '2019-01-31' -- Checking if the start date of the trip is within the date range
    OR TP.End_Date BETWEEN '2018-12-01' AND '2019-01-31' -- Checking again if but this time the end date??? I think this is necessary 
    UNION -- Combinie member IDs from comments with the same date range
    SELECT C.Member_ID
    FROM COMMENTS C
    WHERE C.Comment_Date BETWEEN '2018-12-01' AND '2019-01-31' -- Checking if the date of the comment is within the date range (Only one time since we only have one date)
);


SELECT 
    CITY.City_Name,  -- The name of the city from the CITY table
    COUNT(DISTINCT TRIP_PLAN.Plan_ID) AS NumberOfTrips  -- Counts unique trip plans per city
FROM 
    TRIP_PLAN  -- The table that contains details about each trip plan
JOIN 
    PLANNED_ATTRACTIONS ON TRIP_PLAN.Plan_ID = PLANNED_ATTRACTIONS.Plan_ID  -- Linking trip plans to attractions
JOIN 
    TRAVEL_ATTRACTIONS ON PLANNED_ATTRACTIONS.Attraction_ID = TRAVEL_ATTRACTIONS.Attraction_ID  -- Connects planned attractions to actual attractions
JOIN 
    CITY ON TRAVEL_ATTRACTIONS.City_ID = CITY.City_ID  -- Joins attractions to their cities
JOIN 
    STATE ON CITY.State_ID = STATE.State_ID  -- Joins cities to their states to filter by country
WHERE 
    STATE.Country_Name = 'France'  -- Filters cities to only include those in France
GROUP BY 
    CITY.City_Name  -- Groups results by city name
ORDER BY 
    NumberOfTrips DESC  -- Order cities by the number of trip plans, descending
LIMIT 5;  -- Limits results to the top 5 cities

-- Query 8. Retrieve the username and status of the member who either posted any comments or created any itinerary between 12/01/2018 and 1/31/2019.
SELECT DISTINCT AM.User_Name, AM.Is_Preferred
FROM AUTHORIZED_MEMBER AM
WHERE AM.Member_ID IN (
    -- Starting subquery to find member IDs from trip plans within specified date range
    SELECT TP.Member_ID
    FROM TRIP_PLAN TP
    WHERE TP.Start_Date BETWEEN '2018-12-01' AND '2019-01-31' -- Checking if the start date of the trip is within the date range
    OR TP.End_Date BETWEEN '2018-12-01' AND '2019-01-31' -- Checking again if but this time the end date??? I think this is necessary 
    UNION -- Combinie member IDs from comments with the same date range
    SELECT C.Member_ID
    FROM COMMENTS C
    WHERE C.Comment_Date BETWEEN '2018-12-01' AND '2019-01-31' -- Checking if the date of the comment is within the date range (Only one time since we only have one date)
);