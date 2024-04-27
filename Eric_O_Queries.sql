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