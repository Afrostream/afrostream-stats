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