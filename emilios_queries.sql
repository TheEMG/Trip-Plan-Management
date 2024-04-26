USE Erics;
/* Emilio Zuniga
 * Dr. Yi Li
 * COSC 4385
 * 23 April 2024 */

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