Create TABLE applestore_description AS
SELECT * from appleStore_description1
UNION ALL
SELECT * from appleStore_description2
UNION ALL
SELECT * from appleStore_description3
UNION ALL
SELECT * from appleStore_description4

** Exploratory Data Analysis **

-- check the number of unique apps in both tables 
SELECT COUNT(Distinct id) As UniqueIDs
from AppleStore

SELECT COUNT(Distinct id) As UniqueIDs
from applestore_description

-- checking for missing values in key fields
SELECT COUNT(*) As missing_values
From AppleStore
where track_name is null or user_rating is null or prime_genre is null 

SELECT COUNT(*) As missing_values
From applestore_description
where app_desc is null

-- Find out the number of app per genres
SELECT prime_genre , COUNT(*) AS Numapps
From AppleStore
Group By prime_genre
order by Numapps DESC

-- Overview of app ratings

SELECT min(user_rating) MinRating,
       max(user_rating) MaxRating,
       avg(user_rating) AvgRatin
FROM AppleStore

** Data Analysis **

-- Determine whether paid apps have higher ratings than Free apps

SELECT case 
            when price> 0 then  'Paid'
            Else  'Free'
            end as app_type,
            avg(user_rating) AvgRating
from AppleStore
GROUP by app_type
-- Check whether app which supports more languages have higher ratings

SELECT Case 
            when lang_num > 10 then '< 10 languages '
            when lang_num BETWEEN 10 and 30 then '10-30 languages'
            else '>30 languages '
            end as Num_of_lang,
            avg(user_rating) Avg_rating
from AppleStore
group by Num_of_lang

-- check genres with low rating 
select prime_genre,
avg(user_rating) avg_ratings
from AppleStore
GROUP by prime_genre
order by avg_ratings

-- checking if there is correaltion betwwen length of app description and user rating 
Select case when length(b.app_desc) < 500 then 'short'
            when length(b.app_desc) between 500 and 1000 then 'Medium '
            Else 'Long'
            end as description_length,
            avg(user_rating) avg_rating
from AppleStore as a 
JOIN applestore_description as b
on a.id= b.id
GROUP by description_length
order by avg_rating desc
-- check the top rated apps for each category 
select track_name,

       prime_genre
from AppleStore
group by prime_genre
HAVING max(user_rating)

-- Coclusion 
-- 1. Paid apps have better ratings 
-- 2. Apps supporting between 10 to 30 languages have better ratings 
-- 3. Finance and book apps have lower ratings 
-- 4. Apps with longer descrition have better ratings 
-- 5. A new app should aim for an average rating above 3.5 
-- 6. Games and entertainment high user demand and high competition 
