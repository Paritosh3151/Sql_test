create database soccer_db;
use soccer_db;
-- 1. From the following table, write a SQL query to count the number of countries that parƟcipated 
-- in the 2016-EURO Cup. 
-- use table player_mast
select * from  match_mast; 
select * from player_mast ;
SELECT COUNT(DISTINCT country_id) AS num_countries_participated
FROM player_mast
WHERE tournament_year = 2016;
-- 2. From the following table, write a SQL query to find the number of matches that ended with a 
-- result. 
-- use table match_mast 
select * from match_mast ;
SELECT COUNT(match_no) AS num_matches
FROM match_mast
WHERE decided_by IS NOT NULL;
-- 3. From the following table, write a SQL query to find out when the Football EURO cup 2016 will 
-- begin. 
-- use table match_mast
select * from match_mast ;
SELECT MIN(play_date) AS start_date
FROM match_mast;
# 4. From the following table, write a SQL query to find out where the final match of the EURO cup 
-- 2016 was played. 
-- Return venue name, city. 
-- use tables: soccer_venue, soccer_city, match_mast
select * from soccer_venue ;
select * from soccer_city ;
SELECT soccer_venue.venue_name, soccer_city.city
FROM soccer_venue
JOIN soccer_city ON soccer_venue.city_id = soccer_city.city_id
JOIN match_mast ON soccer_venue.venue_id = match_mast.venue_id
WHERE match_no = '51';
-- 5. From the following tables, write a SQL query to find the number of goals scored by each team in 
-- each match during normal play. 
-- Return match number, country name and goal score. 
-- use tables: match_details, soccer_country 
select * from soccer_country;

SELECT match_details.match_no, soccer_country.country_name, match_details.goal_score
FROM match_details
JOIN soccer_country ON match_details.team_id = soccer_country.country_id;
-- 6. From the following table, write a SQL query to count the number of goals scored by each player 
-- within a normal play schedule. 
-- Group the result set on player name and country name and sorts the result-set according to the 
-- highest to the lowest scorer. 
-- Return player name, number of goals and country name. 
-- use tables: goal_details, player_mast, soccer_country 
select * from player_mast;
SELECT player_mast.player_name, COUNT(goal_details.goal_id) AS num_goals, soccer_country.country_name
FROM goal_details
JOIN player_mast ON goal_details.player_id = player_mast.player_id
JOIN soccer_country ON player_mast.country_id = soccer_country.country_id
WHERE goal_time <= '90'
GROUP BY player_mast.player_name, soccer_country.country_name
ORDER BY num_goals DESC;
-- 7. From the following table, write a SQL query to find out who scored the most goals in the 2016 
-- Euro Cup. 
-- Return player name, country name and highest individual scorer. 
-- use tables: goal_details, player_mast, soccer_country 

SELECT p.player_name, c.country_name, MAX(g.goals_scored) AS highest_individual_scorer
FROM goal_details g
JOIN player_mast p ON g.player_id = p.player_id
JOIN soccer_country c ON p.country_id = c.country_id
WHERE g.tournament_year = 2016
GROUP BY p.player_name, c.country_name
ORDER BY highest_individual_scorer DESC
LIMIT 1;

-- 8. From the following table, write a SQL query to find out which teams played the first match of the 
-- 2016 Euro Cup. 
-- Return match number, country name. 
-- use tables match_details, soccer_country 

SELECT md.match_number, c.country_name
FROM match_details md
JOIN soccer_country c ON md.country_id = c.country_id
WHERE md.tournament_year = 2016
ORDER BY md.match_date
LIMIT 1;

 -- 9. From the following table, write a SQL query to find the highest audience match. 
-- Return match_no, play_stage, goal_score, audience. 
-- use table match_mast 
SELECT match_no, play_stage, goal_score, audience
FROM match_mast
ORDER BY goal_score DESC
LIMIT 1;
-- 10. Write a SQL query to find the players who scored goals in each match. 
-- Group the result set on match number, country name and player name. 
-- Sort the result-set in ascending order by match number. 
-- Return match number, country name, player name and number of goals. 
-- use tables goal_details, soccer_country, player_mast

SELECT gd.match_number, sc.country_name, pm.player_name, COUNT(gd.goal_id) AS number_of_goals
FROM goal_details gd
JOIN player_mast pm ON gd.player_id = pm.player_id
JOIN soccer_country sc ON pm.country_id = sc.country_id
GROUP BY gd.match_number, sc.country_name, pm.player_name
ORDER BY gd.match_number ASC;
