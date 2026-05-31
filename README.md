# DA02 CinemaScope Analytics

## Unveiling the Dynamics of Movie Success

This project is an end-to-end movie industry analytics case study built around the Netflix entertainment domain. It combines business understanding, SQL data cleaning, Excel analysis, Power BI dashboarding, and n8n GenAI automation to explain what makes movies financially and critically successful.

The project starts with raw movie data, transforms it into a clean analytical dataset, builds dashboards for business decision-making, and automates plain-English movie performance insights using n8n and a GenAI API.

## Project Objective

The main objective is to analyze movie performance using business, financial, and audience metrics so that an entertainment company can make better decisions about content investment, genre strategy, actor/director selection, and ROI improvement.

Key questions answered in this project:

- Which genres generate the highest profit?
- Does a high budget always lead to high gross revenue?
- Which movies, stars, directors, and countries perform strongly?
- What is the relationship between IMDb score, votes, budget, gross, and profitability?
- How can automated workflows explain movie performance without manually opening dashboards?

## Tech Stack

| Area | Tools Used |
| --- | --- |
| Database and ETL | PostgreSQL, SQL |
| Data Cleaning | SQL, Excel |
| Analysis | Excel, Power BI |
| Dashboarding | Power BI Desktop |
| Automation | n8n |
| GenAI | Groq OpenAI-compatible Chat Completions API |
| API Testing | Postman |
| Documentation | Word, PowerPoint, README |

## Repository Structure

```text
cinemascope-analytics-github/
|-- README.md
|-- VIDEO_SCRIPT.md
|-- .gitignore
|-- data/
|   |-- Raw Movies file.csv
|   `-- movies_cleaned_excel.xlsx
|-- sql/
|   |-- ankit.sql
|   |-- ankitsql file.docx
|   `-- Sql clean File.csv
|-- dashboard/
|   |-- Movies Dashboard.pbix
|   `-- Power Bi file.csv
|-- n8n/
|   |-- workflows/
|   |   |-- AI_Movie_Recommendation___Explanation_Automation1.json
|   |   `-- Automated_Movie_Performance_Insight_Generator.json
|   `-- screenshots/
|       |-- 1st n8n.png
|       |-- 2nd N8n.png
|       |-- output 1st n8n.PNG
|       |-- output 2nd n8n.png
|       `-- 2 output 2nd  n8n.png
`-- reports/
    |-- Netflix problem.docx
    |-- Case Studies Netflix.docx
    |-- complete document netflix.docx
    `-- netflix final ppt.pptx
```

## Dataset Summary

The project uses a movie dataset containing details such as movie name, genre, release year, IMDb score, votes, director, writer, star, country, budget, gross revenue, company, and runtime.

| Metric | Value |
| --- | ---: |
| Raw records | 7,668 |
| Cleaned records | 7,665 |
| Year range | 1980-2020 |
| Genres | 19 |
| Countries | 60 |
| Average IMDb score | 6.39 |
| Total gross revenue | $587.11B |
| Total profitability | $364.30B |
| Average budget | $25.52M |

Derived fields created during cleaning:

- `profitability = gross - budget`
- `score_category = High / Medium / Low`
- `decade = release decade`

## End-to-End Workflow

1. Business case study
   - Selected Netflix as the entertainment platform.
   - Studied platform features such as recommendations, originals, multi-device access, subtitles, downloads, and subscription plans.
   - Identified business problems around content discovery, churn, regional growth, and ROI.

2. Schema design
   - Designed a streaming-platform data model with users, profiles, content, genres, subscriptions, payments, watch history, ratings, devices, and recommendations.
   - Connected business entities to analytics use cases such as retention, billing, personalization, and content planning.

3. SQL ETL
   - Created a PostgreSQL table for raw movie data.
   - Imported the raw CSV file.
   - Checked missing values in critical columns.
   - Cleaned and transformed the dataset.
   - Created a final `movies_cleaned` table for Excel and Power BI.

4. Excel analysis
   - Performed EDA on genre, country, score, budget, gross, runtime, company, star, and director fields.
   - Built pivot-based analysis and answered 20 business questions.

5. Power BI dashboard
   - Built an interactive movie performance dashboard.
   - Tracked total gross, total profit, genre profit, country distribution, budget vs gross, top profitable movies, score categories, and trends.

6. n8n and GenAI automation
   - Built one scheduled workflow for automated movie insight emails.
   - Built one webhook workflow for question-answer based movie explanations.

## SQL ETL Pipeline

The SQL script is available at:

```text
sql/ankit.sql
```

Main SQL steps:

- Create the `movies` table.
- Import raw CSV data.
- Preview imported rows.
- List distinct genres.
- Check missing values in important columns.
- Replace missing countries with `Unknown`.
- Fill missing gross values for calculations.
- Add `profitability`.
- Add `score_category`.
- Validate year consistency from the `released` column.
- Create `movies_cleaned`.
- Add `decade`.
- Check duplicate movie and year combinations.
- Export cleaned data for Excel and Power BI.

Important transformation example:

```sql
ALTER TABLE movies
ADD COLUMN profitability FLOAT;

UPDATE movies
SET profitability = gross - budget;
```

```sql
ALTER TABLE movies
ADD COLUMN score_category VARCHAR(20);

UPDATE movies
SET score_category =
CASE
    WHEN score >= 8 THEN 'High'
    WHEN score >= 5 AND score < 8 THEN 'Medium'
    WHEN score < 5 THEN 'Low'
    ELSE 'Unknown'
END;
```

## Power BI Dashboard

Power BI file:

```text
dashboard/Movies Dashboard.pbix
```

Dashboard source CSV:

```text
dashboard/Power Bi file.csv
```

Dashboard pages:

- Overall Dashboard
- Key Analysis

Main dashboard KPIs and insights:

- Total gross revenue: $587.11B
- Total profitability: about $364.30B
- Action is the strongest profit genre.
- Comedy has the highest movie volume.
- United States dominates movie production count.
- Budget and gross have a positive relationship, but high budget does not guarantee high profit.
- Franchise/event movies such as Avatar, Avengers: Endgame, Titanic, Star Wars, Jurassic World, and The Lion King are among the top profitability drivers.

If Power BI shows a data source path error, open Power BI Desktop and update the CSV source path to:

```text
dashboard/Power Bi file.csv
```

## Key Business Insights

### 1. Genre Performance

Action is the highest profit-generating genre, with approximately $154.90B total profitability. Comedy has the highest number of movies, but volume alone does not guarantee profit.

Top genres by total profitability:

| Genre | Movie Count | Total Profit |
| --- | ---: | ---: |
| Action | 1,704 | $154.90B |
| Animation | 338 | $56.73B |
| Comedy | 2,245 | $54.38B |
| Drama | 1,516 | $32.18B |
| Adventure | 427 | $28.54B |

### 2. ROI Perspective

Family shows the highest genre-level ROI in the cleaned dataset, but the sample size is small. Horror, Mystery, Animation, Adventure, and Action also show strong return potential.

### 3. Top Profitable Movies

| Movie | Genre | Year | Profitability |
| --- | --- | ---: | ---: |
| Avatar | Action | 2009 | $2.61B |
| Avengers: Endgame | Action | 2019 | $2.44B |
| Titanic | Drama | 1997 | $2.00B |
| Star Wars: Episode VII - The Force Awakens | Action | 2015 | $1.82B |
| Avengers: Infinity War | Action | 2018 | $1.73B |
| Jurassic World | Action | 2015 | $1.52B |
| The Lion King | Animation | 2019 | $1.41B |
| Furious 7 | Action | 2015 | $1.33B |

### 4. Country Analysis

The United States leads production count by a large margin, followed by the United Kingdom, France, Canada, Germany, and Australia.

### 5. Business Recommendation

For high-budget investments, prioritize proven genres, franchise potential, strong audience demand, director history, star pull, and score/vote benchmarks. For lower-risk bets, compare expected ROI with genre-level ROI and budget patterns before approving production.

## n8n Automation

### Workflow 1: Automated Movie Performance Insight Generator

Workflow file:

```text
n8n/workflows/Automated_Movie_Performance_Insight_Generator.json
```

Purpose:

This workflow automatically fetches top movie performance records from PostgreSQL, formats them into a GenAI prompt, generates a professional plain-text insight summary, and sends it through email.

Workflow steps:

1. Schedule Trigger
2. PostgreSQL query
3. Code node for prompt formatting
4. HTTP Request to GenAI API
5. Send Email node

Generated email sections:

- Top performing movies
- ROI insights
- High-budget failures
- Genre trends
- Investment recommendations

Screenshot:

![Automated insight workflow](<n8n/screenshots/1st n8n.png>)

Sample email output:

![Weekly email output](<n8n/screenshots/output 1st n8n.PNG>)

### Workflow 2: AI Movie Recommendation and Explanation Automation

Workflow file:

```text
n8n/workflows/AI_Movie_Recommendation___Explanation_Automation1.json
```

Purpose:

This workflow receives a movie-related question through a webhook, fetches relevant movie data from PostgreSQL, creates context using a Code node, sends the question and data to a GenAI model, and returns a plain-text answer to the webhook caller.

Workflow steps:

1. Webhook
2. PostgreSQL query
3. Code node for question-aware filtering
4. HTTP Request to GenAI API
5. Respond to Webhook

Example API request:

```http
POST http://localhost:5678/webhook/movie-analysis-2
Content-Type: application/json

{
  "question": "top 5 imdb movie?"
}
```

The webhook path may change after import. Use the exact production/test URL shown inside your n8n Webhook node. During testing, Postman was used to send JSON questions and verify responses.

Screenshots:

![Webhook workflow](<n8n/screenshots/2nd N8n.png>)

![Postman webhook output](<n8n/screenshots/output 2nd n8n.png>)

## How to Run This Project

### 1. Clone the repository

```bash
git clone <your-repository-url>
cd cinemascope-analytics-github
```

### 2. Set up PostgreSQL

Create a PostgreSQL database and run:

```text
sql/ankit.sql
```

Then import:

```text
data/Raw Movies file.csv
```

After cleaning, the final exported dataset is available as:

```text
sql/Sql clean File.csv
```

### 3. Open Excel analysis

Open:

```text
data/movies_cleaned_excel.xlsx
```

This workbook contains the cleaned dataset and multiple solution sheets for analysis questions.

### 4. Open Power BI dashboard

Open:

```text
dashboard/Movies Dashboard.pbix
```

If Power BI asks for a source file, connect it to:

```text
dashboard/Power Bi file.csv
```

### 5. Import n8n workflows

In n8n:

1. Go to Workflows.
2. Click Import from File.
3. Import the JSON files from `n8n/workflows/`.
4. Configure PostgreSQL credentials.
5. Configure email/SMTP credentials.
6. Configure the GenAI API key.
7. Test each node.
8. Activate the workflows.

### 6. Test webhook workflow with Postman

Use a POST request with JSON body:

```json
{
  "question": "Why did The Dark Knight perform well?"
}
```

Expected output:

The workflow should return a business-readable answer explaining performance using IMDb score, votes, gross revenue, budget, ROI, genre, and runtime.

## Security Note Before Uploading to GitHub

Do not upload real API keys, database passwords, email passwords, or SMTP credentials to GitHub.

The n8n workflow files in this repository have been prepared with placeholder API-key references. Before running the workflows, add your real credentials inside n8n credential settings or environment variables.

Recommended approach:

- Use n8n Credentials for PostgreSQL and email.
- Store GenAI keys in environment variables.
- Keep `.env` files out of GitHub.
- Rotate any API key that was previously hard-coded in a workflow export.

## Reports and Presentation

Final combined report:

```text
reports/complete document netflix.docx
```

Case study document:

```text
reports/Case Studies Netflix.docx
```

Final presentation:

```text
reports/netflix final ppt.pptx
```

These documents explain the full project from business understanding to dashboarding and automation.

## Future Improvements

- Add predictive modeling for gross revenue and ROI.
- Add genre-level recommendation scoring.
- Build a Streamlit or Flask app for movie performance search.
- Connect Power BI directly to PostgreSQL instead of CSV.
- Add scheduled GitHub Actions for data validation.
- Improve n8n workflow security using only credential variables.

## Author

Ankit Mishra  
DA02  
Entertainment / Movie Industry Analytics  
Project: CinemaScope Analytics - Unveiling the Dynamics of Movie Success
