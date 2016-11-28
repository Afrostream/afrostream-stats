select count("userId") from (select "userId" from "UsersFavoritesEpisodes" group by "userId") as foo
UNION
select count("userId") from (select "userId" from "UsersFavoritesMovies" group by "userId") as bar

select count("userId") from (
	select "userId" from (
		select "userId" from "UsersFavoritesEpisodes"
		UNION ALL
		select "userId" from "UsersFavoritesMovies"
	) as niarf
	group by "userId"
) as niarf2
-- 4801 distinct user ayant utilisé les favoris


select count("userId"), avg(nb) from (
	select "userId", sum("c") as nb from (
		select "userId", 1 as c from "UsersFavoritesEpisodes"
		UNION ALL
		select "userId", 1 as c from "UsersFavoritesMovies"
	) as niarf
	group by "userId"
) as niarf2
-- 4801;5.4767756717350552


	select "userId", sum("c") as nb, "Users".email from (
		select "userId", 1 as c from "UsersFavoritesEpisodes"
		UNION ALL
		select "userId", 1 as c from "UsersFavoritesMovies"
	) as niarf
	inner join "Users" ON niarf."userId" = "Users"."_id"
	group by "userId","Users"."email"
	order by nb desc
	limit 10




-- top 10 favoris episodes
select "Episodes"."_id", "Episodes"."title", "Episodes"."episodeNumber", "joined"."nb" from "Episodes"
inner join (
select "episodeId", sum("c") as nb from (
	select "episodeId", 1 as c from "UsersFavoritesEpisodes"
) as niarf
group by "episodeId"
order by "nb" desc
limit 10) as joined ON joined."episodeId" = "Episodes"."_id"
order by "nb" desc