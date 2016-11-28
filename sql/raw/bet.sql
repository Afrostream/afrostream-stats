-- stats BET
select "foo"."videoId", "foo"."nbVues", "Movies"."title" as "movieTitle", "E"."title" as "episodeTitle",
"E"."seasonTitle" as "seasonTitle", "E"."episodeNumber", "E"."seasonNumber",
"E"."episodeDateFrom", "E"."episodeDateTo",
"Movies"."dateFrom", "Movies"."dateTo"

from (
	select "UsersVideos"."videoId", count("UsersVideos"."videoId") as "nbVues" from "UsersVideos"
	where "UsersVideos"."videoId" IN 
	(
		select "Movies"."videoId" from "Movies" where "catchupProviderId" = 1 and "type" = 'movie'
		UNION
		select "Episodes"."videoId" from "Episodes" where "catchupProviderId" = 1
	) AND
	"UsersVideos"."dateStartRead" > '2016-03-01 00:00:00+00'
	group by "UsersVideos"."videoId"
	order by "nbVues" desc
) as foo
left join "Movies" on "foo"."videoId" = "Movies"."videoId"
left join (
 select "Episodes"."videoId", "Episodes"."title", "Seasons"."title" as "seasonTitle",
   "Episodes"."episodeNumber", "Seasons"."seasonNumber",
   "Episodes"."dateFrom" as "episodeDateFrom",
   "Episodes"."dateTo" as "episodeDateTo"
 from "Episodes" inner join "Seasons" ON "Episodes"."seasonId" = "Seasons"."_id"
) as "E" on "foo"."videoId" = "E"."videoId"