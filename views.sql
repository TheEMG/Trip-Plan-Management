USE Erics;

-- create view 1
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
    
    SELECT *
FROM Restaurants_San_Antonio_Texas_USA;



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