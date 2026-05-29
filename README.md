## Healthcare Disease Trends Dashboard


## Project Overview

An end-to-end data analytics project analysing **300 patient records** across **116 diseases** to uncover symptom patterns, demographic risk profiles, and clinical outcome trends — built using Excel, MySQL, and Tableau.

> **Domain edge:** Insights are interpreted through an epidemiological lens informed by an M.Sc. in Microbiology, bridging clinical data patterns with real-world disease mechanisms.

---

## Business Problem

Healthcare analysts and clinical teams need to understand:
- Which diseases drive the highest case burden?
- How do symptoms cluster differently across disease categories?
- What demographic and clinical risk factors correlate with positive outcomes?
- Are certain age groups or genders disproportionately affected?

---

## Dataset

| Detail | Value |
|---|---|
| Source | Kaggle — Disease Symptom & Patient Profile Dataset |
| Raw records | 349 rows |
| After cleaning | 300 rows (49 duplicates removed) |
| Columns | Disease, Fever, Cough, Fatigue, Difficulty Breathing, Age, Gender, Blood Pressure, Cholesterol Level, Outcome Variable |
| Engineered columns | `Age_Group`, `Disease_Category` |

---

## Tools & Tech Stack

| Phase | Tool |
|---|---|
| Data cleaning | Microsoft Excel |
| Analysis & querying | MySQL (6 analytical queries) |
| Visualisation | Tableau Public |
| Version control | GitHub |

---
## Dashboard
![Dashboard Preview](dashboard_preview.png)
## Key Findings

1. **Asthma has the highest positive outcome rate (75%)** among top diseases — patients with asthma are significantly more likely to test positive, suggesting strong clinical presentation.

2. **Respiratory diseases show the strongest symptom clustering** — 76% fever + 68% cough + 78% difficulty breathing, compared to <20% breathing difficulty in cancer and metabolic categories.

3. **Female patients show a higher positive outcome rate (63%)** vs male patients (41%), warranting further investigation into hormonal or immunological factors.

4. **High BP + High Cholesterol = highest positive outcome count (71 cases)** — the most common high-risk profile in this dataset, reinforcing cardiovascular comorbidity signals.

5. **Young adults (18–40) account for 60% of respiratory cases** — a pattern consistent with active infection exposure in working-age populations.

---

**4 views:**
- Top 10 diseases by case volume (horizontal bar)
- Positive outcome rate by disease (colour-coded bar)
- Cases by age group × disease category (stacked bar)
- Symptom heatmap: category vs symptom intensity

---

## Project Structure

```
healthcare-disease-trends/
├── data/
│   ├── Disease_symptom_and_patient_profile_dataset.csv   # raw
│   └── disease_cleaned.csv                               # cleaned
├── sql/
│   └── healthcare_analysis.sql                           # all 6 queries
├── dashboard/
│   └── dashboard_preview.png                             # screenshot
└── README.md
```

---

## How to Reproduce

1. Download `disease_cleaned.csv` from `/data`
2. Import into MySQL using the `CREATE TABLE` statement in `healthcare_analysis.sql`
3. Run queries sequentially — each query maps to a Tableau view
4. Open Tableau Desktop / Public → connect to MySQL or CSV → build views

---

## Author

**Ishwarya R** — Data Analyst  
[LinkedIn](https://linkedin.com/in/ishwarya-r-data-analyst) · [GitHub](https://github.com/ishuravi001)  
M.Sc. Microbiology | Skilled in SQL · Python · Tableau · Power BI · Excel

