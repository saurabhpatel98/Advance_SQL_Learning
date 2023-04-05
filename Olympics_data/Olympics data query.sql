--1. How many olympics games have been held?
select * from olympics_history;
select distinct games from olympics_history;
--ANS
select count (distinct games) as Total_games from olympics_history;

--2. List down all Olympics games held so far.
--ANS
select distinct games from olympics_history;
--ANS
select distinct get.year,get.games,get.city
from olympics_history as get
order by year

--3. Mention the total no of nations who participated in each olympics game?
select count(distinct team) from olympics_history
--4. Which year saw the highest and lowest no of countries participating in olympics?
  with all_countries as
        (select games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;
	

--5. Which nation has participated in all of the olympic games
select * from olympics_history;
select * from olympics_history_noc_regions;

select count(distinct games) as number_of_game
from olympics_history

select count(distinct a.games) as number_of_game,b.region
from olympics_history a
join olympics_history_noc_regions b ON a.noc=b.noc
group by b.region
HAVING COUNT(DISTINCT a.games) = (SELECT COUNT(DISTINCT games) FROM olympics_history);

--6. Identify the sport which was played in all summer olympics.
select * from olympics_history;
select * from olympics_history_noc_regions;

SELECT sport
FROM olympics_history
WHERE season = 'Summer'
GROUP BY sport
HAVING COUNT(DISTINCT year) = (SELECT COUNT(DISTINCT year) FROM olympics_history WHERE season = 'Summer')


--7. Which Sports were just played only once in the olympics?
select count(distinct games),sport from olympics_history;

SELECT sport, COUNT(DISTINCT games) AS no_of_games
FROM olympics_history
GROUP BY sport
HAVING COUNT(DISTINCT games) = 1;

--8.  Fetch the total no of sports played in each olympic games.
 with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;

--9.  Fetch details of the oldest athletes to win a gold medal.
select * from olympics_history;

with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;

--10. Find the Ratio of male and female athletes participated in all olympic games.

with t1 as
        (select sex, count(1) as cnt
        	from olympics_history
        	group by sex),
        t2 as
        	(select *, row_number() over(order by cnt) as rn
        	 from t1),
        min_cnt as
        	(select cnt from t2	where rn = 1),
        max_cnt as
        	(select cnt from t2	where rn = 2)
    select concat('1 : ', round(max_cnt.cnt::decimal/min_cnt.cnt, 2)) as ratio
    from min_cnt, max_cnt;
	
SELECT CONCAT('1 : ', ROUND(MAX(cnt)::DECIMAL/MIN(cnt), 2)) AS ratio
FROM (
  SELECT COUNT(*) AS cnt
  FROM olympics_history
  GROUP BY sex
  ORDER BY cnt ASC
  LIMIT 2
) AS t;
