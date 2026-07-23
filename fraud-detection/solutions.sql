1. Matches per year:-
select * from matches;

select year(MatchDate) as yr, count(*) as mat from matches
group by yr;

2. Surface distribution:-
-- Try this:
-- Find number of matches played on different surface
select surface, count(*) as mat from matches
group by surface order by mat desc;

3. Player with most recorded wins (top 20):-
-- Try this:
-- Find Top 20 players with most recorded wins
select winner, count(*) as wins from matches
group by winner order by wins desc
limit 20;

 4. Head-to-head summary for two players:-
-- Try this:
-- Given two player names exactly as they appear in theDjokovic N. dataset (e.g., 'Djokovic N.' and 'Nadal R.'), compute their head-to-head: total meetings and wins for each player.
select 
sum(case when winner='Djokovic N.' then 1 else 0 end) as win_djo,
sum(case when winner='Nadal R.' then 1 else 0 end) as win_nad, count(*) as no_meets from matches
where (player1='Djokovic N.' and player2='Nadal R.') or (player1='Nadal R.' and player2='Djokovic N.');


5. Tie-break frequency (a set scored 7–6 appears in Score):-
-- Try this:
-- For each surface, compute the percentage of matches that had at least one tie-break set (a set scored 7–6 or 6–7)
select surface, round(100* avg(case when score like '%7-6%' then 1 else 0 end)) as break , count(*) as mat from matches
group by surface order by break;

6. Player surface splits (wins by surface, top 10 by total wins)
-- Try this:
-- For each player, count match wins by surface using the Winner and Surface columns. Show the top 10 players by total wins, and include columns for Hard, Clay, and Grass wins (ignore other surfaces).

with w as(
select winner as players, surface, count(*) as wins from matches group by players, surface
),
tot as(
select players,sum(wins) as tot_wins from w group by players 
)
select w.players, tot.tot_wins,
sum(case when w.surface='Hard' then w.wins else 0 end) as hardy,
sum(case when w.surface='Clay' then w.wins else 0 end) as claye,
sum(case when w.surface='Grass' then w.wins else 0 end) as grassy
from w 
join tot on tot.players=w.players
group by w.players, tot.tot_wins order by tot.tot_wins desc limit 10;










