USE Erics;

-- Eric Oliver
-- Query 1
-- Retrieve the names, addresses, and estimated-prices of the 3 most popular restaurants in New York city, US.
-- I modified this to San Antonio, Texas instead of New York city, US.
SELECT 
    Restaurant_name,
    Restaurant_address,
    Price_range
FROM 
    RESTAURANTS AS R
JOIN 
    TRAVEL_ATTRACTIONS AS TA ON R.Attraction_ID = TA.Attraction_ID
JOIN 
    CITY AS C ON TA.City_ID = C.City_ID
JOIN 
    DESTINATION AS D ON TA.City_ID = D.Destination_ID
WHERE 
    D.Country_Name = 'USA' 
    AND C.City_Name = 'San Antonio'
ORDER BY 
    R.Rating DESC
LIMIT 3;

-- Eric Oliver
-- Query 2
-- Retrieve the username, status (regular or preferred), and ranking of the member who has uploaded the most pictures.
SELECT 
    U.User_Name,
    U.Is_Preferred,
    U.Ranking
FROM 
    AUTHORIZED_MEMBER AS U
JOIN 
    IMAGES AS I ON U.Member_ID = I.Member_ID
GROUP BY 
    U.Member_ID
ORDER BY 
    COUNT(I.Image_ID) DESC
LIMIT 1;
-- Zachary's Queries :D

/* Query 5: For all country(s) visited by those who also visited the US 
on the same trip (within 15 days), retrieve the distinct names of the countries. */

SELECT DISTINCT S1.Country_Name
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
                                                   
/* Query 6: Retrieve the contact information of the business owner 
who owns the most expensive restaurant and the owner who owns the most assets in the system.*/

SELECT BUSINESS_OWNER.Contact_Info
FROM BUSINESS_OWNER -- Gets BUSINESS_OWNER
RIGHT JOIN 
		TRAVEL_ATTRACTIONS ON BUSINESS_OWNER.Owner_ID = TRAVEL_ATTRACTIONS.Owner_ID -- Joins TRAVEL_ATTRACTIONS and BUSINESS_OWNER
LEFT JOIN
		RESTAURANTS ON TRAVEL_ATTRACTIONS.Attraction_ID = RESTAURANTS.Attraction_ID -- Joins RESTAURANTS and TRAVEL_ATTRACTIONS
WHERE RESTAURANTS.Price_range = (SELECT MAX(RESTAURANTS.Price_range) -- Gets the BUSINESS_OWNER with the most expensive RESTAURANT
								 FROM RESTAURANTS)
		OR TRAVEL_ATTRACTIONS.Owner_ID = (SELECT MAX(ASSETS.count_owners)
										  FROM (SELECT Owner_ID, COUNT(Owner_ID) AS count_owners
												FROM TRAVEL_ATTRACTIONS
                                                GROUP BY Owner_ID
                                                ORDER BY count_owners DESC
                                                ) AS ASSETS)
LIMIT 2;

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

/* Query 4. Retrieve the names and countries of all 
 * preferred users who never visited the US. */
SELECT AuM.FName, AuM.LName
FROM Authorized_Member AuM
RIGHT JOIN Associated_Member AsM ON AuM.Member_ID = AsM.Member_ID
INNER JOIN Planned_Attractions PA ON AsM.Plan_ID = PA.Plan_ID
INNER JOIN Travel_Attractions TA ON PA.Attraction_ID = TA.Attraction_ID
INNER JOIN City C ON TA.City_ID = C.City_ID
INNER JOIN State S ON C.State_ID = S.State_ID
INNER JOIN Country Co ON S.Country_Name = Co.Country_Name
WHERE Co.Country_Name NOT LIKE "USA"
GROUP BY AuM.Member_ID;

/* Query 9. For each member who has visited all the
 * states/provinces in France, retrieve the maximum, 
 * minimum and average daily cost per person, per day 
 * across all these related itineraries (considering 
 * restaurant and attraction cost only). */
SELECT AuM.FName, AuM.LName, MAX(person_daily_cost) AS max_daily_cost, MIN(person_daily_cost) AS min_daily_cost, AVG(person_daily_cost) AS avg_daily_cost
FROM(
    SELECT AsM.Member_ID, TP.Plan_ID, TP.Duration, (SUM(R.Price_range) + SUM(TP.Potential_Cost)) / TP.Duration AS person_daily_cost
    FROM AUTHORIZED_MEMBER AuM
    INNER JOIN ASSOCIATED_MEMBER AsM ON AuM.Member_ID = AsM.Member_ID
    INNER JOIN TRIP_PLAN TP ON AsM.Plan_ID = TP.Plan_ID
    INNER JOIN PLANNED_ATTRACTIONS PA ON TP.Plan_ID = PA.Plan_ID
    INNER JOIN TRAVEL_ATTRACTIONS TA ON PA.Attraction_ID = TA.Attraction_ID
    LEFT JOIN RESTAURANTS R ON TA.Attraction_ID = R.Attraction_ID
    INNER JOIN CITY C ON TA.City_ID = C.City_ID
    INNER JOIN STATE S ON C.State_ID = S.State_ID
    INNER JOIN COUNTRY CO ON s.Country_Name = CO.Country_Name
    WHERE CO.Country_Name = 'France'
    GROUP BY AsM.Member_ID, TP.Plan_ID, TP.Duration
)AS subquery
INNER JOIN AUTHORIZED_MEMBER AuM ON subquery.Member_ID = AuM.Member_ID
GROUP BY AuM.FName, AuM.LName;