select "status"->>'errorList' from "ExportsOSearch" where "status"->>'state' = 'ERROR' limit 10


select count(*) from  "ExportsOSearch" where "status"->>'state' = 'ERROR'
-- 1042 ERROR
-- 772  SUCCESS



-- liste des episodes dont l'export a planté car il manquait pfMd5Hash
select "episodeId", "Videos"."_id", "Videos"."encodingId" from (
select "movieId", "episodeId", "status"::text as "s" from "ExportsOSearch" where "status"->>'state' = 'ERROR'
) as foo
inner join "Episodes" ON "episodeId" = "Episodes"."_id"
inner join "Videos" ON "Videos"."_id" = "Episodes"."videoId"
where s like '%missing pfMd5Hash%' and "episodeId" is not null

