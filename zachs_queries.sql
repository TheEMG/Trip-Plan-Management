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