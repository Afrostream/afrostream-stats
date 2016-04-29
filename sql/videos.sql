-- liste de videos (encodingId) rattachées a un episode ou une movie
select distinct "encodingId" from (
(select "Videos"."encodingId" from "Videos"
 inner join "Episodes" on "Videos"."_id" = "Episodes"."videoId")
union
(select "Videos"."encodingId" from "Videos"
 inner join "Movies" on "Videos"."_id" = "Movies"."videoId")
) as bar
where "encodingId" is not null

-- liste de videos (encodingId) ayant 1 (unique) sous titre
select "foo"."encodingId" from (
	select "Videos"."encodingId", count("Captions"."_id") as "c" from "Videos"
	inner join "Captions" on "Captions"."videoId" = "Videos"."_id"
	where
	"encodingId" in (
	  select distinct("encodingId") from "Videos" where "encodingId" is not null
	)
	and
	"encodingId" in (
	  select distinct "encodingId" from (
	   (select "Videos"."encodingId" from "Videos"
	    inner join "Episodes" on "Videos"."_id" = "Episodes"."videoId")
	    union
	   (select "Videos"."encodingId" from "Videos"
	    inner join "Movies" on "Videos"."_id" = "Movies"."videoId")
	   ) as bar
	   where "encodingId" is not null
	)
	group by "Videos"."encodingId"
	) as foo
where c = 1
