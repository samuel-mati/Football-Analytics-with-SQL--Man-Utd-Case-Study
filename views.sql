-- ============================================================
--  FOOTBALL MATCH INTELLIGENCE SYSTEM
--  Materialized Views — Ready for Dashboard / BI tools
--  PostgreSQL
-- ============================================================


-- ============================================================
--  VIEW 1: utd_season_summary
--  A single-row dashboard summary of United's 2023/24 season
-- ============================================================

CREATE MATERIALIZED VIEW utd_season_summary AS
WITH all_matches AS (
    SELECT
        m.match_id,
        m.match_date,
        CASE WHEN m.home_team_id = 1 THEN m.home_goals ELSE m.away_goals END AS utd_goals,
        CASE WHEN m.home_team_id = 1 THEN m.away_goals ELSE m.home_goals END AS opp_goals,
        CASE WHEN m.home_team_id = 1 THEN m.home_xg   ELSE m.away_xg   END  AS utd_xg,
        CASE WHEN m.home_team_id = 1 THEN 'H' ELSE 'A' END                  AS venue
    FROM matches m
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
)
SELECT
    COUNT(*)                                                          AS matches_played,
    SUM(CASE WHEN utd_goals > opp_goals THEN 1 ELSE 0 END)          AS wins,
    SUM(CASE WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)          AS draws,
    SUM(CASE WHEN utd_goals < opp_goals THEN 1 ELSE 0 END)          AS losses,
    SUM(utd_goals)                                                    AS goals_scored,
    SUM(opp_goals)                                                    AS goals_conceded,
    SUM(utd_goals) - SUM(opp_goals)                                 AS goal_difference,
    SUM(CASE WHEN utd_goals > opp_goals THEN 3
             WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)           AS total_points,
    ROUND(AVG(utd_xg), 2)                                            AS avg_xg_per_game,
    ROUND(SUM(utd_goals)::NUMERIC / COUNT(*), 2)                    AS goals_per_game,
    ROUND(SUM(opp_goals)::NUMERIC / COUNT(*), 2)                    AS conceded_per_game
FROM all_matches;


-- ============================================================
--  VIEW 2: player_season_ratings
--  Aggregated season stats per player — ideal for a 
--  player comparison dashboard or scouting report
-- ============================================================

CREATE MATERIALIZED VIEW player_season_ratings AS
SELECT
    p.player_id,
    p.known_as                                                               AS player,
    p.position,
    p.nationality,
    t.name                                                                   AS team,
    COUNT(DISTINCT pms.match_id)                                             AS appearances,
    SUM(pms.goals)                                                           AS goals,
    SUM(pms.assists)                                                         AS assists,
    SUM(pms.goals + pms.assists)                                             AS goal_contributions,
    ROUND(SUM(pms.xg), 2)                                                   AS total_xg,
    ROUND(SUM(pms.goals) - SUM(pms.xg), 2)                                 AS xg_overperformance,
    SUM(pms.key_passes)                                                      AS key_passes,
    SUM(pms.passes_attempted)                                                AS passes_attempted,
    SUM(pms.passes_completed)                                                AS passes_completed,
    ROUND(SUM(pms.passes_completed)::NUMERIC
          / NULLIF(SUM(pms.passes_attempted), 0) * 100, 1)                  AS pass_accuracy_pct,
    SUM(pms.tackles)                                                         AS tackles,
    SUM(pms.interceptions)                                                   AS interceptions,
    SUM(pms.yellow_cards)                                                    AS yellow_cards,
    SUM(pms.red_cards)                                                       AS red_cards,
    ROUND(AVG(pms.distance_km), 2)                                          AS avg_km_per_game,
    ROUND(AVG(pms.rating), 2)                                               AS avg_rating,
    ROUND(SUM(pms.goals + pms.assists)::NUMERIC
          / NULLIF(COUNT(DISTINCT pms.match_id), 0), 2)                     AS contributions_per_game
FROM player_match_stats pms
JOIN players p ON p.player_id = pms.player_id
JOIN teams   t ON t.team_id   = pms.team_id
GROUP BY p.player_id, p.known_as, p.position, p.nationality, t.name
ORDER BY avg_rating DESC NULLS LAST;


-- ============================================================
--  VIEW 3: match_tactical_overview
--  Per-match tactical context: formations, xG, results
--  Useful for a match-by-match analyst dashboard
-- ============================================================

CREATE MATERIALIZED VIEW match_tactical_overview AS
SELECT
    m.match_id,
    m.match_date,
    m.stage,
    th.name                                                              AS home_team,
    ta.name                                                              AS away_team,
    m.home_goals,
    m.away_goals,
    m.home_xg,
    m.away_xg,
    ROUND(m.home_xg - m.away_xg, 2)                                    AS xg_dominance,
    home_f.formation_name                                                AS home_formation,
    away_f.formation_name                                                AS away_formation,
    CASE
        WHEN m.home_goals > m.away_goals THEN th.name
        WHEN m.home_goals < m.away_goals THEN ta.name
        ELSE 'Draw'
    END                                                                  AS winner,
    CASE
        WHEN m.home_xg > m.away_xg THEN th.name
        WHEN m.home_xg < m.away_xg THEN ta.name
        ELSE 'Draw'
    END                                                                  AS xg_winner,
    -- Did the xG winner actually win?
    CASE
        WHEN (m.home_xg > m.away_xg AND m.home_goals > m.away_goals)
          OR (m.home_xg < m.away_xg AND m.home_goals < m.away_goals)
        THEN TRUE ELSE FALSE
    END                                                                  AS result_matched_xg,
    m.attendance,
    m.referee
FROM matches m
JOIN teams th ON th.team_id = m.home_team_id
JOIN teams ta ON ta.team_id = m.away_team_id
LEFT JOIN tactical_formations home_f
    ON home_f.match_id = m.match_id AND home_f.team_id = m.home_team_id AND home_f.is_starting = TRUE
LEFT JOIN tactical_formations away_f
    ON away_f.match_id = m.match_id AND away_f.team_id = m.away_team_id AND away_f.is_starting = TRUE
ORDER BY m.match_date;


-- Refresh commands (run after new data is inserted):
-- REFRESH MATERIALIZED VIEW utd_season_summary;
-- REFRESH MATERIALIZED VIEW player_season_ratings;
-- REFRESH MATERIALIZED VIEW match_tactical_overview;
