-- CREATE TABLE

CREATE TABLE spotify_subs
			(
				user_id	INT PRIMARY KEY,
				gender VARCHAR(10),	
				age INT,
				country VARCHAR(10),	
				subscription_type VARCHAR(10),	
				listening_time INT,	
				songs_played_per_day INT,	
				skip_rate FLOAT,	
				device_type	VARCHAR(15),
				ads_listened_per_week INT,	
				offline_listening INT,	
				is_churned INT
			)


SELECT * FROM spotify_subs

ALTER TABLE spotify_subs
ALTER COLUMN skip_rate TYPE DOUBLE PRECISION USING skip_rate::DOUBLE PRECISION

SELECT
COUNT (*)
FROM spotify_subs;

-- DATA CLEANING

SELECT * FROM spotify_subs
WHERE
	user_id	is NULL
	OR
	gender is NULL
	OR
	age is NULL
	OR
	country is NULL
	OR
	subscription_type is NULL
	OR
	listening_time is NULL
	OR
	songs_played_per_day is NULL
	OR
	skip_rate is NULL
	OR
	device_type is NULL
	OR
	ads_listened_per_week is NULL
	OR
	offline_listening is NULL
	OR
	is_churned is NULL;

-- DATA EXPLORATION

-- how many free, premium, family and student subscriptions do we have?

SELECT subscription_type, Count (*) AS total_count
FROM spotify_subs
GROUP BY subscription_type

-- How many unique subscribers we have ?

SELECT COUNT(DISTINCT user_id) as total_subs FROM spotify_subs

-- DATA ANALYSIS & BUSINESS PROBLEMS AND ANSWERS

-- QUESTIONS
-- Q1 Count the total users by subscription type
-- Q2 Find the average listening time per subscription type
-- Q3 Get the churn rate (percentage of users churned)
-- Q4 Find the top 3 countries with the highest number of users
-- Q5 Average skip rate by device type
-- Q6 Find the number of churned users by subscription type
-- Q7 Identify users who listened to the most songs (top 5)
-- Q8 Average ads listened for Free vs Premium users
-- Q9 Find the average listening time by gender
-- Q10 Show churn rate by subscription type


-- Q1 Count the total users by subscription type

SELECT subscription_type, COUNT(*) AS total_users
FROM spotify_subs
GROUP BY subscription_type
ORDER BY total_users DESC

-- Q2 Find the average listening time per subscription type

SELECT subscription_type, AVG(listening_time) AS avg_listening_time
FROM spotify_subs
GROUP BY subscription_type

-- Q3 Get the churn rate (percentage of users churned)

SELECT 
    ROUND(100.0 * SUM(is_churned)::NUMERIC / COUNT(*), 2) AS churn_rate_percent
FROM spotify_subs

-- Q4 Find the top 3 countries with the highest number of users

SELECT country, COUNT(*) AS total_users
FROM spotify_subs
GROUP BY country
ORDER BY total_users DESC
LIMIT 3

-- Q5 Average skip rate by device type

SELECT device_type, AVG(skip_rate) as avg_skip_rate
FROM spotify_subs
GROUP BY device_type
ORDER BY avg_skip_rate DESC

-- Q6 Find the number of churned users by subscription type

SELECT subscription_type, COUNT (*) as churned_users
FROM spotify_subs
WHERE is_churned = 1
GROUP BY subscription_type
ORDER BY churned_users DESC

-- Q7 Identify users who listened to the most songs (top 5)

SELECT user_id, songs_played_per_day
FROM spotify_subs
GROUP BY user_id
ORDER BY songs_played_per_day DESC
LIMIT 5

-- Q8 Average ads listened for Free vs Premium users

SELECT subscription_type, AVG(ads_listened_per_week) as avg_ads_listened
FROM spotify_subs
WHERE subscription_type IN ('Free', 'Premium')
GROUP BY subscription_type
ORDER BY avg_ads_listened DESC


-- Q9 Find the average listening time by gender

SELECT gender, AVG(listening_time) as avg_listening_time
FROM spotify_subs
GROUP BY gender;


-- Q10 Show churn rate by subscription type

SELECT subscription_type, ROUND(100.0 * SUM(is_churned)::NUMERIC/Count (*),2) as churn_rate
FROM spotify_subs
GROUP BY subscription_type

-- END OF PROJECT