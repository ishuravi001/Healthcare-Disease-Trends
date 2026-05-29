-- ============================================================
-- Healthcare Disease Trends Analysis
-- Dataset: Disease Symptom & Patient Profile (300 records)
-- Tools: MySQL | Tableau | Excel
-- Author: Ishwarya R | Data Analyst Portfolio Project
-- ============================================================

-- STEP 1: CREATE TABLE
CREATE DATABASE IF NOT EXISTS healthcare_db;
USE healthcare_db;

CREATE TABLE disease_data (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    disease         VARCHAR(100),
    fever           ENUM('Yes','No'),
    cough           ENUM('Yes','No'),
    fatigue         ENUM('Yes','No'),
    difficulty_breathing ENUM('Yes','No'),
    age             INT,
    gender          ENUM('Male','Female'),
    blood_pressure  ENUM('Low','Normal','High'),
    cholesterol_level ENUM('Low','Normal','High'),
    outcome_variable ENUM('Positive','Negative'),
    age_group       VARCHAR(30),
    disease_category VARCHAR(30)
);
USE healthcare_db;

LOAD DATA LOCAL INFILE 'C:/path/to/disease_cleaned.csv'
INTO TABLE disease_data
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
select * from disease_cleaned 
-- ANALYSIS QUERIES
-- ============================================================

-- Q1: Top 10 diseases by case count + share
SELECT
    disease,
    COUNT(*) AS total_cases,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM disease_cleaned), 2) AS pct_share
FROM disease_cleaned
GROUP BY disease
ORDER BY total_cases DESC
LIMIT 10;

-- Q2: Cases by Age Group and Disease Category (for stacked bar chart)
SELECT
    age_group,
    disease_category,
    COUNT(*) AS cases
FROM disease_cleaned
GROUP BY age_group, disease_category
ORDER BY age_group, cases DESC;

-- Q3: Positive outcome rate by disease (top 10 diseases)
SELECT
    disease,
    COUNT(*) AS total_cases,
    SUM(CASE WHEN `Outcome Variable` = 'Positive' THEN 1 ELSE 0 END) AS positive_cases,
    ROUND(
        SUM(CASE WHEN `Outcome Variable` = 'Positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    1) AS positive_rate_pct
FROM disease_cleaned
WHERE disease IN (
    SELECT disease FROM (
        SELECT disease FROM disease_cleaned
        GROUP BY disease ORDER BY COUNT(*) DESC LIMIT 10
    ) AS top10
)
GROUP BY disease
ORDER BY positive_rate_pct DESC;


describe disease_cleaned;

-- Q4: Symptom presence rate by disease category (for heatmap)
SELECT
    disease_category,
    COUNT(*) AS total,
    ROUND(SUM(CASE WHEN fever = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS fever_pct,
    ROUND(SUM(CASE WHEN cough = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS cough_pct,
    ROUND(SUM(CASE WHEN fatigue = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS fatigue_pct,
    ROUND(SUM(CASE WHEN 'Difficulty Breathing' = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS breathing_pct
FROM disease_cleaned
GROUP BY disease_category
ORDER BY total DESC;

-- Q5: Gender vs Outcome
SELECT
    gender,
    `Outcome Variable`,
    COUNT(*) AS count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY gender), 1) AS pct_within_gender
FROM disease_cleaned
GROUP BY gender, `Outcome Variable`;

-- Q6: Risk profile — Blood Pressure + Cholesterol vs Outcome
SELECT
    'Blood Pressure',
    'Cholesterol Level',
    'Outcome Variable',
    COUNT(*) AS count
FROM disease_cleaned
GROUP BY 'Blood Pressure', 'Cholesterol Level', 'Outcome Variable'
ORDER BY 'Blood Pressure', 'Cholesterol Level', 'Outcome Variable';

-- BONUS: Key Insight Query — High-risk profile identification
SELECT
    'Disease Category',
    'Blood Pressure',
    'Cholesterol Level',
    ROUND(
        SUM(CASE WHEN `Outcome Variable` = 'Positive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    1) AS positive_rate_pct,
    COUNT(*) AS sample_size
FROM disease_cleaned
GROUP BY 'Disease Category', 'Blood Pressure', 'Cholesterol Level'
HAVING sample_size >= 5
ORDER BY positive_rate_pct DESC;




