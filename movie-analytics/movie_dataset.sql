Overview – Movie Rating Insights
Objective:

You're working with a streaming platform like Netflix. Your task is to analyze how users rate movies, identify top-performing films, and uncover viewer behavior across genres and time.



Dataset:

You’ll work with:

movies – basic movie info (movies.csv)

ratings – user–movie ratings (ratings.csv)

tags – user-applied tags on movies (tags.csv)

links – external IDs (IMDb/TMDB) for each movie (links.csv)

Inspired by MovieLens:

https://files.grouplens.org/datasets/movielens/ml-latest-small.zip



For other data on movie lens, refer:

https://grouplens.org/datasets/movielens/


-- INSTRUCTIONS:
|| MySQL Setup Instructions
0) Download & place the CSV



Open Grouplens link in previous article(Overview)  which will download zip file. Unzip the file.

Execute below commands in mysql workbench



1. create database & table

CREATE DATABASE IF NOT EXISTS movielens;

USE movielens;



-- Movies

CREATE TABLE movies (

  movieId   INT        NOT NULL PRIMARY KEY,

  title     VARCHAR(255) NOT NULL,

  genres    VARCHAR(255) NOT NULL            -- pipe-separated list, e.g. 'Adventure|Animation|Children'

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- Ratings

CREATE TABLE ratings (

  userId      INT         NOT NULL,

  movieId     INT         NOT NULL,

  rating      DECIMAL(2,1) NOT NULL,        -- values like 0.5 ... 5.0 in 0.5 increments

  ts_unix     BIGINT      NOT NULL,

  rating_ts   DATETIME    NOT NULL,

  PRIMARY KEY (userId, movieId, ts_unix),

  KEY ix_ratings_movie (movieId),

  CONSTRAINT fk_ratings_movie FOREIGN KEY (movieId) REFERENCES movies(movieId)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- Tags

CREATE TABLE tags (

  userId    INT          NOT NULL,

  movieId   INT          NOT NULL,

  tag       VARCHAR(255) NOT NULL,

  ts_unix   BIGINT       NOT NULL,

  tag_ts    DATETIME     NOT NULL,

  KEY ix_tags_movie (movieId),

  CONSTRAINT fk_tags_movie FOREIGN KEY (movieId) REFERENCES movies(movieId)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- Links to external IDs

CREATE TABLE links (

  movieId INT      NOT NULL PRIMARY KEY,

  imdbId  INT      NULL,

  tmdbId  INT      NULL,

  CONSTRAINT fk_links_movie FOREIGN KEY (movieId) REFERENCES movies(movieId)

) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;





2) place files into mysql server load path



Create folder portfolio4 inside  MySQL server Uploads folder returned by below query (check it first):



SHOW VARIABLES LIKE 'secure_file_priv';



3)  load files into table

`movies.csv`



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/portfolio4/movies.csv'

INTO TABLE movies

FIELDS TERMINATED BY ',' ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 LINES

(movieId, title, genres);





`ratings.csv`



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/portfolio4/ratings.csv'

INTO TABLE ratings

FIELDS TERMINATED BY ',' ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 LINES

(userId, movieId, rating, @ts)

SET

  ts_unix   = @ts,

  rating_ts = FROM_UNIXTIME(@ts);



`tags.csv`



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/portfolio4/tags.csv'

INTO TABLE tags

FIELDS TERMINATED BY ',' ENCLOSED BY '"'

LINES TERMINATED BY '\n'

IGNORE 1 LINES

(userId, movieId, tag, @ts)

SET

  ts_unix = @ts,

  tag_ts  = FROM_UNIXTIME(@ts);





`links.csv`



LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/portfolio4/links.csv'

INTO TABLE links

FIELDS TERMINATED BY ',' ENCLOSED BY '"'

LINES TERMINATED BY '\r\n'            -- use '\n' if your file is LF

IGNORE 1 LINES

(movieId, @imdbId, @tmdbId)

SET

  imdbId = NULLIF(TRIM(@imdbId), ''),

  tmdbId = NULLIF(NULLIF(TRIM(@tmdbId), ''), '\N');   -- handles blank OR \N







4) Quick sanity checks

-- Counts

use movielens;

SELECT COUNT(*) FROM movies;

SELECT COUNT(*) FROM ratings;

SELECT COUNT(*) FROM tags;

SELECT COUNT(*) FROM links;



-- Sample join

SELECT m.title, r.rating, r.rating_ts

FROM ratings r

JOIN movies m USING (movieId)

ORDER BY r.rating_ts DESC

LIMIT 10;
