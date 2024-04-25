USE Erics;

-- Query: Retrieve the names of the 5 most desirable France cities to visit
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