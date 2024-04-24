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
 
 