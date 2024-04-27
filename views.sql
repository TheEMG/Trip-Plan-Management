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