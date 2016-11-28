select * from "Logs" limit 1
select distinct type from "Logs"

select count("userId"), to_char("createdAt", 'YYYY-MM-DD') as d from "Logs" where "type" = 'read-video'
group by "d"
order by "d"

select count("userId") , "d" from (
	select * from (
		select "userId", to_char("createdAt", 'YYYY-MM-DD') as d from "Logs" where "type" = 'read-video'
		) as foo
	group by "userId", "d"
) as bar
group by "d"
order by "d"


select _id, d from (
	select _id, to_char("createdAt", 'YYYY-MM-DD') as d
	from "Users"
	where "ise2" is not null
	) as foo
where d = '2016-08-26'
order by _id asc;

select "createdAt" from "Users" where "_id" = '131067' -- "2016-08-26 18:01:41+00"

select  to_char("createdAt", 'YYYY-MM-DD') as d , count("_id") from "Users"
where "ise2" is not null
group by "d"
order by "d"
