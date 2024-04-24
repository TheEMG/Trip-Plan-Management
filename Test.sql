USE Erics;

/* Query 4. Retrieve the names and countries of all 
 * preferred users who never visited the US. */

/* Authorized_Member --> Associated_Members --> TRIP PLAN --> Planned attractions --> Travel Attraction --> City --> State --> Country
*/
SELECT AuM.Member_Name, PA.Plan_ID, TA.Attraction_Name, City_ID
FROM Authorized_Member AuM
RIGHT JOIN Associated_Member AsM ON AuM.Member_ID = AsM.Member_ID
INNER JOIN Planned_Attractions PA ON AsM.Plan_ID = PA.Plan_ID
INNER JOIN Travel_Attractions TA ON PA.Attraction_ID = TA.Attraction_ID;
