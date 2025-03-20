/*
	Show shared revenue information for each year in each municipality
*/
create or replace view SharedRevenue_View
as
select
	 rev.Year
	,rev.MuniCode
	,mun.MuniName
	,pop.Population
	,rev.TotalAid
	,cast(rev.TotalAid / nullif(pop.Population,0) as decimal(17,2)) PerCapita
	,agi.AgiMedian PriorYearMedianAgi
from
	          SharedRevenue rev
	left join Municipality  mun on mun.MuniCode = rev.MuniCode
	left join MuniAgi       agi on agi.MuniCode = rev.MuniCode and agi.Year = rev.Year - 1
	,lateral (
		select *
		from MuniPop pop
		where pop.MuniCode = rev.MuniCode
		  and pop.Year     = rev.Year
		order by pop.IsCensus desc
		limit 1) pop
;
