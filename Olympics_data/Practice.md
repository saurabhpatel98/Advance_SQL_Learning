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
    ```sql
    select * from olympics_history;
    select * from olympics_history_noc_regions;

    select count(distinct games) as number_of_game
    from olympics_history

    select count(distinct a.games) as number_of_game,b.region
    from olympics_history a
    join olympics_history_noc_regions b ON a.noc=b.noc
    group by b.region
    HAVING COUNT(DISTINCT a.games) = (SELECT COUNT(DISTINCT games) FROM olympics_history);
    ``` 
6. Identify the sport which was played in all summer olympics.
    ```sql
    select * from olympics_history;
    select * from olympics_history_noc_regions;

    SELECT sport
    FROM olympics_history
    WHERE season = 'Summer'
    GROUP BY sport
    HAVING COUNT(DISTINCT year) = (SELECT COUNT(DISTINCT year) FROM olympics_history WHERE season = 'Summer')

    ```
DISTINCT is used to remove duplicates from the result set, while GROUP BY is used to group similar data and perform aggregate functions on it.

The WHERE clause is used to filter the data before grouping, while the HAVING clause is used to filter the data after grouping.

## When writing a SQL query, you need to consider several things like what you want to select, filter, group, and aggregate. Here are some basic rules and restrictions you should follow while querying:

## SELECT clause: In the SELECT clause, you can specify what columns you want to display in the result set. You can also use aggregate functions (e.g. COUNT, SUM, AVG, MAX, MIN) to compute summaries of the data. If you use an aggregate function, you must use a GROUP BY clause to group the data by one or more columns. You can also use expressions, arithmetic operations, and aliases to transform the data.

## FROM clause: In the FROM clause, you specify the table or tables you want to query. You can also use subqueries to create virtual tables to use in the query.

## WHERE clause: In the WHERE clause, you specify the conditions that the data must meet to be included in the result set. You can use logical operators (AND, OR, NOT), comparison operators (=, <>, <, >, <=, >=), and pattern matching operators (LIKE, IN, BETWEEN). You can also use subqueries in the WHERE clause to filter the data.

## GROUP BY clause: In the GROUP BY clause, you specify the columns by which you want to group the data. If you use a GROUP BY clause, you can only select columns that are part of the GROUP BY clause or aggregate functions. You can also use the HAVING clause to filter groups based on conditions that involve aggregate functions.

## HAVING clause: In the HAVING clause, you specify the conditions that the groups must meet to be included in the result set. You can use logical operators (AND, OR, NOT), comparison operators (=, <>, <, >, <=, >=), and aggregate functions. You can also use subqueries in the HAVING clause to filter the groups.

## Order of clauses: The order of clauses in a SQL query is important. The order of clauses is as follows: SELECT, FROM, WHERE, GROUP BY, HAVING, ORDER BY.

## Table aliases: You can use table aliases to shorten the table names in the query. You can also use aliases for columns, expressions, and subqueries.

## Subqueries: Subqueries are queries that are nested inside another query. Subqueries can be used in the SELECT, FROM, WHERE, and HAVING clauses.

## Table variables: Table variables are temporary tables that can be used in a query. Table variables are declared using the DECLARE keyword and have a similar syntax to regular tables.

## To answer your question, you need to consider what you want to achieve in your query, and then use the appropriate clauses, functions, and operators to get the desired results. You can use table variables in the SELECT and HAVING clauses, but you need to ensure that they are properly defined and scoped. Remember to follow the basic rules and restrictions of SQL while querying to avoid syntax errors and incorrect results.

7. Which Sports were just played only once in the olympics?
    ```sql
    SELECT sport, COUNT(DISTINCT games) AS no_of_games
    FROM olympics_history
    GROUP BY sport
    HAVING COUNT(DISTINCT games) = 1;
    ```   
8.  Fetch the total no of sports played in each olympic games.
   ```sql
    with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;
   ```
9.  Fetch details of the oldest athletes to win a gold medal.
    ```sql
    with t1 as
      	(select distinct games, sport
      	from olympics_history),
        t2 as
      	(select games, count(1) as no_of_sports
      	from t1
      	group by games)
      select * from t2
      order by no_of_sports desc;
    ```
10. Find the Ratio of male and female athletes participated in all olympic games.
    ```sql
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
    ```
11.  Fetch the top 5 athletes who have won the most gold medals.
    
12. Fetch the top 5 athletes who have won the most medals (gold/silver/bronze).
13. Fetch the top 5 most successful countries in olympics. Success is defined by no of medals won.
14. List down total gold, silver and broze medals won by each country.
15. List down total gold, silver and broze medals won by each country corresponding to each olympic games.
16. Identify which country won the most gold, most silver and most bronze medals in each olympic games.
17. Identify which country won the most gold, most silver, most bronze medals and the most medals in each olympic games.
18. Which countries have never won gold medal but have won silver/bronze medals?
19. In which Sport/event, India has won highest medals.
20. Break down all olympic games where india won medal for Hockey and how many medals in each olympic games.