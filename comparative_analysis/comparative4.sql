--gets average rating per certificate
--avg_rating_by_certificate

SELECT
    certificate,
    AVG(rating) AS average_rating
FROM
    [imdb-videogames_ratings]
WHERE
    certificate IS NOT NULL
    AND certificate NOT IN ('unrated', 'Not Rated')
GROUP BY
    certificate
ORDER BY
    average_rating DESC;
    
--shows the average rating of each genre
SELECT
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
ORDER BY
    rating DESC;