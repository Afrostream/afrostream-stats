-- circonvolutions
select "c", "o", "Users"."email" FROM
(
	select "c", CASE WHEN "o" ~ E'^\\d+$' THEN "o"::integer ELSE 0 END as "o" FROM
	(
		select "c", REPLACE("o",'"', '') as "o" from
		(
			select count("createdAt") as "c", "o"::TEXT from
			(select "createdAt", "data"::json->'userId'::text as "o" from "LogsPixel") as foo
			where "o" is not null
			group by "o"::TEXT
			order by "c" DESC
		) as "bar"
	) as "arf"
) as "iii"
inner join "Users" on "Users"."_id" = "o"
where "o" <> 0;
