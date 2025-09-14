# Music Streaming Analytics with SQL (PostgreSQL / pgAdmin4)
This project explores user behavior in a simulated music streaming dataset using PostgreSQL (pgAdmin4). I designed and executed SQL queries to perform exploratory data analysis (EDA), customer segmentation, and churn analysis. Key insights include subscription trends, churn rates, listening behavior, and engagement by demographics and device type.


## Skills demonstrated:

1. **Writing SQL queries for aggregation, filtering, and grouping**
2. **Using functions (SUM, AVG, ROUND, COUNT, type casting) for analytical calculations**
3. **Customer churn analysis (churn rate calculation)**
4. **Business performance metrics by subscription type and device usage**
5. **Translating business problems into SQL queries for decision-making**

## Tools & Technologies: 

1. **PostgreSQL**
2. **pgAdmin4**
3. **SQL**

## Objectives

1. **Set up a spotify churn database**: Create and populate a spotify churn database with the provided churn data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the churn data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `Spotify_churn.db`.
- **Table Creation**: A table named `Spotify_subs` is created to store the churn data. The table structure includes columns for user_id, gender, age, country, subscription_type, listening_time, songs_played_per_day, skip_rate, device_type, ads_listened_per_week, offline_listening and is_churned.

```sql
CREATE DATABASE Spotify_churn.db;

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
			);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique subscribers are in the dataset.
- **Category Count**: Identify all unique subscriptions in the dataset.
- **Null Value Check**: Check for any null values in the dataset.

```sql

SELECT
COUNT (*)
FROM spotify_subs;

SELECT COUNT(DISTINCT user_id) as total_subs FROM spotify_subs;

SELECT subscription_type, Count (*) AS total_count
FROM spotify_subs
GROUP BY subscription_type;


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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Count the total users by subscription type**
```sql
SELECT subscription_type, COUNT(*) AS total_users
FROM spotify_subs
GROUP BY subscription_type
ORDER BY total_users DESC
```
2. **Find the average listening time per subscription type**
```sql
SELECT subscription_type, AVG(listening_time) AS avg_listening_time
FROM spotify_subs
GROUP BY subscription_type
```
3. **Get the churn rate (percentage of users churned)**
```sql
SELECT 
    ROUND(100.0 * SUM(is_churned)::NUMERIC / COUNT(*), 2) AS churn_rate_percent
FROM spotify_subs
```
4. **Find the top 3 countries with the highest number of users**
```sql
SELECT country, COUNT(*) AS total_users
FROM spotify_subs
GROUP BY country
ORDER BY total_users DESC
LIMIT 3
```
5. **Average skip rate by device type**
```sql
SELECT device_type, AVG(skip_rate) as avg_skip_rate
FROM spotify_subs
GROUP BY device_type
ORDER BY avg_skip_rate DESC
```
6. **Find the number of churned users by subscription type**
```sql
SELECT subscription_type, COUNT (*) as churned_users
FROM spotify_subs
WHERE is_churned = 1
GROUP BY subscription_type
ORDER BY churned_users DESC
```
7. **Identify users who listened to the most songs (top 5)**
```sql
SELECT user_id, songs_played_per_day
FROM spotify_subs
GROUP BY user_id
ORDER BY songs_played_per_day DESC
LIMIT 5
```
8. **Average ads listened for Free vs Premium users**
```sql
SELECT subscription_type, AVG(ads_listened_per_week) as avg_ads_listened
FROM spotify_subs
WHERE subscription_type IN ('Free', 'Premium')
GROUP BY subscription_type
ORDER BY avg_ads_listened DESC
```

9. **Find the average listening time by gender**
```sql
SELECT gender, AVG(listening_time) as avg_listening_time
FROM spotify_subs
GROUP BY gender;
```

10. **Show churn rate by subscription type**
```sql
SELECT subscription_type, ROUND(100.0 * SUM(is_churned)::NUMERIC/Count (*),2) as churn_rate
FROM spotify_subs
GROUP BY subscription_type
```

## Findings

-**Customer Demographics:** The dataset includes users from multiple countries, genders, and age groups, providing insights into diverse listening behaviors.

-**Subscription Insights:** Users are segmented into Free, Premium, Student, and Family subscriptions, with clear differences in churn rates and engagement.

-**Listening Behavior:** Analysis of listening time, skip rate, and songs played highlights patterns in user engagement across subscription and device types.

-**Churn Analysis:** The churn rate was calculated to identify how many users discontinued their subscriptions, with higher churn observed in Free users.

-**Device Usage:** Users access the platform via Web, Mobile, and Desktop, with differences in skip rates and ad exposure across devices.

## Reports

-**Subscription Summary:** Aggregated counts of users by subscription type, including churned vs active users.

-**Churn Report:** Calculation of overall churn rate and churn distribution by subscription category.

-**Engagement Analysis:** Average listening time, skip rate, and ads listened segmented by subscription type and device.

-**Demographic Insights:** Gender- and country-based breakdowns of listening behavior and churn patterns.

-**Top Users Report:** Identification of the most engaged users based on songs played and listening time.

## Conclusion

This project demonstrates how SQL can be used for business-focused analytics in a music streaming context. By applying aggregation, grouping, and calculation queries, we uncover meaningful insights into customer behavior, churn patterns, and engagement drivers. These findings illustrate how businesses can make data-driven decisions to improve retention, optimize subscriptions, and enhance customer experience.

## How to Use

1.**Clone the Repository**: Clone this project repository from GitHub.

2.**Set Up the Database**: Import the dataset into PostgreSQL using pgAdmin4 or psql.

3.**Run the Queries**: Execute the queries in the analysis_queries.sql file to reproduce the analysis.

4.**Explore and Extend**: Modify or create new queries to answer additional business questions and gain deeper insights.

## Author - Danielle Salazar

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/danislzr)

Thank you for your support, and I look forward to connecting with you!
