# Advance_SQL_Learning
# Practice_1
## Questions:
### List of all these 20 queries mentioned below:
Ordered List 
1. How many olympics games have been held?
   ``` sql
    SELECT *
    FROM EMP
    JOIN DEPT
    ON EMP.DEPTNO = DEPT.DEPTNO;
    ```
2. List down all Olympics games held so far.
    ```sql
   select distinct get.year,get.games,get.city
    from olympics_history as get
    order by year
    ```
3. Mention the total no of nations who participated in each olympics game?
    ```sql
        select count(distinct team) from olympics_history
    ```  
4. Which year saw the highest and lowest no of countries participating in olympics?
      ``` sql
    with all_countries as
        (select games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;
    ```   
   The first line of the query defines a common table expression (CTE) named "all_countries." This CTE selects the "games" and "region" columns from the "olympics_history" table and joins it with the "olympics_history_noc_regions" table on the "noc" column. It then groups the result by "games" and "region", creating a temporary table that includes all of the countries that participated in each game.
   The second line of the query selects the "games" column from the "all_countries" CTE and uses the COUNT function to count the number of countries that participated in each game. It gives the count an alias "total_countries".
   The "total_countries" column is calculated using the COUNT function. The query selects the "games" and "region" columns from the "all_countries" CTE, which includes all of the countries that participated in each game. Then, the COUNT function counts the number of rows in the result set for each game. Since each row in the "all_countries" CTE represents a country that participated in a particular game, the COUNT function returns the number of countries that participated in each game, and that value is displayed in the "total_countries" column of the final output.
   The third line of the query groups the results by "games" and orders them in ascending order by "games".
   The final output will have two columns: "games" and "total_countries". The "games" column will list each Olympic game, and the "total_countries" column will show the number of countries that participated in each game.

5. Which nation has participated in all of the olympic games?
6. 
7. Identify the sport which was played in all summer olympics.
8. Which Sports were just played only once in the olympics?
9.  Fetch the total no of sports played in each olympic games.
10. Fetch details of the oldest athletes to win a gold medal.
11. Find the Ratio of male and female athletes participated in all olympic games.
12. Fetch the top 5 athletes who have won the most gold medals.
13. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
14. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
15. List down total gold, silver and broze medals won by each country.
16. List down total gold, silver and broze medals won by each country corresponding to each olympic games.
17. Identify which country won the most gold, most silver and most bronze medals in each olympic games.
18. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
19. Which countries have never won gold medal but have won silver/bronze medals?
20. In which Sport/event, India has won highest medals.
21. Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.