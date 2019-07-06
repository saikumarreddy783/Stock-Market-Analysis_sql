create schema Assignment;
use Assignment;
/* 1 QUESTION*/
/*table bajaj1 */ /* and in the same way i have created all six tables*/
create table bajaj1
select Date,`Close Price`,
 avg(`Close Price`) over(rows 19 preceding) as `20 Day MA`,
 avg(`Close Price`) over(rows 49 preceding) as `50 Day MA`
 from (select Date,`Close Price`,
 row_number() over() as day from `bajaj auto` 
 order by day desc)tbl;
 
 create table eicher1
select Date,`Close Price`,
 avg(`Close Price`) over(rows 19 preceding) as `20 Day MA`,
 avg(`Close Price`) over(rows 49 preceding) as `50 Day MA`
 from (select Date,`Close Price`,
 row_number() over() as day from `eicher motors` 
 order by day desc)tbl;
 
 create table hero1
select Date,`Close Price`,
 avg(`Close Price`) over(rows 19 preceding) as `20 Day MA`,
 avg(`Close Price`) over(rows 49 preceding) as `50 Day MA`
 from (select Date,`Close Price`,
 row_number() over() as day from `hero motocorp` 
 order by day desc)tbl;
 
 create table infosys1
select Date,`Close Price`,
 avg(`Close Price`) over(rows 19 preceding) as `20 Day MA`,
 avg(`Close Price`) over(rows 49 preceding) as `50 Day MA`
 from (select Date,`Close Price`,
 row_number() over() as day from `infosys` 
 order by day desc)tbl;
 
 create table tcs1
select Date,`Close Price`,
 avg(`Close Price`) over(rows 19 preceding) as `20 Day MA`,
 avg(`Close Price`) over(rows 49 preceding) as `50 Day MA`
 from (select Date,`Close Price`,
 row_number() over() as day from `tcs` 
 order by day desc)tbl;
 
 create table tvs1
select Date,`Close Price`,
 avg(`Close Price`) over(rows 19 preceding) as `20 Day MA`,
 avg(`Close Price`) over(rows 49 preceding) as `50 Day MA`
 from (select Date,`Close Price`,
 row_number() over() as day from `tvs motors` 
 order by day desc)tbl;
 
/*2.QUESTION  master table*/

select b.`date`,
b.`close price` as `Bajaj`,
t.`close price` as `TCS`,
tv.`close price` as `TVS`,
i.`close price` as `Infosys`,
e.`close price` as `Eicher`,
h.`close price` as `Hero`
from `bajaj auto` b inner join tcs t on b.`date`=t.`date`
inner join `tvs motors` tv on t.`date`=tv.`date`
inner join `Infosys` i on tv.`date`=i.`date`
inner join `eicher motors` e on i.`date`=e.`date`
inner join `hero motocorp` h on e.`date`=h.`date`;
 
 /* 3 OUESTION */
 
create table bajaj2
SELECT Date,
`Close price`,
CASE
WHEN day>49 and `20 Day MA` > `50 Day MA` THEN 'Buy'
WHEN day>49 and `20 Day MA` < `50 Day MA` THEN 'Sell'
ELSE 'Hold'
END as `Signal`
from (select Date,`Close price`,`20 Day MA`,`50 Day MA`,
row_number() over() as day from bajaj1
order by day asc)tbl;


 /* 4 QUESTION */
 
delimiter $$
drop function if exists date_signal $$
create function date_signal(date_info text)
returns char(5) deterministic
begin
	declare sig char(5);
    select `Signal` into sig from bajaj2 where date=date_info;
    return sig;
end $$

 
 
 

