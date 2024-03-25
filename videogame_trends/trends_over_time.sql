-- trends over time



--averages the rating and counts the games released for each year and orders them based on average rating
-- it also disregards any years with less than 10 games released
--avg_rating_by_year
SELECT 
    SUBSTR(year, 1, 4) AS release_year,
    AVG(rating) AS avg_rating,
    game_count
FROM 
    [imdb-videogames_ratings] t1
JOIN (
    SELECT 
        SUBSTR(year, 1, 4) AS release_year,
        COUNT(*) AS game_count
    FROM 
        [imdb-videogames_ratings]
    GROUP BY 
        SUBSTR(year, 1, 4)
) t2 ON SUBSTR(t1.year, 1, 4) = t2.release_year
WHERE
    rating IS NOT NULL
GROUP BY 
    SUBSTR(year, 1, 4), game_count
HAVING 
    COUNT(*) >= 10
ORDER BY 
    avg_rating DESC;
    
   
   
--this will count the games by their closest whole number rating for each year  --rounded_rating_count
SELECT 
    SUBSTR(year, 1, 4) AS release_date,
    ROUND(rating) AS rounded_rating,
    COUNT(*) AS rating_count
FROM 
    [imdb-videogames_ratings]
WHERE
    rating IS NOT NULL
GROUP BY 
    SUBSTR(year, 1, 4),
    ROUND(rating)
ORDER BY 
    release_date, rounded_rating;
    
   
   
 -- shows how many games were released by each category each decade
   -- genre_by_decade
SELECT 
    SUBSTR(year, 1, 3) || '0s' AS decade,
    SUM(CASE WHEN Action = 'True' THEN 1 ELSE 0 END) AS Action,
    SUM(CASE WHEN Adventure = 'True' THEN 1 ELSE 0 END) AS Adventure,
    SUM(CASE WHEN Comedy = 'True' THEN 1 ELSE 0 END) AS Comedy,
    SUM(CASE WHEN Crime = 'True' THEN 1 ELSE 0 END) AS Crime,
    SUM(CASE WHEN Family = 'True' THEN 1 ELSE 0 END) AS Family,
    SUM(CASE WHEN Fantasy = 'True' THEN 1 ELSE 0 END) AS Fantasy,
    SUM(CASE WHEN Mystery = 'True' THEN 1 ELSE 0 END) AS Mystery,
    SUM(CASE WHEN [Sci-Fi] = 'True' THEN 1 ELSE 0 END) AS [Sci-Fi],
    SUM(CASE WHEN Thriller = 'True' THEN 1 ELSE 0 END) AS Thriller
FROM 
    [imdb-videogames_ratings]
GROUP BY 
    decade;   
   
-- shows what decade was best (highest average rating) for each genre - can identify trends in games - see what game to make now
--  avg_genre_rating_by_decade
SELECT 
    SUBSTR(year, 1, 3) || '0s' AS decade,
    AVG(CASE WHEN Action = 'True' THEN rating ELSE NULL END) AS average_rating_action,
    AVG(CASE WHEN Adventure = 'True' THEN rating ELSE NULL END) AS average_rating_Adventure,
    AVG(CASE WHEN Comedy = 'True' THEN rating ELSE NULL END) AS average_rating_Comedy,
    AVG(CASE WHEN Crime = 'True' THEN rating ELSE NULL END) AS average_rating_Crime,
    AVG(CASE WHEN Family = 'True' THEN rating ELSE NULL END) AS average_rating_Family,
    AVG(CASE WHEN Fantasy = 'True' THEN rating ELSE NULL END) AS average_rating_Fantasy,
    AVG(CASE WHEN Mystery = 'True' THEN rating ELSE NULL END) AS average_rating_Mystery,
    AVG(CASE WHEN [Sci-Fi] = 'True' THEN rating ELSE NULL END) AS [average_rating_Sci-Fi],
    AVG(CASE WHEN Thriller = 'True' THEN rating ELSE NULL END) AS average_rating_Thriller
FROM 
    [imdb-videogames_ratings]
GROUP BY
    SUBSTR(year, 1, 3)
ORDER BY
    SUBSTR(year, 1, 3);
   