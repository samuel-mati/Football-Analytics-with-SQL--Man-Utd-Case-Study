-- ============================================================
--  FOOTBALL MATCH INTELLIGENCE SYSTEM
--  Premier League 2023/24 | Focus: Manchester United
--  Dialect: PostgreSQL
--  Author: Sports Analytics Portfolio Project
-- ============================================================

-- ============================================================
--  ENUMS
-- ============================================================

CREATE TYPE competition_stage AS ENUM (
    'Matchweek 1','Matchweek 2','Matchweek 3','Matchweek 4','Matchweek 5',
    'Matchweek 6','Matchweek 7','Matchweek 8','Matchweek 9','Matchweek 10',
    'Matchweek 11','Matchweek 12','Matchweek 13','Matchweek 14','Matchweek 15',
    'Matchweek 16','Matchweek 17','Matchweek 18','Matchweek 19','Matchweek 20',
    'Matchweek 21','Matchweek 22','Matchweek 23','Matchweek 24','Matchweek 25',
    'Matchweek 26','Matchweek 27','Matchweek 28','Matchweek 29','Matchweek 30',
    'Matchweek 31','Matchweek 32','Matchweek 33','Matchweek 34','Matchweek 35',
    'Matchweek 36','Matchweek 37','Matchweek 38'
);

CREATE TYPE event_type AS ENUM (
    'goal', 'own_goal', 'penalty_scored', 'penalty_missed',
    'yellow_card', 'red_card', 'second_yellow',
    'substitution_on', 'substitution_off',
    'assist', 'key_pass'
);

CREATE TYPE player_position AS ENUM (
    'GK', 'CB', 'RB', 'LB', 'CDM', 'CM', 'CAM', 'RM', 'LM', 'RW', 'LW', 'ST', 'CF'
);

CREATE TYPE pitch_zone AS ENUM (
    'own_box', 'own_half_left', 'own_half_center', 'own_half_right',
    'mid_left', 'mid_center', 'mid_right',
    'opp_half_left', 'opp_half_center', 'opp_half_right', 'opp_box'
);

-- ============================================================
--  TABLE: teams
-- ============================================================

CREATE TABLE teams (
    team_id         SERIAL PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    short_name      VARCHAR(10)  NOT NULL,
    city            VARCHAR(100),
    stadium         VARCHAR(100),
    stadium_capacity INT,
    manager         VARCHAR(100),
    founded_year    INT,
    primary_color   VARCHAR(7),   -- hex
    secondary_color VARCHAR(7)
);

-- ============================================================
--  TABLE: players
-- ============================================================

CREATE TABLE players (
    player_id       SERIAL PRIMARY KEY,
    team_id         INT REFERENCES teams(team_id),
    full_name       VARCHAR(150) NOT NULL,
    known_as        VARCHAR(100),
    nationality     VARCHAR(100),
    position        player_position,
    date_of_birth   DATE,
    squad_number    INT,
    market_value_m  NUMERIC(6,2),  -- in millions GBP
    is_active       BOOLEAN DEFAULT TRUE
);

-- ============================================================
--  TABLE: matches
-- ============================================================

CREATE TABLE matches (
    match_id        SERIAL PRIMARY KEY,
    home_team_id    INT REFERENCES teams(team_id),
    away_team_id    INT REFERENCES teams(team_id),
    match_date      DATE NOT NULL,
    kickoff_time    TIME,
    stage           competition_stage,
    stadium         VARCHAR(100),
    referee         VARCHAR(100),
    home_goals      INT DEFAULT 0,
    away_goals      INT DEFAULT 0,
    home_xg         NUMERIC(4,2),  -- expected goals
    away_xg         NUMERIC(4,2),
    attendance      INT,
    match_notes     TEXT,
    CONSTRAINT different_teams CHECK (home_team_id <> away_team_id)
);

-- ============================================================
--  TABLE: tactical_formations
-- ============================================================

CREATE TABLE tactical_formations (
    formation_id    SERIAL PRIMARY KEY,
    match_id        INT REFERENCES matches(match_id),
    team_id         INT REFERENCES teams(team_id),
    formation_name  VARCHAR(20) NOT NULL,  -- e.g. '4-2-3-1', '4-3-3'
    is_starting     BOOLEAN DEFAULT TRUE,  -- FALSE = adjusted formation mid-match
    applied_minute  INT DEFAULT 0
);

-- ============================================================
--  TABLE: match_lineups
-- ============================================================

CREATE TABLE match_lineups (
    lineup_id       SERIAL PRIMARY KEY,
    match_id        INT REFERENCES matches(match_id),
    team_id         INT REFERENCES teams(team_id),
    player_id       INT REFERENCES players(player_id),
    is_starter      BOOLEAN DEFAULT TRUE,
    position_played player_position,
    minutes_played  INT DEFAULT 0,
    subbed_on_min   INT,   -- NULL if starter who wasn't subbed on
    subbed_off_min  INT    -- NULL if played full match or wasn't used
);

-- ============================================================
--  TABLE: match_events
-- ============================================================

CREATE TABLE match_events (
    event_id        SERIAL PRIMARY KEY,
    match_id        INT REFERENCES matches(match_id),
    team_id         INT REFERENCES teams(team_id),
    player_id       INT REFERENCES players(player_id),
    related_player_id INT REFERENCES players(player_id), -- assister, fouled player, etc.
    event_type      event_type NOT NULL,
    minute          INT NOT NULL,
    added_time      INT DEFAULT 0,
    pitch_zone      pitch_zone,
    description     TEXT
);

-- ============================================================
--  TABLE: player_match_stats
-- ============================================================

CREATE TABLE player_match_stats (
    stat_id             SERIAL PRIMARY KEY,
    match_id            INT REFERENCES matches(match_id),
    player_id           INT REFERENCES players(player_id),
    team_id             INT REFERENCES teams(team_id),

    -- Attacking
    goals               INT DEFAULT 0,
    assists             INT DEFAULT 0,
    shots_total         INT DEFAULT 0,
    shots_on_target     INT DEFAULT 0,
    xg                  NUMERIC(4,2) DEFAULT 0,
    key_passes          INT DEFAULT 0,
    dribbles_completed  INT DEFAULT 0,

    -- Passing
    passes_attempted    INT DEFAULT 0,
    passes_completed    INT DEFAULT 0,
    long_balls          INT DEFAULT 0,
    crosses             INT DEFAULT 0,

    -- Defending
    tackles             INT DEFAULT 0,
    interceptions       INT DEFAULT 0,
    clearances          INT DEFAULT 0,
    blocks              INT DEFAULT 0,

    -- Discipline
    yellow_cards        INT DEFAULT 0,
    red_cards           INT DEFAULT 0,
    fouls_committed     INT DEFAULT 0,
    fouls_won           INT DEFAULT 0,

    -- Physical
    distance_km         NUMERIC(4,2) DEFAULT 0,
    sprints             INT DEFAULT 0,
    rating              NUMERIC(3,1)  -- out of 10
);

-- ============================================================
--  TABLE: standings
-- ============================================================

CREATE TABLE standings (
    standing_id     SERIAL PRIMARY KEY,
    team_id         INT REFERENCES teams(team_id),
    matchweek       INT NOT NULL,
    played          INT DEFAULT 0,
    won             INT DEFAULT 0,
    drawn           INT DEFAULT 0,
    lost            INT DEFAULT 0,
    goals_for       INT DEFAULT 0,
    goals_against   INT DEFAULT 0,
    goal_diff       INT GENERATED ALWAYS AS (goals_for - goals_against) STORED,
    points          INT GENERATED ALWAYS AS ((won * 3) + drawn) STORED,
    UNIQUE(team_id, matchweek)
);

-- ============================================================
--  INDEXES  (performance on common query patterns)
-- ============================================================

CREATE INDEX idx_matches_date          ON matches(match_date);
CREATE INDEX idx_matches_home_team     ON matches(home_team_id);
CREATE INDEX idx_matches_away_team     ON matches(away_team_id);
CREATE INDEX idx_events_match          ON match_events(match_id);
CREATE INDEX idx_events_player         ON match_events(player_id);
CREATE INDEX idx_events_type           ON match_events(event_type);
CREATE INDEX idx_lineups_match_player  ON match_lineups(match_id, player_id);
CREATE INDEX idx_stats_player          ON player_match_stats(player_id);
CREATE INDEX idx_stats_match           ON player_match_stats(match_id);
CREATE INDEX idx_standings_team_week   ON standings(team_id, matchweek);
