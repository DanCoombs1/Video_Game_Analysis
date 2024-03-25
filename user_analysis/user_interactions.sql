--user interactions


--shows the correlation between the number of votes a video game got and the rating it was given to try and understand user interaction
-- rating_vote_correlation
SELECT
    ((COUNT(*) * SUM(rating * votes)) - (SUM(rating) * SUM(votes))) /
    (SQRT((COUNT(*) * SUM(rating * rating)) - (SUM(rating) * SUM(rating))) *
     SQRT((COUNT(*) * SUM(votes * votes)) - (SUM(votes) * SUM(votes)))) AS pearson_correlation
FROM
    [imdb-videogames_ratings]
WHERE
    rating IS NOT NULL
    AND votes IS NOT NULL;

-- shows the correlation between the number of votes a video game got and the year it was released
-- year_vote_correlation
SELECT
    ((COUNT(*) * SUM(votes * year)) - (SUM(votes) * SUM(year))) /
    (SQRT((COUNT(*) * SUM(votes * votes)) - (SUM(votes) * SUM(votes))) *
     SQRT((COUNT(*) * SUM(year * year)) - (SUM(year) * SUM(year)))) AS pearson_correlation
FROM
    [imdb-videogames_ratings]
WHERE
    votes IS NOT NULL
    AND year IS NOT NULL;
   
-- shows the correlation between the rating a video game received and the certificate it was given
-- -- rating_certificate_correlation
SELECT
    ((COUNT(*) * SUM(rating * certificate)) - (SUM(rating) * SUM(certificate))) /
    (SQRT((COUNT(*) * SUM(rating * rating)) - (SUM(rating) * SUM(rating))) *
     SQRT((COUNT(*) * SUM(certificate * certificate)) - (SUM(certificate) * SUM(certificate)))) AS pearson_correlation
FROM
    [imdb-videogames_ratings]
WHERE
    rating IS NOT NULL
    AND certificate IS NOT NULL;