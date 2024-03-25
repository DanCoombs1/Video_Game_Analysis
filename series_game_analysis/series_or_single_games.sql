--series or single games

--creates a new table to keep all the titles
CREATE TABLE TitleVariations (
    id INTEGER PRIMARY KEY,
    title TEXT
);

-- Insert title data from imdb-videogames_ratings
INSERT INTO TitleVariations (title)
SELECT name
FROM [imdb-videogames_ratings];

--creates a new table where the base titles will be stores
CREATE TABLE BaseTitles (
    base_title TEXT,
    title TEXT
);


--goes through all titles and strips them down to their base
WITH BaseTitles AS (
    SELECT DISTINCT
        CASE
            -- If the title contains a ':', extract the base title up to the ':'
            WHEN title LIKE '%:%' THEN SUBSTR(title, 1, INSTR(title, ':') - 1)
            -- If the title contains a number, extract the base title up to the number
            WHEN title GLOB '*[0-9]*' THEN SUBSTR(title, 1, LENGTH(title) - LENGTH(STRFTIME('%Y', title)) - 1)
            -- If the title ends with a Roman numeral, remove it
            WHEN title GLOB '* [IVXLCDM]*' THEN 
                CASE 
                    WHEN INSTR(title, ' I ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' I ') - 1)
                    WHEN INSTR(title, ' II ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' II ') - 1)
                    WHEN INSTR(title, ' III ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' III ') - 1)
                    WHEN INSTR(title, ' IV ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' IV ') - 1)
                    WHEN INSTR(title, ' V ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' V ') - 1)
                    WHEN INSTR(title, ' VI ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' VI ') - 1)
                    WHEN INSTR(title, ' VII ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' VII ') - 1)
                    WHEN INSTR(title, ' VIII ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' VIII ') - 1)
                    WHEN INSTR(title, ' IX ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' IX ') - 1)
                    WHEN INSTR(title, ' X ') > 0 THEN SUBSTR(title, 1, INSTR(title, ' X ') - 1)
                    ELSE title
                END
            -- Otherwise, the entire title is considered the base title
            ELSE title
        END AS base_title
    FROM
        TitleVariations
)
    
-- Perform fuzzy matching - matches the base title up with its original
INSERT INTO NewBaseTitles (base_title, title)
SELECT base_title, title
FROM BaseTitles
JOIN TitleVariations ON instr(TitleVariations.title, BaseTitles.base_title) > 0;

--cleans the data
DELETE FROM NewBaseTitles
WHERE LENGTH(base_title) < 3;

DELETE FROM NewBaseTitles
WHERE base_title = 'Adventure' AND base_title NOT LIKE '%Adventure %' AND base_title NOT LIKE '% Adventure%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Dark' AND base_title NOT LIKE '%Dark %' AND base_title NOT LIKE '% Dark%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Dragon' AND base_title NOT LIKE '%Dragon %' AND base_title NOT LIKE '% Dragon%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Battle' AND base_title NOT LIKE '%Battle %' AND base_title NOT LIKE '% Battle%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Warrior' AND base_title NOT LIKE '%Warrior %' AND base_title NOT LIKE '% Warrior%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Shadow' AND base_title NOT LIKE '%Shadow %' AND base_title NOT LIKE '% Shadow%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Ninja' AND base_title NOT LIKE '%Ninja %' AND base_title NOT LIKE '% Ninja%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Black' AND base_title NOT LIKE '%Black %' AND base_title NOT LIKE '% Black%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Blood' AND base_title NOT LIKE '%Blood %' AND base_title NOT LIKE '% Blood%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Lost' AND base_title NOT LIKE '%Lost %' AND base_title NOT LIKE '% Lost%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Gun' AND base_title NOT LIKE '%Gun %' AND base_title NOT LIKE '% Gun%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Hunt' AND base_title NOT LIKE '%Hunt %' AND base_title NOT LIKE '% Hunt%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Warriors' AND base_title NOT LIKE '%Warriors %' AND base_title NOT LIKE '% Warriors%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Revenge' AND base_title NOT LIKE '%Revenge %' AND base_title NOT LIKE '% Revenge%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Ball' AND base_title NOT LIKE '%Ball %' AND base_title NOT LIKE '% Ball%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Kingdom' AND base_title NOT LIKE '%Kingdom %' AND base_title NOT LIKE '% Kingdom%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Magic' AND base_title NOT LIKE '%Magic %' AND base_title NOT LIKE '% Magic%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'One' AND base_title NOT LIKE '%One %' AND base_title NOT LIKE '% One%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Sky' AND base_title NOT LIKE '%Sky %' AND base_title NOT LIKE '% Sky%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Myst' AND base_title NOT LIKE '%Myst %' AND base_title NOT LIKE '% Myst%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Empire' AND base_title NOT LIKE '%Empire %' AND base_title NOT LIKE '% Empire%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Dungeon' AND base_title NOT LIKE '%Dungeon %' AND base_title NOT LIKE '% Dungeon%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Combat' AND base_title NOT LIKE '%Combat %' AND base_title NOT LIKE '% Combat%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Blade' AND base_title NOT LIKE '%Blade %' AND base_title NOT LIKE '% Blade%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Hunter' AND base_title NOT LIKE '%Hunter %' AND base_title NOT LIKE '% Hunter%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Project' AND base_title NOT LIKE '%Project %' AND base_title NOT LIKE '% Project%'; 

DELETE FROM NewBaseTitles
WHERE base_title = 'Warrior' AND base_title NOT LIKE '%Warrior %' AND base_title NOT LIKE '% Warrior%'; 




-- counts the amount of different video games each title has
--game_series_count
SELECT base_title, COUNT(*) AS version_count
FROM NewBaseTitles
GROUP BY base_title
ORDER BY version_count DESC;

-- shows the base_title with its respective title and t=rating
--base_title_ratings
CREATE TABLE CombinedData AS
SELECT n.base_title, n.title, r.rating
FROM NewBaseTitles n
JOIN [imdb-videogames_ratings] r ON n.title = r.name;

SELECT * FROM CombinedData 

-- gets the average rating for all games that have a sequel
SELECT AVG(average_rating) AS average_rating_series
FROM (
    SELECT base_title, AVG(rating) AS average_rating
    FROM CombinedData
    GROUP BY base_title
    HAVING COUNT(*) > 1
) AS subquery_alias;

--gets the average rating for all games that only have one release
SELECT AVG(average_rating) AS average_rating_single_game
FROM (
    SELECT base_title, AVG(rating) AS average_rating
    FROM CombinedData
    GROUP BY base_title
    HAVING COUNT(*) = 1
) AS subquery_alias;