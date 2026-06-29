-- ============================================================
--  FOOTBALL MATCH INTELLIGENCE SYSTEM
--  Advanced Analytics Queries — Premier League 2023/24
--  Manchester United Focus | PostgreSQL
-- ============================================================


-- ============================================================
--  QUERY 1: Rolling 5-Match Form Table
--  Business question: How has Man United's form evolved 
--  across the season? (Win/Draw/Loss over last 5 games)
-- ============================================================

WITH match_results AS (
    SELECT
        m.match_id,
        m.match_date,
        m.stage,
        CASE
            WHEN m.home_team_id = 1 THEN m.home_goals
            ELSE m.away_goals
        END AS utd_goals,
        CASE
            WHEN m.home_team_id = 1 THEN m.away_goals
            ELSE m.home_goals
        END AS opp_goals,
        CASE
            WHEN m.home_team_id = 1 THEN t.name
            ELSE th.name
        END AS opponent,
        CASE WHEN m.home_team_id = 1 THEN 'H' ELSE 'A' END AS venue
    FROM matches m
    JOIN teams t  ON t.team_id = m.away_team_id
    JOIN teams th ON th.team_id = m.home_team_id
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
),
results_with_outcome AS (
    SELECT *,
        CASE
            WHEN utd_goals > opp_goals THEN 'W'
            WHEN utd_goals = opp_goals THEN 'D'
            ELSE 'L'
        END AS result,
        CASE
            WHEN utd_goals > opp_goals THEN 3
            WHEN utd_goals = opp_goals THEN 1
            ELSE 0
        END AS points
    FROM match_results
),
rolling_form AS (
    SELECT *,
        STRING_AGG(result, '' ORDER BY match_date)
            OVER (ORDER BY match_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS last_5_form,
        SUM(points)
            OVER (ORDER BY match_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS pts_last_5,
        SUM(utd_goals)
            OVER (ORDER BY match_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS gf_last_5,
        SUM(opp_goals)
            OVER (ORDER BY match_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW) AS ga_last_5
    FROM results_with_outcome
)
SELECT
    match_date,
    stage,
    venue,
    opponent,
    utd_goals || '-' || opp_goals AS score,
    result,
    last_5_form,
    pts_last_5,
    gf_last_5 || ':' || ga_last_5 AS gd_last_5
FROM rolling_form
ORDER BY match_date;


-- ============================================================
--  QUERY 2: Bruno Fernandes — Creative Output by Formation
--  Business question: Is Bruno more effective in a 4-2-3-1 
--  (as #10) than in a 4-3-3 (as box-to-box)?
-- ============================================================

WITH bruno_by_formation AS (
    SELECT
        tf.formation_name,
        COUNT(DISTINCT pms.match_id)                          AS matches_played,
        SUM(pms.goals)                                         AS goals,
        SUM(pms.assists)                                       AS assists,
        SUM(pms.goals + pms.assists)                           AS goal_contributions,
        ROUND(AVG(pms.key_passes), 1)                          AS avg_key_passes,
        ROUND(AVG(pms.passes_completed::NUMERIC 
              / NULLIF(pms.passes_attempted, 0) * 100), 1)     AS pass_accuracy_pct,
        ROUND(AVG(pms.xg), 2)                                  AS avg_xg,
        ROUND(AVG(pms.rating), 2)                              AS avg_rating,
        ROUND(AVG(pms.distance_km), 2)                         AS avg_km_covered
    FROM player_match_stats pms
    JOIN tactical_formations tf
        ON tf.match_id = pms.match_id
        AND tf.team_id = pms.team_id
        AND tf.is_starting = TRUE
    WHERE pms.player_id = 8  -- Bruno Fernandes
    GROUP BY tf.formation_name
)
SELECT
    formation_name,
    matches_played,
    goals,
    assists,
    goal_contributions,
    ROUND(goal_contributions::NUMERIC / matches_played, 2)  AS contributions_per_game,
    avg_key_passes,
    pass_accuracy_pct,
    avg_xg,
    avg_rating,
    avg_km_covered
FROM bruno_by_formation
ORDER BY contributions_per_game DESC;


-- ============================================================
--  QUERY 3: Home vs Away Performance Split
--  Business question: Is Old Trafford still a fortress,
--  or are United just as leaky at home?
-- ============================================================

WITH utd_matches AS (
    SELECT
        m.match_id,
        m.match_date,
        CASE WHEN m.home_team_id = 1 THEN 'Home' ELSE 'Away' END AS venue_type,
        CASE WHEN m.home_team_id = 1 THEN m.home_goals ELSE m.away_goals END AS utd_goals,
        CASE WHEN m.home_team_id = 1 THEN m.away_goals ELSE m.home_goals END AS opp_goals,
        CASE WHEN m.home_team_id = 1 THEN m.home_xg   ELSE m.away_xg   END AS utd_xg,
        CASE WHEN m.home_team_id = 1 THEN m.away_xg   ELSE m.home_xg   END AS opp_xg
    FROM matches m
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
)
SELECT
    venue_type,
    COUNT(*)                                                   AS matches,
    SUM(CASE WHEN utd_goals > opp_goals THEN 1 ELSE 0 END)    AS wins,
    SUM(CASE WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)    AS draws,
    SUM(CASE WHEN utd_goals < opp_goals THEN 1 ELSE 0 END)    AS losses,
    SUM(utd_goals)                                             AS goals_scored,
    SUM(opp_goals)                                             AS goals_conceded,
    SUM(utd_goals) - SUM(opp_goals)                           AS goal_difference,
    ROUND(AVG(utd_xg), 2)                                     AS avg_xg_for,
    ROUND(AVG(opp_xg), 2)                                     AS avg_xg_against,
    ROUND(
        SUM(CASE WHEN utd_goals > opp_goals THEN 3
                 WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)::NUMERIC
        / COUNT(*), 2
    )                                                          AS points_per_game
FROM utd_matches
GROUP BY venue_type
ORDER BY venue_type DESC;


-- ============================================================
--  QUERY 4: xG Overperformance / Underperformance
--  Business question: Where is United's attack punching above 
--  or below its weight? Which matches did luck decide?
-- ============================================================

WITH xg_analysis AS (
    SELECT
        m.match_id,
        m.match_date,
        m.stage,
        CASE WHEN m.home_team_id = 1 THEN t.name ELSE th.name END AS opponent,
        CASE WHEN m.home_team_id = 1 THEN 'H' ELSE 'A' END        AS venue,
        CASE WHEN m.home_team_id = 1 THEN m.home_goals ELSE m.away_goals END AS actual_goals,
        CASE WHEN m.home_team_id = 1 THEN m.home_xg   ELSE m.away_xg   END  AS xg,
        CASE WHEN m.home_team_id = 1 THEN m.away_goals ELSE m.home_goals END AS opp_goals,
        CASE WHEN m.home_team_id = 1 THEN m.away_xg   ELSE m.home_xg   END  AS opp_xg
    FROM matches m
    JOIN teams t  ON t.team_id = m.away_team_id
    JOIN teams th ON th.team_id = m.home_team_id
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
)
SELECT
    match_date,
    stage,
    venue,
    opponent,
    actual_goals || '-' || opp_goals                           AS score,
    xg                                                         AS utd_xg,
    opp_xg,
    ROUND(actual_goals - xg, 2)                               AS xg_overperformance,
    CASE
        WHEN actual_goals - xg  >  0.5 THEN 'Outperformed xG'
        WHEN actual_goals - xg  < -0.5 THEN 'Underperformed xG'
        ELSE 'In line with xG'
    END AS xg_verdict,
    -- Would the result have been different if both teams scored exactly their xG?
    CASE
        WHEN ROUND(xg) > ROUND(opp_xg) THEN 'xG Win'
        WHEN ROUND(xg) = ROUND(opp_xg) THEN 'xG Draw'
        ELSE 'xG Loss'
    END AS xg_expected_result
FROM xg_analysis
ORDER BY match_date;


-- ============================================================
--  QUERY 5: United's "Points Dropped From Winning Positions"
--  Business question: How often did United lead and fail to 
--  hold on? (Classic 2023/24 United problem)
-- ============================================================

WITH match_events_ordered AS (
    SELECT
        me.match_id,
        me.team_id,
        me.minute,
        SUM(CASE WHEN me.event_type IN ('goal','penalty_scored') AND me.team_id = 1
                 THEN 1 ELSE 0 END)
            OVER (PARTITION BY me.match_id ORDER BY me.minute) AS utd_running_total,
        SUM(CASE WHEN me.event_type IN ('goal','penalty_scored','own_goal') AND me.team_id != 1
                 THEN 1 ELSE 0 END)
            OVER (PARTITION BY me.match_id ORDER BY me.minute) AS opp_running_total
    FROM match_events me
    JOIN matches m ON m.match_id = me.match_id
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
      AND me.event_type IN ('goal', 'penalty_scored', 'own_goal')
),
was_leading AS (
    SELECT DISTINCT match_id,
        MAX(CASE WHEN utd_running_total > opp_running_total THEN 1 ELSE 0 END)
            OVER (PARTITION BY match_id) AS had_lead
    FROM match_events_ordered
),
final_results AS (
    SELECT
        m.match_id,
        m.match_date,
        m.stage,
        CASE WHEN m.home_team_id = 1 THEN t.name ELSE th.name END AS opponent,
        CASE WHEN m.home_team_id = 1 THEN m.home_goals ELSE m.away_goals END AS utd_goals,
        CASE WHEN m.home_team_id = 1 THEN m.away_goals ELSE m.home_goals END AS opp_goals
    FROM matches m
    JOIN teams t  ON t.team_id = m.away_team_id
    JOIN teams th ON th.team_id = m.home_team_id
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
)
SELECT
    fr.match_date,
    fr.stage,
    fr.opponent,
    fr.utd_goals || '-' || fr.opp_goals AS final_score,
    COALESCE(wl.had_lead, 0)            AS had_lead_at_some_point,
    CASE
        WHEN COALESCE(wl.had_lead, 0) = 1 AND fr.utd_goals < fr.opp_goals  THEN 'Points dropped (loss)'
        WHEN COALESCE(wl.had_lead, 0) = 1 AND fr.utd_goals = fr.opp_goals  THEN 'Points dropped (draw)'
        WHEN COALESCE(wl.had_lead, 0) = 1 AND fr.utd_goals > fr.opp_goals  THEN 'Lead held'
        ELSE 'Never led'
    END AS outcome_from_lead
FROM final_results fr
LEFT JOIN was_leading wl ON wl.match_id = fr.match_id
ORDER BY fr.match_date;


-- ============================================================
--  QUERY 6: Top Scorers with xG Gap Analysis
--  Business question: Who is a clinical finisher vs who is 
--  riding their luck? (Goals vs Expected Goals)
-- ============================================================

WITH scorer_xg AS (
    SELECT
        p.known_as                      AS player,
        t.short_name                    AS team,
        p.position,
        COUNT(DISTINCT pms.match_id)    AS matches,
        SUM(pms.goals)                  AS actual_goals,
        ROUND(SUM(pms.xg), 2)          AS total_xg,
        ROUND(SUM(pms.goals) - SUM(pms.xg), 2) AS xg_difference,
        SUM(pms.shots_total)            AS total_shots,
        SUM(pms.shots_on_target)        AS shots_on_target,
        ROUND(
            SUM(pms.shots_on_target)::NUMERIC / NULLIF(SUM(pms.shots_total), 0) * 100, 1
        )                               AS shot_accuracy_pct,
        ROUND(AVG(pms.rating), 2)       AS avg_rating
    FROM player_match_stats pms
    JOIN players p ON p.player_id = pms.player_id
    JOIN teams   t ON t.team_id   = pms.team_id
    GROUP BY p.player_id, p.known_as, t.short_name, p.position
    HAVING SUM(pms.goals) > 0
)
SELECT
    player,
    team,
    position,
    matches,
    actual_goals,
    total_xg,
    xg_difference,
    CASE
        WHEN xg_difference >  1.5 THEN 'Clinical finisher'
        WHEN xg_difference < -1.5 THEN 'Wasteful'
        ELSE 'Expected output'
    END AS finisher_profile,
    ROUND(actual_goals::NUMERIC / matches, 2) AS goals_per_game,
    shot_accuracy_pct,
    avg_rating
FROM scorer_xg
ORDER BY actual_goals DESC, xg_difference DESC;


-- ============================================================
--  QUERY 7: Substitution Impact Analysis
--  Business question: Do United's substitutes change games?
--  Compare goal events before and after the 60th minute.
-- ============================================================

WITH match_goal_phases AS (
    SELECT
        me.match_id,
        SUM(CASE WHEN me.minute <= 60 AND me.team_id = 1
                 AND me.event_type IN ('goal','penalty_scored')
                 THEN 1 ELSE 0 END) AS utd_goals_before_60,
        SUM(CASE WHEN me.minute  > 60 AND me.team_id = 1
                 AND me.event_type IN ('goal','penalty_scored')
                 THEN 1 ELSE 0 END) AS utd_goals_after_60,
        SUM(CASE WHEN me.minute <= 60 AND me.team_id != 1
                 AND me.event_type IN ('goal','penalty_scored','own_goal')
                 THEN 1 ELSE 0 END) AS opp_goals_before_60,
        SUM(CASE WHEN me.minute  > 60 AND me.team_id != 1
                 AND me.event_type IN ('goal','penalty_scored','own_goal')
                 THEN 1 ELSE 0 END) AS opp_goals_after_60
    FROM match_events me
    JOIN matches m ON m.match_id = me.match_id
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
    GROUP BY me.match_id
)
SELECT
    COUNT(*)                          AS total_matches,
    -- Goals scored
    SUM(utd_goals_before_60)          AS goals_scored_before_60,
    SUM(utd_goals_after_60)           AS goals_scored_after_60,
    ROUND(SUM(utd_goals_after_60)::NUMERIC / NULLIF(COUNT(*), 0), 2) AS late_goals_per_game,
    -- Goals conceded
    SUM(opp_goals_before_60)          AS goals_conceded_before_60,
    SUM(opp_goals_after_60)           AS goals_conceded_after_60,
    -- Net impact after 60
    SUM(utd_goals_after_60) - SUM(opp_goals_after_60) AS net_goals_after_60
FROM match_goal_phases;


-- ============================================================
--  QUERY 8: Head-to-Head Tactical Matchup History
--  Business question: How does United's formation hold up 
--  against different opponent formations?
-- ============================================================

WITH h2h_formations AS (
    SELECT
        m.match_id,
        m.match_date,
        CASE WHEN m.home_team_id = 1 THEN t.name ELSE th.name END AS opponent,
        utd_tf.formation_name    AS utd_formation,
        opp_tf.formation_name    AS opp_formation,
        CASE WHEN m.home_team_id = 1 THEN m.home_goals ELSE m.away_goals END AS utd_goals,
        CASE WHEN m.home_team_id = 1 THEN m.away_goals ELSE m.home_goals END AS opp_goals
    FROM matches m
    JOIN teams t  ON t.team_id = m.away_team_id
    JOIN teams th ON th.team_id = m.home_team_id
    JOIN tactical_formations utd_tf
        ON utd_tf.match_id = m.match_id AND utd_tf.team_id = 1 AND utd_tf.is_starting = TRUE
    JOIN tactical_formations opp_tf
        ON opp_tf.match_id = m.match_id AND opp_tf.team_id != 1 AND opp_tf.is_starting = TRUE
    WHERE m.home_team_id = 1 OR m.away_team_id = 1
)
SELECT
    utd_formation,
    opp_formation,
    COUNT(*)                                                               AS matches,
    SUM(CASE WHEN utd_goals > opp_goals THEN 1 ELSE 0 END)               AS wins,
    SUM(CASE WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)               AS draws,
    SUM(CASE WHEN utd_goals < opp_goals THEN 1 ELSE 0 END)               AS losses,
    SUM(utd_goals)                                                         AS goals_for,
    SUM(opp_goals)                                                         AS goals_against,
    ROUND(
        SUM(CASE WHEN utd_goals > opp_goals THEN 3
                 WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)::NUMERIC
        / COUNT(*), 2
    )                                                                      AS ppg
FROM h2h_formations
GROUP BY utd_formation, opp_formation
ORDER BY utd_formation, ppg DESC;


-- ============================================================
--  QUERY 9: Player Discipline Report — Red Card Risk
--  Business question: Which players are a suspension risk?
--  (Bookings accumulation & red card impact on results)
-- ============================================================

WITH discipline AS (
    SELECT
        p.known_as                                              AS player,
        p.position,
        COUNT(DISTINCT pms.match_id)                            AS matches_played,
        SUM(pms.yellow_cards)                                   AS yellows,
        SUM(pms.red_cards)                                      AS reds,
        SUM(pms.fouls_committed)                                AS fouls,
        ROUND(SUM(pms.fouls_committed)::NUMERIC
              / COUNT(DISTINCT pms.match_id), 2)                AS fouls_per_game,
        ROUND(SUM(pms.yellow_cards)::NUMERIC
              / COUNT(DISTINCT pms.match_id) * 10, 2)          AS yellow_rate_per_10
    FROM player_match_stats pms
    JOIN players p ON p.player_id = pms.player_id
    WHERE pms.team_id = 1
    GROUP BY p.player_id, p.known_as, p.position
),
red_card_match_results AS (
    SELECT
        me.match_id,
        CASE WHEN m.home_team_id = 1 THEN m.home_goals ELSE m.away_goals END AS utd_goals,
        CASE WHEN m.home_team_id = 1 THEN m.away_goals ELSE m.home_goals END AS opp_goals
    FROM match_events me
    JOIN matches m ON m.match_id = me.match_id
    WHERE me.event_type = 'red_card'
      AND me.team_id = 1
      AND (m.home_team_id = 1 OR m.away_team_id = 1)
),
red_card_impact AS (
    SELECT
        COUNT(*)                                                   AS red_card_matches,
        SUM(CASE WHEN utd_goals > opp_goals THEN 1 ELSE 0 END)   AS wins_with_red,
        SUM(CASE WHEN utd_goals = opp_goals THEN 1 ELSE 0 END)   AS draws_with_red,
        SUM(CASE WHEN utd_goals < opp_goals THEN 1 ELSE 0 END)   AS losses_with_red
    FROM red_card_match_results
)
SELECT
    d.*,
    CASE
        WHEN d.yellows >= 4 THEN 'HIGH suspension risk'
        WHEN d.yellows >= 2 THEN 'MEDIUM suspension risk'
        ELSE 'Low risk'
    END AS suspension_risk
FROM discipline d
ORDER BY d.yellows DESC, d.fouls DESC;


-- ============================================================
--  QUERY 10: Recursive Season Standings Builder
--  Business question: Build the cumulative league table 
--  matchweek-by-matchweek using a recursive CTE.
-- ============================================================

WITH RECURSIVE matchweeks AS (
    -- Base case: start from matchweek 1
    SELECT 1 AS mw
    UNION ALL
    SELECT mw + 1 FROM matchweeks WHERE mw < 38
),
cumulative_standings AS (
    SELECT
        s.team_id,
        t.name    AS team_name,
        s.matchweek,
        s.played,
        s.won,
        s.drawn,
        s.lost,
        s.goals_for,
        s.goals_against,
        s.goal_diff,
        s.points,
        -- Rank within each matchweek
        RANK() OVER (
            PARTITION BY s.matchweek
            ORDER BY s.points DESC, s.goal_diff DESC, s.goals_for DESC
        ) AS position
    FROM standings s
    JOIN teams t ON t.team_id = s.team_id
)
SELECT
    matchweek,
    position,
    team_name,
    played,
    won,
    drawn,
    lost,
    goals_for,
    goals_against,
    goal_diff,
    points,
    -- Show movement vs previous tracked matchweek
    LAG(position) OVER (PARTITION BY team_id ORDER BY matchweek) AS prev_position,
    position - LAG(position) OVER (PARTITION BY team_id ORDER BY matchweek) AS position_change
FROM cumulative_standings
ORDER BY matchweek, position;
