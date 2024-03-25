--top rated video games


-- finds the 100 top rated videogames
SELECT *
FROM [imdb-videogames_ratings]
ORDER BY rating DESC
LIMIT 100;

--shows what years the 100 top videogames were made
SELECT YEAR , COUNT(*) AS count
FROM (
    SELECT *
    FROM [imdb-videogames_ratings]
    ORDER BY rating DESC
    LIMIT 100
) AS top_games
GROUP BY YEAR
ORDER BY count DESC;


--shows what certificates were most common in the top 100
SELECT certificate , COUNT(*) AS count
FROM (
    SELECT *
    FROM [imdb-videogames_ratings]
    ORDER BY rating DESC
    LIMIT 100
) AS top_games
GROUP BY certificate
ORDER BY count DESC;

--shows what genre was most popular in the 100 top games
SELECT
    SUM(CASE WHEN Action = 'True' THEN 1 ELSE 0 END) AS Action,
    SUM(CASE WHEN Adventure = 'True' THEN 1 ELSE 0 END) AS Adventure,
    SUM(CASE WHEN Comedy = 'True' THEN 1 ELSE 0 END) AS Comedy,
    SUM(CASE WHEN Crime = 'True' THEN 1 ELSE 0 END) AS Crime,
    SUM(CASE WHEN Family = 'True' THEN 1 ELSE 0 END) AS Family,
    SUM(CASE WHEN Fantasy = 'True' THEN 1 ELSE 0 END) AS Fantasy,
    SUM(CASE WHEN Mystery = 'True' THEN 1 ELSE 0 END) AS Mystery,
    SUM(CASE WHEN [Sci-Fi] = 'True' THEN 1 ELSE 0 END) AS [Sci-Fi],
    SUM(CASE WHEN Thriller = 'True' THEN 1 ELSE 0 END) AS Thriller
FROM (
    SELECT *
    FROM [imdb-videogames_ratings]
    ORDER BY rating DESC
    LIMIT 100
) AS top_games;

