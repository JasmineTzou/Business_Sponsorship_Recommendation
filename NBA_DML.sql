##DEPA Final group project: NBA sponsorship recommendation
#Team member: Jeniffer Lee, Maggie Chuang, Yichin Tzou

use NBA_1;

####Team overview####
#Each team's arena and where it locate
SELECT teamname as Team, arena_name as Arena, city_name as City, country as Country
FROM teams t 
LEFT JOIN arena a ON t.teams_arena_id = a.arena_id
LEFT JOIN city c ON c.city_id = a.arena_city_id
ORDER BY teamname;

#NUMBER OF GAMES PLAYED IN EACH CITY IN SEASON 2020
SELECT 
c.city_name as City,
COUNT(g.game_id) as 'Number of Games'
from 
city c
left join arena a on c.city_id= a.arena_city_id
left join teams t on a.arena_id=t.teams_arena_id
left join games g on t.team_id=g.home_team_id
where g.season =2020
group by c.city_name
order by COUNT(g.game_id) desc
;

#PERCENTAGE OF TEAM WINNING IN THEIR OWN ARENA(HOME TEAM WINS)
select
t.teamname as Team,
round(count(g.home_team_wins)/82*100,4) as 'Percentage of Winning Games in their own arena(%)' 
from
teams t
left join games g on t.team_id = g.home_team_id
where g.season=2020 and g.home_team_wins=1
group by t.team_id
order by count(g.home_team_wins) desc
;

#Team Performance
SELECT g1.HOME_TEAM_ID 'team_id', t.teamname,
ROUND(((AVG(g1.fg_pct_home) + AVG(g2.fg_pct_away))/2) * 100, 4) 'Field Goal Made(%)',
ROUND(((AVG(g1.fg3_pct_home) +  AVG(g2.fg3_pct_away))/2) * 100,4) 'Free throw Percentage(%)',
ROUND(((AVG(g1.ft_pct_home) + AVG(g2.ft_pct_away)) /2) * 100, 4) '3 Points Field Goal Percentage(%)'
FROM games g1 INNER JOIN games g2 ON g1.HOME_TEAM_ID = g2.VISITOR_TEAM_ID
LEFT JOIN teams t ON t.team_id = g1.home_team_id
GROUP BY g1.HOME_TEAM_ID
ORDER BY ROUND(((AVG(g1.fg_pct_home) + AVG(g2.fg_pct_away))/2) * 100, 4) DESC, 
ROUND(((AVG(g1.fg3_pct_home) +  AVG(g2.fg3_pct_away))/2) * 100,4) DESC,
ROUND(((AVG(g1.ft_pct_home) + AVG(g2.ft_pct_away)) /2) * 100, 4) DESC;


####Player Overview####
#points gain by per player
select 	
p.player_id as ID,
p.player_name as Name,
sum(pgd.pts) as 'Points Gained'
from
players p
left join teams t on t.team_id=p.team_id
left join player_games_details pgd on p.player_id=pgd.player_id
left join games g on pgd.game_id=g.game_id
where g.season =2020
group by p.player_id
order by pgd.pts desc
limit 10;

#top10 players who has best performance iin field goal in season 2020
select 
p.player_id as ID,
p.player_name as Name,
t.teamname as Team,
ROUND(avg(pgd.fg_pct)*100,4) as 'Field Goal Percentage'
from
players p
left join teams t on t.team_id=p.team_id
left join player_games_details pgd on p.player_id=pgd.player_id
left join games g on pgd.game_id=g.game_id
where g.season =2020
group by p.player_id
order by  avg(pgd.fg_pct)*100 desc
limit 10;

#top10 players who has best performance in season 2020
select 
p.player_id as ID,
p.player_name as Name,
ROUND((avg(pgd.fg_pct)+avg(pgd.fg3_pct)+avg(pgd.ft_pct))/3*100,4) as 'Overall Score',
ROUND(avg(pgd.fg_pct)*100,4) as 'Field Goal Percentage(%)',
ROUND(avg(pgd.fg3_pct)*100,4) as '3 Points Field Goal Percentage(%)',
ROUND(avg(pgd.ft_pct)*100,4) as 'Free throw Percentage(%)'
from
players p
left join teams t on t.team_id=p.team_id
left join player_games_details pgd on p.player_id=pgd.player_id
left join games g on pgd.game_id=g.game_id
where g.season =2020
group by p.player_id
order by  ROUND((avg(pgd.fg_pct)+avg(pgd.fg3_pct)+avg(pgd.ft_pct))/3*100,4) desc
limit 10;