.mode tabs

select
	 MuniCode
	,MedianAgi : PriorYearMedianAgi / 1000
	,PerCapita
	,MuniName

from SharedRevenue_View
where Year = 2024
;
