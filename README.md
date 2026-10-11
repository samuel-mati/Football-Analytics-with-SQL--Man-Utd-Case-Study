# How SQL Analysis Explained Manchester United's 2023/24 Season
### A PostgreSQL Performance and Tactical Analysis

**Prepared by:** Samuel Mati

**Role:** Data Analyst | SQL Developer

**Date:** 6th December 2025

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

### 1. Bruno Fernandes is more effective in a 4-2-3-1 than in a 4-3-3

Bruno Fernandes produced more goal contributions per game, more key passes per match, a higher pass accuracy percentage, and a higher average rating when deployed as a Number 10 in a 4-2-3-1 than when played as a box-to-box midfielder in a 4-3-3. Pushing him deeper reduces his attacking output and removes him from the areas where he is most dangerous.

### 2. United's points-per-game at home was not meaningfully better than away

The home and away split showed that United's points per game, goals scored, and goal difference at Old Trafford were close to their away figures. The traditional home advantage did not hold. United conceded chances at home at a rate similar to their away matches, which indicates the problem was structural rather than environmental.

### 3. United won matches they did not deserve to win, and lost matches they did not deserve to lose

The expected goals analysis showed several matches where United's actual goals exceeded their xG by a wide margin, meaning the wins were built on clinical finishing or goalkeeping rather than control of the game. In other matches, United created the better chances but lost or drew. The xg_expected_result column confirms that the final league position flattered the team's underlying performance.

### 4. United dropped a significant number of points from winning positions

Multiple matches were classified as "Points dropped (draw)" or "Points dropped (loss)" after United had taken the lead. These are not random results. They point to a recurring failure to manage games after going ahead, whether through tactical naivety, poor substitutions, or loss of concentration.

### 5. Some United forwards are clinical, others are wasteful

The goals-versus-xG comparison separated the squad into two clear groups. Players with a strongly positive xg_difference scored more than the quality of their chances suggested, marking them as clinical finishers. Players with a strongly negative xg_difference missed chances they should have converted. The finisher_profile column labels each player accordingly, giving a direct measure of finishing quality.

### 6. United conceded more goals than they scored after the 60th minute

The substitution impact analysis showed that United's net goal difference after the 60th minute was negative. They conceded late goals more often than they scored them, which suggests problems with fitness, concentration, or the timing and personnel of substitutions.

### 7. Certain formations produced better results against specific opponent shapes

The head-to-head formation analysis showed that United's points per game varied significantly depending on which formation they used against a given opponent formation. Some matchups produced strong returns, while others consistently produced poor results. This is a tactical pattern, not a coincidence.

### 8. Several United players were at high risk of suspension

The discipline report flagged players whose yellow card accumulation put them at high risk of a one-match ban. The red card impact analysis also showed how United performed in matches where they played with ten men, quantifying the cost of ill-discipline to the team's results.

### 9. United's league position fluctuated significantly across the season

The recursive standings query showed how United's position changed matchweek by matchweek. The position_change column revealed the exact weeks where the team climbed and the exact weeks where they fell, giving a clear picture of the season's turning points.

---

## Skills

- SQL: Window functions, recursive CTEs, materialized views, multi-table joins, ranking functions, aggregate analytics, query optimization
- Data Modeling: Relational schema design, generated columns, table relationships
- Analytics: Performance evaluation, tactical analysis, expected goals analysis, trend tracking
- Business Interpretation: Translating match data into decisions relevant to coaching, scouting, and club strategy

---

## Recommendations

1. Formation Selection: Play Bruno Fernandes as a Number 10 in a 4-2-3-1. The data shows his goal contributions, key passes, pass accuracy, and rating all improve in this role compared to the 4-3-3.

2. Home Performance: Treat the home form as a structural problem, not a psychological one. Review the defensive setup and chance concession rate at Old Trafford.

3. Results versus Performance: Use the xG analysis to recalibrate expectations. The league position overstated the team's control of matches, and recruitment should target players who improve underlying performance, not just results.

4. Lead Retention: Address the matches where United dropped points from winning positions. This is a game management problem that requires tactical discipline and late-game structure.

5. Player Evaluation: Use the xg_difference metric to decide which forwards to keep and which to replace. Players with a strongly negative xg_difference are costing the team goals.

6. Late-Game Management: Review substitution timing and personnel against the after-60 goal data. If United concede more than they score after the 60th minute, change when and how substitutions are made.

7. Tactical Preparation: Use the head-to-head formation data to select the right setup against specific opponents rather than defaulting to one system.

8. Squad Depth: Quantify the cost of suspensions using the red card impact analysis. Justify investment in squad depth where the data shows results collapse without certain players.

9. Continuous Monitoring: Expand the materialized views into a live dashboard for ongoing performance tracking.

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
