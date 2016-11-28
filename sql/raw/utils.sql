-- liste des vtt des episodes d'une serie
select "Captions"."videoId", "Videos"."encodingId", "Captions"."src", "Seasons"."seasonNumber", "Episodes"."episodeNumber"
from "Captions"
inner join "Videos" on "Videos"."_id" = "Captions"."videoId"
inner join "Episodes" on "Episodes"."videoId" = "Captions"."videoId"
inner join "Seasons" on "Seasons"."_id" = "Episodes"."seasonId" and "Seasons"."movieId" = 316
order by "Seasons"."seasonNumber" asc, "Episodes"."episodeNumber" asc
