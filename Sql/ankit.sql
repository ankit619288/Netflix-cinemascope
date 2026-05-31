--- Section:1 Extracting Data
--- 1. Create a table movies with appropriate data types to match the schema of the movies.csv file.

CREATE TABLE movies (
    name VARCHAR(255),
    rating VARCHAR(50),
    genre VARCHAR(100),
    year INT,
    released VARCHAR(255),
    score FLOAT,
    votes FLOAT,
    director VARCHAR(255),
    writer VARCHAR(255),
    star VARCHAR(255),
    country VARCHAR(100),
    budget FLOAT,
    gross FLOAT,
    company VARCHAR(255),
    runtime FLOAT
);

''' 2. Import the movies.csv file into the movies table using SQL or a suitable tool
(e.g., SQL Server Import Wizard, PostgreSQL COPY, etc.).'''

select * from movies

--- 3. Display the first 10 records from the table to verify successful import.

SELECT *
FROM movies
LIMIT 10;

--- 4. List all distinct genres available in the dataset.

SELECT DISTINCT genre
FROM movies
ORDER BY genre;

--- 5. Check the number of missing values in critical columns like name, genre, year, score, budget, and gross.

SELECT
    COUNT(*) FILTER (WHERE name IS NULL OR TRIM(name) = '') AS missing_name,
    COUNT(*) FILTER (WHERE genre IS NULL OR TRIM(genre) = '') AS missing_genre,
    COUNT(*) FILTER (WHERE year IS NULL) AS missing_year,
    COUNT(*) FILTER (WHERE score IS NULL) AS missing_score,
    COUNT(*) FILTER (WHERE budget IS NULL) AS missing_budget,
    COUNT(*) FILTER (WHERE gross IS NULL) AS missing_gross
FROM movies;

---  Section:2 Transforming Data
--- 1. Update missing countries with 'Unknown' and standardize the country column values (e.g., trimming whitespace).

UPDATE movies
SET country = 'Unknown'
WHERE country IS NULL
   OR TRIM(country) = '';
--- To check whether missing countries were updated to 'Unknown', run this query:   
SELECT country
FROM movies
WHERE country = 'Unknown';



--- 2. Fill missing gross values with 0 for financial calculations.

UPDATE movies
SET gross = 0
WHERE gross IS NULL;

--- Check rows having gross = 0

SELECT COUNT(*) AS updated_rows
FROM movies
WHERE gross = 0;

--- 3. Create a derived column profitability as gross - budget.

--- We create a new column first.

ALTER TABLE movies
ADD COLUMN profitability FLOAT;

--- Now calculate:

UPDATE movies
SET profitability = gross - budget;

--- To check the output of profitability = gross - budget, run:

SELECT
    name,
    gross,
    budget,
    profitability
FROM movies
LIMIT 10;

''' 4.  **Create a new column `score_category`** to label movies as `'High'`, `'Medium'`, or `'Low'` based on IMDb score:
    - High: ≥ 8
    - Medium: 5–7.9
    - Low: < 5 '''

--- Create column:

ALTER TABLE movies
ADD COLUMN score_category VARCHAR(20);

--- Now categorize scores.

UPDATE movies
SET score_category =
CASE
    WHEN score >= 8 THEN 'High'
    WHEN score >= 5 AND score < 8 THEN 'Medium'
    WHEN score < 5 THEN 'Low'
    ELSE 'Unknown'
END;

--- output

SELECT
    score,
    score_category,
    CASE
        WHEN score >= 8 THEN 'Correct High'
        WHEN score >= 5 AND score < 8 THEN 'Correct Medium'
        WHEN score < 5 THEN 'Correct Low'
    END AS verification
FROM movies
LIMIT 15;

''' 5. Extract year from the released column if its not consistent with the year column 
(optional for checking data quality).'''

--- this checks if extracted year and year column are different.
SELECT
    name,
    year,
    released,
    SUBSTRING(released FROM '[0-9]{4}')::INT AS extracted_year
FROM movies
WHERE year <> SUBSTRING(released FROM '[0-9]{4}')::INT
limit 15;

--- Section:3 Preparing for Load / Export 
''' 1. Create a cleaned version of the data by selecting only valid entries
(non-null name, genre, year, score, etc.) into a new table movies_cleaned.'''
--- This keeps only valid records.

DROP TABLE IF EXISTS movies_cleaned;

CREATE TABLE movies_cleaned AS
SELECT *
FROM movies
WHERE name IS NOT NULL
  AND TRIM(name) <> ''
  AND genre IS NOT NULL
  AND TRIM(genre) <> ''
  AND year IS NOT NULL
  AND score IS NOT NULL;
--- output:
select * from movies_cleaned
limit 15

--- 2. Add a decade column to group movies by their release decade (e.g., 1990s, 2000s, etc.).
--- Add decade column

ALTER TABLE movies_cleaned
ADD COLUMN decade VARCHAR(20);

--- Now update decade:
UPDATE movies_cleaned
SET decade = CONCAT((year / 10) * 10, 's')

---Check result:
SELECT name, year, decade
FROM movies_cleaned
LIMIT 10;

--- 3. Check for duplicate movie names and release years, and identify any duplicates in the dataset.
--- Check duplicate movie names and years
SELECT
    name,
    year,
    COUNT(*) AS duplicate_count
FROM movies_cleaned
GROUP BY name, year
HAVING COUNT(*) > 1;
--- If output is empty, no duplicate movie-name/year combinations exist

--- 4. Sort the cleaned data by year of release and gross earnings to prepare for Excel export.
--- Sort cleaned data
SELECT year,gross
FROM movies_cleaned
ORDER BY year ASC, gross DESC;

''' 5. Export the cleaned and transformed data from SQL to Excel/CSV using your database tool or via SQL command 
(e.g., COPY, SELECT INTO OUTFILE, or GUI export options).'''
SELECT *
FROM movies_cleaned
ORDER BY year ASC, gross DESC;