1. Most-rated movies (popularity):-
-- Try this:
-- Find the Top 10 most-rated movies. Count the number of ratings per movie
show tables;
select * from movies;
select * from ratings;
select r.rating,m.title, count(*) as rate_cnt from ratings r
join movies m on r.movieId=m.movieId
group by m.title, r.rating order by rate_cnt desc
limit 10; 

2. Most active users:-
-- Try this:
-- Find the Top 10 users by number of ratings. Return userId and ratings_count
select * from ratings;
select userId,rating , count(*) as rate_cnt from ratings
group by userId, rating order by rate_cnt desc 
limit 10;

3. Ratings per year:-
-- Try this:
-- Find the number of ratings per year.
select * from ratings;
select year(rating_ts) as yr,count(*) as rate_cnt from ratings
group by yr order by yr ;

4. Top 15 tags by frequency:-
-- Try this:
-- Find Top 15 tags by frequency
select * from tags;
select lower(trim(tag)) as tag, count(*) as tag_cnt from tags
group by tag order by tag_cnt desc limit 15;

