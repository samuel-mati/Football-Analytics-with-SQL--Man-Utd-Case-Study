-- ============================================================
--  SEED DATA — Premier League 2023/24
--  Focus: Manchester United + Top 6 rivals
-- ============================================================

-- ============================================================
--  TEAMS
-- ============================================================

INSERT INTO teams (name, short_name, city, stadium, stadium_capacity, manager, founded_year, primary_color, secondary_color) VALUES
('Manchester United',   'MUN', 'Manchester', 'Old Trafford',           74310, 'Erik ten Hag',      1878, '#DA291C', '#000000'),
('Manchester City',     'MCI', 'Manchester', 'Etihad Stadium',         53400, 'Pep Guardiola',     1880, '#6CABDD', '#FFFFFF'),
('Arsenal',             'ARS', 'London',     'Emirates Stadium',       60704, 'Mikel Arteta',      1886, '#EF0107', '#FFFFFF'),
('Liverpool',           'LIV', 'Liverpool',  'Anfield',                61276, 'Jürgen Klopp',      1892, '#C8102E', '#00B2A9'),
('Chelsea',             'CHE', 'London',     'Stamford Bridge',        41837, 'Mauricio Pochettino',1905, '#034694', '#FFFFFF'),
('Tottenham Hotspur',   'TOT', 'London',     'Tottenham Hotspur Stad.',62850, 'Ange Postecoglou',  1882, '#132257', '#FFFFFF'),
('Newcastle United',    'NEW', 'Newcastle',  'St. James Park',         52305, 'Eddie Howe',        1892, '#241F20', '#FFFFFF'),
('Aston Villa',         'AVL', 'Birmingham', 'Villa Park',             42749, 'Unai Emery',        1874, '#95BFE5', '#670E36');

-- ============================================================
--  PLAYERS — Manchester United (team_id = 1)
-- ============================================================

INSERT INTO players (team_id, full_name, known_as, nationality, position, date_of_birth, squad_number, market_value_m) VALUES
(1, 'André Onana',               'Onana',      'Cameroonian', 'GK',  '1996-04-02',  24, 35.0),
(1, 'Aaron Wan-Bissaka',         'AWB',        'English',     'RB',  '1997-11-26',  29, 15.0),
(1, 'Raphaël Varane',            'Varane',     'French',      'CB',  '1993-04-25',  19, 20.0),
(1, 'Harry Maguire',             'Maguire',    'English',     'CB',  '1993-03-05',   5, 18.0),
(1, 'Luke Shaw',                 'Shaw',       'English',     'LB',  '1995-07-12',  23, 30.0),
(1, 'Casemiro',                  'Casemiro',   'Brazilian',   'CDM', '1992-02-23',  18, 35.0),
(1, 'Mason Mount',               'Mount',      'English',     'CM',  '1999-01-10',   7, 40.0),
(1, 'Bruno Fernandes',           'Bruno',      'Portuguese',  'CAM', '1994-09-08',   8, 75.0),
(1, 'Antony',                    'Antony',     'Brazilian',   'RW',  '2000-02-24',  21, 45.0),
(1, 'Marcus Rashford',           'Rashford',   'English',     'LW',  '1997-10-31',  10, 80.0),
(1, 'Rasmus Højlund',            'Højlund',    'Danish',      'ST',  '2003-02-19',  11, 65.0),
(1, 'Sofyan Amrabat',            'Amrabat',    'Moroccan',    'CDM', '1996-08-21',   4, 25.0),
(1, 'Scott McTominay',           'McTominay',  'Scottish',    'CM',  '1996-12-08',  39, 20.0),
(1, 'Alejandro Garnacho',        'Garnacho',   'Argentine',   'LW',  '2004-07-01',  49, 50.0),
(1, 'Kobbie Mainoo',             'Mainoo',     'English',     'CM',  '2005-04-19',  37, 30.0),
(1, 'Diogo Dalot',               'Dalot',      'Portuguese',  'RB',  '1999-03-18',  20, 35.0),
(1, 'Lisandro Martínez',         'Licha',      'Argentine',   'CB',  '1998-01-18',   6, 55.0),
(1, 'Victor Lindelöf',           'Lindelöf',   'Swedish',     'CB',  '1994-07-17',   2, 15.0);

-- ============================================================
--  PLAYERS — Manchester City (team_id = 2)
-- ============================================================

INSERT INTO players (team_id, full_name, known_as, nationality, position, date_of_birth, squad_number, market_value_m) VALUES
(2, 'Ederson',                   'Ederson',    'Brazilian',   'GK',  '1993-08-17',  31, 50.0),
(2, 'Kyle Walker',               'Walker',     'English',     'RB',  '1990-05-28',   2, 25.0),
(2, 'Rúben Dias',                'R. Dias',    'Portuguese',  'CB',  '1997-05-14',   3, 80.0),
(2, 'Manuel Akanji',             'Akanji',     'Swiss',       'CB',  '1995-07-19',  25, 45.0),
(2, 'Joško Gvardiol',            'Gvardiol',   'Croatian',    'LB',  '2002-01-23',  24, 80.0),
(2, 'Rodri',                     'Rodri',      'Spanish',     'CDM', '1996-06-22',  16,110.0),
(2, 'Kevin De Bruyne',           'KDB',        'Belgian',     'CM',  '1991-06-28',  17,100.0),
(2, 'Bernardo Silva',            'Bernardo',   'Portuguese',  'CM',  '1994-08-10',  20, 90.0),
(2, 'Phil Foden',                'Foden',      'English',     'RW',  '2000-05-28',  47,120.0),
(2, 'Jeremy Doku',               'Doku',       'Belgian',     'LW',  '2002-12-12',  11, 70.0),
(2, 'Erling Haaland',            'Haaland',    'Norwegian',   'ST',  '2000-07-21',   9,180.0);

-- ============================================================
--  PLAYERS — Arsenal (team_id = 3)
-- ============================================================

INSERT INTO players (team_id, full_name, known_as, nationality, position, date_of_birth, squad_number, market_value_m) VALUES
(3, 'David Raya',                'Raya',       'Spanish',     'GK',  '1995-09-15',  22, 35.0),
(3, 'Ben White',                 'B. White',   'English',     'RB',  '1997-10-08',   4, 55.0),
(3, 'William Saliba',            'Saliba',     'French',      'CB',  '2001-03-24',  12, 80.0),
(3, 'Gabriel Magalhães',         'Gabriel',    'Brazilian',   'CB',  '1997-12-19',   6, 70.0),
(3, 'Oleksandr Zinchenko',       'Zinchenko',  'Ukrainian',   'LB',  '1996-12-15',  35, 40.0),
(3, 'Thomas Partey',             'Partey',     'Ghanaian',    'CDM', '1993-06-13',   5, 35.0),
(3, 'Martin Ødegaard',           'Ødegaard',   'Norwegian',   'CAM', '1998-12-17',   8,110.0),
(3, 'Declan Rice',               'Rice',       'English',     'CM',  '1999-01-14',  41,100.0),
(3, 'Bukayo Saka',               'Saka',       'English',     'RW',  '2001-09-05',   7,150.0),
(3, 'Leandro Trossard',          'Trossard',   'Belgian',     'LW',  '1994-12-04',  19, 45.0),
(3, 'Kai Havertz',               'Havertz',    'German',      'ST',  '1999-06-11',  29, 55.0);

-- ============================================================
--  PLAYERS — Liverpool (team_id = 4)
-- ============================================================

INSERT INTO players (team_id, full_name, known_as, nationality, position, date_of_birth, squad_number, market_value_m) VALUES
(4, 'Alisson Becker',            'Alisson',    'Brazilian',   'GK',  '1992-10-02',   1, 55.0),
(4, 'Trent Alexander-Arnold',    'TAA',        'English',     'RB',  '1998-10-07',  66, 90.0),
(4, 'Virgil van Dijk',           'VVD',        'Dutch',       'CB',  '1991-07-08',   4, 60.0),
(4, 'Ibrahima Konaté',           'Konaté',     'French',      'CB',  '1999-05-25',   5, 65.0),
(4, 'Andrew Robertson',          'Robertson',  'Scottish',    'LB',  '1994-03-11',  26, 50.0),
(4, 'Alexis Mac Allister',       'Mac Allister','Argentine',  'CM',  '1998-12-24',  10, 70.0),
(4, 'Dominik Szoboszlai',        'Szoboszlai', 'Hungarian',   'CM',  '2000-10-25',   8, 80.0),
(4, 'Mohamed Salah',             'Salah',      'Egyptian',    'RW',  '1992-06-15',  11,100.0),
(4, 'Luis Díaz',                 'L. Díaz',    'Colombian',   'LW',  '1997-01-13',   7, 75.0),
(4, 'Darwin Núñez',              'Núñez',      'Uruguayan',   'ST',  '1999-06-24',   9, 80.0),
(4, 'Cody Gakpo',                'Gakpo',      'Dutch',       'LW',  '1999-05-07',  18, 60.0);

-- ============================================================
--  MATCHES — Manchester United 2023/24 (selection of key matches)
-- ============================================================
-- home_team_id=1 is Man Utd; away results also included

INSERT INTO matches (home_team_id, away_team_id, match_date, kickoff_time, stage, stadium, referee, home_goals, away_goals, home_xg, away_xg, attendance) VALUES
-- Man Utd home games
(1, 2, '2023-10-29', '16:30', 'Matchweek 10', 'Old Trafford',           'Michael Oliver',    0, 3, 0.72, 2.87, 73721),
(1, 3, '2023-11-04', '14:00', 'Matchweek 11', 'Old Trafford',           'Craig Pawson',      1, 0, 1.45, 0.89, 73854),
(1, 4, '2023-12-17', '16:30', 'Matchweek 17', 'Old Trafford',           'Anthony Taylor',    0, 0, 0.88, 1.12, 73765),
(1, 5, '2023-10-21', '12:30', 'Matchweek 9',  'Old Trafford',           'Paul Tierney',      4, 3, 3.21, 2.14, 73601),
(1, 6, '2024-01-14', '14:00', 'Matchweek 21', 'Old Trafford',           'Stuart Attwell',    2, 2, 1.87, 1.43, 73712),
(1, 7, '2024-02-11', '16:30', 'Matchweek 24', 'Old Trafford',           'Simon Hooper',      3, 0, 2.94, 0.54, 73540),
(1, 8, '2023-12-26', '15:00', 'Matchweek 19', 'Old Trafford',           'Robert Jones',      3, 2, 2.67, 1.98, 73888),
-- Man Utd away games
(2, 1, '2023-10-07', '12:30', 'Matchweek 8',  'Etihad Stadium',         'Michael Oliver',    3, 1, 2.98, 1.03, 53403),
(3, 1, '2023-09-03', '16:30', 'Matchweek 4',  'Emirates Stadium',       'Anthony Taylor',    3, 1, 2.76, 0.87, 60704),
(4, 1, '2024-03-17', '16:30', 'Matchweek 29', 'Anfield',                'Stuart Attwell',    2, 2, 1.54, 1.76, 61276),
(5, 1, '2023-11-12', '16:30', 'Matchweek 12', 'Stamford Bridge',        'Craig Pawson',      4, 3, 3.45, 2.33, 41837),
(6, 1, '2024-01-28', '14:00', 'Matchweek 22', 'Tottenham Hotspur Stad.','Paul Tierney',      2, 2, 1.89, 1.74, 62100),
(7, 1, '2024-01-13', '15:00', 'Matchweek 21', 'St. James Park',         'Peter Bankes',      1, 0, 1.23, 0.76, 52305),
(8, 1, '2024-02-11', '14:00', 'Matchweek 24', 'Villa Park',             'Michael Oliver',    2, 1, 1.87, 1.21, 42749),
-- Additional Man Utd matches
(1, 7, '2024-04-24', '20:00', 'Matchweek 35', 'Old Trafford',           'Chris Kavanagh',    3, 2, 2.45, 1.56, 73721),
(1, 8, '2024-05-13', '20:00', 'Matchweek 37', 'Old Trafford',           'Anthony Taylor',    1, 1, 1.32, 0.98, 73810);

-- ============================================================
--  TACTICAL FORMATIONS
-- ============================================================

INSERT INTO tactical_formations (match_id, team_id, formation_name, is_starting, applied_minute) VALUES
-- match 1 (MUN vs MCI)
(1, 1, '4-2-3-1', TRUE,  0),
(1, 1, '4-4-2',   FALSE, 62),
(1, 2, '4-3-3',   TRUE,  0),
-- match 2 (MUN vs ARS)
(2, 1, '4-2-3-1', TRUE,  0),
(2, 3, '4-3-3',   TRUE,  0),
-- match 3 (MUN vs LIV)
(3, 1, '4-3-3',   TRUE,  0),
(3, 4, '4-3-3',   TRUE,  0),
-- match 4 (MUN vs CHE)
(4, 1, '4-2-3-1', TRUE,  0),
(4, 5, '4-2-3-1', TRUE,  0),
-- match 5 (MUN vs TOT)
(5, 1, '4-3-3',   TRUE,  0),
(5, 6, '4-2-3-1', TRUE,  0),
-- match 6 (MUN vs NEW)
(6, 1, '4-2-3-1', TRUE,  0),
(6, 7, '5-4-1',   TRUE,  0),
-- match 7 (MUN vs AVL)
(7, 1, '4-2-3-1', TRUE,  0),
(7, 8, '4-3-3',   TRUE,  0),
-- MCI vs MUN
(8, 1, '4-2-3-1', TRUE,  0),
(8, 2, '4-3-3',   TRUE,  0),
-- ARS vs MUN
(9, 1, '4-3-3',   TRUE,  0),
(9, 3, '4-3-3',   TRUE,  0),
-- LIV vs MUN
(10, 1, '4-2-3-1', TRUE, 0),
(10, 4, '4-3-3',   TRUE, 0),
-- CHE vs MUN
(11, 1, '4-2-3-1', TRUE, 0),
(11, 5, '4-3-3',   TRUE, 0),
-- TOT vs MUN
(12, 1, '4-3-3',   TRUE, 0),
(12, 6, '4-2-3-1', TRUE, 0),
-- NEW vs MUN
(13, 1, '4-2-3-1', TRUE, 0),
(13, 7, '4-3-1-2', TRUE, 0),
-- AVL vs MUN
(14, 1, '4-3-3',   TRUE, 0),
(14, 8, '4-3-3',   TRUE, 0),
-- MUN vs NEW (Matchweek 35)
(15, 1, '4-2-3-1', TRUE, 0),
(15, 7, '4-4-2',   TRUE, 0),
-- MUN vs AVL (Matchweek 37)
(16, 1, '4-3-3',   TRUE, 0),
(16, 8, '4-2-3-1', TRUE, 0);

-- ============================================================
--  MATCH EVENTS — Key goals, cards, assists
-- ============================================================
-- Players: Bruno=8, Rashford=10, Højlund=11, Garnacho=14, McTominay=13
-- Using player_id offsets: MUN players start at 1, MCI at 19, ARS at 30, LIV at 41

-- Match 1: MUN 0-3 MCI
INSERT INTO match_events (match_id, team_id, player_id, event_type, minute, pitch_zone) VALUES
(1, 2, 27, 'goal',        35, 'opp_box'),   -- Haaland goal
(1, 2, 27, 'goal',        58, 'opp_box'),   -- Haaland brace
(1, 2, 26, 'goal',        81, 'opp_box'),   -- Foden goal
(1, 1,  6, 'yellow_card', 44, 'mid_center');  -- Casemiro booking

-- Match 2: MUN 1-0 ARS
INSERT INTO match_events (match_id, team_id, player_id, related_player_id, event_type, minute, pitch_zone) VALUES
(2, 1, 11, 8,  'goal',        56, 'opp_box'),   -- Højlund scores, Bruno assists
(2, 1,  8, NULL,'key_pass',   54, 'opp_half_center'),
(2, 3, 40, NULL,'yellow_card',67, 'mid_center'); -- Havertz booked

-- Match 3: MUN 0-0 LIV
INSERT INTO match_events (match_id, team_id, player_id, event_type, minute, pitch_zone) VALUES
(3, 1,  8, 'yellow_card', 39, 'mid_center'),
(3, 4, 51, 'yellow_card', 72, 'mid_left');

-- Match 4: MUN 4-3 CHE
INSERT INTO match_events (match_id, team_id, player_id, related_player_id, event_type, minute, pitch_zone) VALUES
(4, 1, 10, 8,  'goal', 12, 'opp_box'),   -- Rashford
(4, 1, 11, 8,  'goal', 28, 'opp_box'),   -- Højlund
(4, 1,  8, NULL,'goal', 45, 'opp_box'),  -- Bruno pen
(4, 1, 14, 10, 'goal', 78, 'opp_box'),   -- Garnacho
(4, 1,  8, NULL,'assist',12, 'opp_half_center'),
(4, 1,  8, NULL,'assist',28, 'opp_half_center');

-- Match 5: MUN 2-2 TOT
INSERT INTO match_events (match_id, team_id, player_id, related_player_id, event_type, minute, pitch_zone) VALUES
(5, 1, 10, 8,  'goal', 23, 'opp_box'),
(5, 1, 14, 10, 'goal', 67, 'opp_box'),
(5, 1,  8, NULL,'assist',23, 'opp_half_center'),
(5, 1, 15, NULL,'yellow_card', 55, 'mid_center');

-- Match 6: MUN 3-0 NEW
INSERT INTO match_events (match_id, team_id, player_id, related_player_id, event_type, minute, pitch_zone) VALUES
(6, 1, 11, 8,  'goal', 18, 'opp_box'),
(6, 1, 10, 14, 'goal', 44, 'opp_box'),
(6, 1,  8, NULL,'goal', 72, 'opp_box'),
(6, 1,  8, NULL,'assist',44, 'mid_center');

-- Match 7: MUN 3-2 AVL
INSERT INTO match_events (match_id, team_id, player_id, related_player_id, event_type, minute, pitch_zone) VALUES
(7, 1, 11, 8, 'goal', 10, 'opp_box'),
(7, 1,  8, NULL,'goal', 55, 'opp_box'),
(7, 1, 14, 10, 'goal', 88, 'opp_box');   -- late winner

-- Match 8: MCI 3-1 MUN (away)
INSERT INTO match_events (match_id, team_id, player_id, event_type, minute, pitch_zone) VALUES
(8, 2, 27, 'goal', 20, 'opp_box'),
(8, 2, 27, 'goal', 49, 'opp_box'),
(8, 2, 26, 'goal', 77, 'opp_box'),
(8, 1, 10, 'goal', 60, 'opp_box');  -- Rashford consolation

-- Match 9: ARS 3-1 MUN
INSERT INTO match_events (match_id, team_id, player_id, event_type, minute, pitch_zone) VALUES
(9, 3, 39, 'goal', 14, 'opp_box'),  -- Saka
(9, 3, 38, 'goal', 41, 'opp_box'),  -- Rice
(9, 1, 11, 'goal', 55, 'opp_box'),  -- Højlund
(9, 3, 39, 'goal', 74, 'opp_box'),  -- Saka second
(9, 1,  6, 'red_card', 68, 'mid_center'); -- Casemiro red

-- Match 10: LIV 2-2 MUN
INSERT INTO match_events (match_id, team_id, player_id, related_player_id, event_type, minute, pitch_zone) VALUES
(10, 4, 49, NULL, 'goal', 22, 'opp_box'),  -- Salah
(10, 1, 13, 8,   'goal', 37, 'opp_box'),  -- McTominay
(10, 4, 50, NULL, 'goal', 61, 'opp_box'),  -- Núñez
(10, 1,  8, NULL, 'goal', 87, 'opp_box'),  -- Bruno late equaliser
(10, 1,  8, NULL, 'assist',37, 'mid_center');

-- ============================================================
--  PLAYER MATCH STATS — Bruno Fernandes (player_id=8) full season
-- ============================================================

INSERT INTO player_match_stats (match_id, player_id, team_id, goals, assists, shots_total, shots_on_target, xg, key_passes, passes_attempted, passes_completed, dribbles_completed, tackles, interceptions, yellow_cards, fouls_committed, distance_km, rating) VALUES
(1,  8, 1, 0, 0,  1, 0, 0.08,  3, 52, 44, 1, 1, 0, 0, 1, 11.2, 5.8),
(2,  8, 1, 0, 1,  2, 1, 0.18,  5, 61, 53, 2, 0, 1, 0, 0, 11.8, 8.1),
(3,  8, 1, 0, 0,  2, 0, 0.21,  4, 58, 47, 1, 2, 1, 1, 2, 10.9, 6.4),
(4,  8, 1, 1, 2,  3, 2, 0.34,  7, 64, 55, 3, 1, 0, 0, 1, 12.1, 9.2),
(5,  8, 1, 0, 1,  1, 1, 0.12,  5, 59, 51, 1, 1, 1, 0, 0, 11.4, 7.6),
(6,  8, 1, 1, 1,  4, 2, 0.41,  6, 66, 58, 2, 0, 0, 0, 1, 11.7, 8.7),
(7,  8, 1, 1, 1,  2, 2, 0.28,  4, 55, 48, 1, 1, 0, 0, 0, 10.8, 8.4),
(8,  8, 1, 0, 0,  1, 0, 0.09,  2, 44, 35, 1, 1, 0, 0, 2, 10.2, 5.5),
(9,  8, 1, 0, 0,  1, 0, 0.11,  3, 48, 38, 0, 0, 0, 0, 1, 10.5, 5.9),
(10, 8, 1, 1, 1,  3, 2, 0.38,  5, 57, 49, 2, 1, 1, 0, 0, 11.6, 8.9),
(11, 8, 1, 0, 0,  2, 1, 0.19,  4, 53, 44, 1, 2, 0, 0, 1, 11.0, 6.7),
(12, 8, 1, 0, 0,  1, 0, 0.08,  3, 56, 46, 0, 1, 1, 0, 0, 10.7, 6.2),
(13, 8, 1, 0, 0,  0, 0, 0.04,  2, 50, 41, 0, 2, 0, 0, 0, 10.3, 5.8),
(14, 8, 1, 0, 0,  2, 1, 0.22,  4, 54, 45, 1, 1, 0, 0, 1, 10.9, 6.5),
(15, 8, 1, 1, 0,  3, 2, 0.31,  5, 60, 52, 2, 0, 0, 0, 0, 11.5, 7.8),
(16, 8, 1, 0, 1,  1, 0, 0.09,  4, 57, 49, 1, 1, 0, 0, 0, 10.8, 7.1);

-- ============================================================
--  PLAYER MATCH STATS — Marcus Rashford (player_id=10)
-- ============================================================

INSERT INTO player_match_stats (match_id, player_id, team_id, goals, assists, shots_total, shots_on_target, xg, key_passes, passes_attempted, passes_completed, dribbles_completed, tackles, yellow_cards, fouls_committed, distance_km, rating) VALUES
(1,  10, 1, 0, 0, 2, 1, 0.21, 2, 28, 22, 2, 0, 0, 1, 10.8, 5.9),
(2,  10, 1, 0, 0, 3, 1, 0.27, 1, 24, 19, 3, 0, 0, 0, 11.2, 6.2),
(3,  10, 1, 0, 0, 1, 0, 0.09, 1, 22, 17, 1, 0, 0, 1, 10.4, 5.5),
(4,  10, 1, 1, 0, 4, 2, 0.45, 2, 30, 24, 3, 0, 0, 0, 11.7, 8.3),
(5,  10, 1, 1, 0, 3, 2, 0.38, 1, 26, 20, 2, 0, 0, 0, 11.0, 7.8),
(6,  10, 1, 1, 0, 2, 1, 0.31, 2, 27, 22, 2, 0, 0, 1, 11.3, 7.5),
(7,  10, 1, 0, 0, 2, 1, 0.24, 1, 25, 19, 1, 0, 0, 0, 10.6, 6.1),
(8,  10, 1, 1, 0, 3, 2, 0.41, 1, 21, 16, 2, 0, 0, 1, 10.2, 7.1),
(9,  10, 1, 0, 0, 1, 0, 0.11, 0, 19, 14, 1, 0, 0, 0,  9.8, 5.4),
(10, 10, 1, 0, 0, 2, 1, 0.18, 1, 23, 18, 2, 0, 0, 0, 10.5, 6.0);

-- ============================================================
--  PLAYER MATCH STATS — Rasmus Højlund (player_id=11)
-- ============================================================

INSERT INTO player_match_stats (match_id, player_id, team_id, goals, assists, shots_total, shots_on_target, xg, key_passes, passes_attempted, passes_completed, dribbles_completed, tackles, yellow_cards, fouls_committed, distance_km, rating) VALUES
(1,  11, 1, 0, 0, 3, 1, 0.28, 0, 15, 10, 1, 0, 0, 2, 9.8,  5.7),
(2,  11, 1, 1, 0, 4, 2, 0.52, 1, 18, 13, 2, 0, 0, 1, 10.2, 8.0),
(3,  11, 1, 0, 0, 2, 1, 0.23, 0, 14, 10, 0, 0, 0, 1,  9.5, 5.9),
(4,  11, 1, 1, 0, 5, 3, 0.61, 1, 17, 12, 1, 0, 0, 2, 10.4, 8.2),
(5,  11, 1, 0, 0, 3, 1, 0.31, 0, 16, 11, 1, 0, 0, 1,  9.9, 6.1),
(6,  11, 1, 1, 0, 4, 2, 0.48, 1, 19, 14, 1, 0, 0, 2, 10.3, 7.9),
(7,  11, 1, 1, 0, 3, 2, 0.44, 0, 15, 11, 0, 0, 0, 1, 10.0, 7.7),
(8,  11, 1, 0, 0, 2, 0, 0.19, 0, 13,  9, 0, 0, 0, 2,  9.3, 5.1),
(9,  11, 1, 1, 0, 4, 2, 0.55, 0, 16, 11, 1, 0, 0, 1,  9.8, 7.2),
(10, 11, 1, 0, 0, 2, 1, 0.22, 0, 14, 10, 0, 0, 0, 1,  9.4, 5.8);

-- ============================================================
--  STANDINGS — Matchweek snapshots
-- ============================================================

INSERT INTO standings (team_id, matchweek, played, won, drawn, lost, goals_for, goals_against) VALUES
-- After Matchweek 10
(1, 10,  10, 4, 1, 5, 18, 22),
(2, 10,  10, 7, 1, 2, 27, 12),
(3, 10,  10, 7, 2, 1, 24,  9),
(4, 10,  10, 6, 2, 2, 22, 14),
(5, 10,  10, 3, 2, 5, 15, 20),
(6, 10,  10, 4, 3, 3, 16, 18),
-- After Matchweek 20
(1, 20,  20, 8, 3, 9, 26, 35),
(2, 20,  20,15, 2, 3, 48, 20),
(3, 20,  20,14, 3, 3, 42, 19),
(4, 20,  20,13, 4, 3, 40, 22),
(5, 20,  20, 8, 3, 9, 30, 40),
(6, 20,  20, 9, 4, 7, 30, 31),
-- After Matchweek 38 (final)
(1, 38,  38,14, 4,20, 42, 58),
(2, 38,  38,28, 5, 5, 96, 34),
(3, 38,  38,28, 5, 5, 91, 29),
(4, 38,  38,24, 6, 8, 86, 41),
(5, 38,  38,13, 5,20, 54, 76),
(6, 38,  38,20, 6,12, 74, 61),
(7, 38,  38,18, 6,14, 85, 62),
(8, 38,  38,20, 8,10, 76, 61);
