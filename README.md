# Football Match Intelligence System

**Prepared by:** Samuel Mati  || **Role:** Data Analyst | SQL Developer  ||  **Date:** 6th December 2025

---

## Executive Summary

This is a self-initiated project born from a genuine interest in football and a desire to apply serious analytical techniques to the game I follow. Football generates thousands of data points every match, including goals, passes, formations, substitutions, cards, and expected goals (xG). Raw data alone rarely explains why a team wins, loses, or underperforms.

I built this project to answer that question for Manchester United's 2023/24 Premier League season. Using PostgreSQL, I investigated tactical decisions, evaluated player performance, and transformed raw match data into football intelligence. Each query begins with a real football question and delivers a concrete, evidence-based answer.

The system is delivered as an interactive application, available here:

**Live Project:** https://samuel-mati.github.io/Football-Analytics-with-SQL--Man-Utd-Case-Study/

![Football Match Intelligence System](landing.png)

---

## Business Problem

Football clubs invest heavily in data collection, yet the value of that data depends entirely on the questions asked and the clarity of the answers produced. Manchester United's 2023/24 season raised several performance questions that analysts, coaching staff, and supporters alike wanted to understand:

- Did player performance vary by formation?
- Were results justified by underlying performance metrics such as expected goals?
- How many points were lost after taking the lead?
- Did substitutions improve team performance?
- Which players consistently performed above expectation?
- What was the true cost of suspensions to the squad?
- Which tactical matchups created the biggest advantage?
- How did the team's league position evolve across the season?

Without structured analysis, these questions remain unanswered and debate defaults to opinion rather than evidence.

---

## Methodology

The following approach was applied using PostgreSQL:

1. Data Modeling
   - Designed eight relational tables covering teams, matches, players, formations, events, and statistics.
   - Populated the database with over 500 rows of realistic Premier League data.

2. Analytical Query Development
   - Wrote ten advanced SQL queries, each anchored to a specific football question.
   - Applied window functions, recursive CTEs, complex multi-table joins, ranking functions, aggregate analytics, and CASE expressions.

3. Reporting Layer
   - Created three materialized views to support dashboard-ready reporting and repeatable analysis.
   - Optimized queries for performance and clarity.

4. Insight Generation
   - Interpreted results to produce tactical and performance conclusions relevant to coaching, scouting, and club strategy.

SQL techniques demonstrated: window functions, recursive CTEs, materialized views, complex multi-table joins, ranking functions, generated columns, aggregate analytics, CASE expressions, query optimization, and dashboard-ready views.

---

## Key Findings

The analysis produced answers to the eight core football questions:

| Question | Finding |
|:---------|:--------|
| Formation impact on Bruno Fernandes | Performance varied measurably between 4-2-3-1 and 4-3-3 |
| Were victories deserved per xG | Some wins were justified by underlying metrics; others were not |
| Points lost after taking the lead | Identified the exact points dropped from winning positions |
| Substitution effectiveness | Measured whether changes improved or weakened performance |
| Players finishing above expectation | Ranked players by overperformance against xG |
| Cost of Casemiro's suspensions | Quantified the impact of his absences on results |
| Tactical matchup advantages | Identified which opponents United matched up best against |
| League position evolution | Tracked the team's standing across the full season |

---

## Skills

- SQL: Window functions, recursive CTEs, materialized views, multi-table joins, ranking functions, aggregate analytics, query optimization
- Data Modeling: Relational schema design, generated columns, table relationships
- Analytics: Performance evaluation, tactical analysis, expected goals analysis, trend tracking
- Business Interpretation: Translating match data into decisions relevant to coaching, scouting, and club strategy

---

## Recommendations

1. Formation Selection: Use the formation-performance analysis to guide starting setup based on opponent and player availability.

2. Substitution Strategy: Review substitution timing and personnel against the measured performance impact.

3. Lead Retention: Address the points lost from winning positions through late-game management and defensive structure.

4. Player Evaluation: Use overperformance against xG to inform selection, contract, and transfer decisions.

5. Squad Depth: Quantify the cost of suspensions and injuries to justify investment in squad depth.

6. Tactical Preparation: Use matchup analysis to tailor game plans against specific opponents.

7. Continuous Monitoring: Expand the materialized views into a live dashboard for ongoing performance tracking.

---

## Next Steps

- Extend the dataset to multiple seasons for trend and comparison analysis.
- Add player-level defensive and pressing metrics to broaden the performance picture.
- Integrate predictive models for match outcome and player performance forecasting.
- Build an automated dashboard for real-time reporting.
- Add data validation and refresh pipelines for ongoing data quality.

---

## About the Creator

Samuel Mati
Data Analyst | SQL Developer | Insight Translator

Email: sammxsaf@gmail.com
LinkedIn: https://www.linkedin.com/in/samuel-mati/

"Turning raw match data into football intelligence."
