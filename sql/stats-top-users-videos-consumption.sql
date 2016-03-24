--
-- sort un top 10 des utilisateurs ayant consommes le plus de videos
--
select "Users".email, "nbVideos", "minDateStartRead" from (
select "userId", count("videoId") as "nbVideos", min("dateStartRead") as "minDateStartRead"
from (
  -- on ellimine les vidéos pas vraiment lues
 select "UsersVideos".*, "Videos".duration from "UsersVideos"
 INNER JOIN "Videos" on "UsersVideos"."videoId" = "Videos"."_id"
 where
   -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
  (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
   -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
   --  FIXME: should be a % of the movie length
  (("Videos"."duration" - "UsersVideos"."playerPosition") < 300)
) as bar
group by "userId" order by "nbVideos" desc limit 10
) as foo
inner join "Users" on foo."userId" = "Users"."_id"







-- nombre de videos lues (19438)
select count(*) from "UsersVideos"
inner join "Videos" on "UsersVideos"."videoId"= "Videos"."_id"
where
	     -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
      (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
       -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
       --  FIXME: should be a % of the movie length
      (("Videos"."duration" - "UsersVideos"."playerPosition") < 300) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'

-- nombre d'utilisateurs ayant lue des videos (2236)
select count(distinct "userId") from "UsersVideos"
inner join "Videos" on "UsersVideos"."videoId"= "Videos"."_id"
where
	     -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
      (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
       -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
       --  FIXME: should be a % of the movie length
      (("Videos"."duration" - "UsersVideos"."playerPosition") < 300) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'

-- nombre de video moyenne lues par utilisateur
select avg("nbVideosByUser") from (select count("videoId") as "nbVideosByUser", "userId" from "UsersVideos" group by "userId") as foo

-- combien de videos par utilisateurs
select count("videoId") as "nbVideosByUser", "userId", "Users"."email"
from "UsersVideos" inner join "Users" on "UsersVideos"."userId" = "Users"."_id"
group by "userId", "email"
order by "nbVideosByUser" desc


-- combien d'utilisateurs pour combien de videos
select "nbVideosByUser", count("userId") as "nbUsersByNbVideos"
from (
  select count("videoId") as "nbVideosByUser", "userId"
  from "UsersVideos" inner join "Users" on "UsersVideos"."userId" = "Users"."_id"
  group by "userId"
) as "foo"
group by "nbVideosByUser"
order by "nbVideosByUser" asc;

select sum("nbUsersByNbVideos") from
(
SELECT
       CASE WHEN "nbVideosByUser" <= 5 THEN '0-5'
            WHEN "nbVideosByUser" <= 10 THEN '5-10'
            WHEN "nbVideosByUser" <= 15 THEN '10-15'
            WHEN "nbVideosByUser" <= 20 THEN '15-20'
            WHEN "nbVideosByUser" <= 30 THEN '20-30'
            WHEN "nbVideosByUser" <= 50 THEN '30-50'
            WHEN "nbVideosByUser" <= 75 THEN '50-75'
            WHEN "nbVideosByUser" <= 100 THEN '75-100'
            WHEN "nbVideosByUser" <= 150 THEN '100-150'
            ELSE '>150'
       END as "nbVideosByUserPacked", count("userId") as "nbUsersByNbVideos"
	from (
	  select count("videoId") as "nbVideosByUser", "userId"
	  from "UsersVideos" inner join "Users" on "UsersVideos"."userId" = "Users"."_id"
	  inner join "Videos" on "UsersVideos"."videoId" = "Video"."_id"
	  where
	     -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
      (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
       -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
       --  FIXME: should be a % of the movie length
      (("Videos"."duration" - "UsersVideos"."playerPosition") < 300) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'
	  group by "userId"
	) as "foo"
	group by "nbVideosByUserPacked"
	order by "nbVideosByUserPacked" asc
)
as bar

-- plus ancienne stat : 29 février
select "dateStartRead" from "UsersVideos" order by "dateStartRead" asc limit 1





















SELECT
       CASE WHEN "nbVideosByUser" <= 5 THEN '000-005'
            WHEN "nbVideosByUser" <= 10 THEN '005-010'
            WHEN "nbVideosByUser" <= 15 THEN '010-015'
            WHEN "nbVideosByUser" <= 20 THEN '015-020'
            WHEN "nbVideosByUser" <= 30 THEN '020-030'
            WHEN "nbVideosByUser" <= 50 THEN '030-050'
            WHEN "nbVideosByUser" <= 75 THEN '050-075'
            WHEN "nbVideosByUser" <= 100 THEN '075-100'
            WHEN "nbVideosByUser" <= 150 THEN '100-150'
            ELSE '>150'
       END as "nbVideosByUserPacked", count("userId") as "nbUsersByNbVideos"
	from (
	  select count("videoId") as "nbVideosByUser", "userId"
	  from "UsersVideos"
	  inner join "Users" on "UsersVideos"."userId" = "Users"."_id"
	  inner join "Videos" on "UsersVideos"."videoId"= "Videos"."_id"
	  where
	     -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
      (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
       -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
       --  FIXME: should be a % of the movie length
      (("Videos"."duration" - "UsersVideos"."playerPosition") < 300) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'
	  group by "userId"
	) as "foo"
	group by "nbVideosByUserPacked"
	order by "nbVideosByUserPacked" asc


-- nombre de videos lues (19438)
select count(*) from "UsersVideos"
inner join "Videos" on "UsersVideos"."videoId"= "Videos"."_id"
where
	     -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
      (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
       -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
       --  FIXME: should be a % of the movie length
      ((("Videos"."duration" - "UsersVideos"."playerPosition") < 300) OR "Videos"."duration" is null) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'


-- quelles videos ont une fin qui se termine largement avant la véritable fin... ?
select "Videos"."duration", "UsersVideos"."playerPosition", "UsersVideos"."videoId", "UsersVideos"."userId" from "UsersVideos"
inner join "Videos" on "UsersVideos"."videoId"= "Videos"."_id"
where
      (("Videos"."duration" - "UsersVideos"."playerPosition") > 300) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'

limit 50









select count(distinct "userId") from "UsersVideos"
	inner join "Videos" on "UsersVideos"."videoId"= "Videos"."_id"
where
	     -- supprime les entrees UsersVideos pour lesquelles le temps de lecture < 5 min
      (("dateLastRead" - "dateStartRead") > INTERVAL '5 minute') AND
       -- supprime les entrees UsersVideos pour lesquelles la position de fin de lecture est < 5 min avant la fin du film
       --  FIXME: should be a % of the movie length
      (("Videos"."duration" - "UsersVideos"."playerPosition") < 300) AND
      --
       "dateStartRead" > '2016-03-01 00:00:00+00'