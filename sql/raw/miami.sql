
select * from "Users" where "email" ilike '%messalhi%'

select count(_id),date from (
select _id, "email",to_char(date_trunc('day', "createdAt"), 'YYYY-MM-DD') as "date" from "Users"
where "bouyguesId" is not null
) as foo
group by "date"
order by "date"
