/*
	Reproduce the data from https://www.ssa.gov/OACT/COLA/central.html
*/
create or replace view AWI_View
as
select
	 Year

	,AwiMean
	,AwiMeanAnnualPct:   cast(AwiMean   * 100.0 /         lag(AwiMean)   over (order by Year) - 100 as decimal(7,3))
	,AwiMeanCumPct:      cast(AwiMean   * 100.0 / first_value(AwiMean)   over (order by Year) - 100 as decimal(7,3))

	,AwiMedian
	,AwiMedianAnnualPct: cast(AwiMedian * 100.0 /         lag(AwiMedian) over (order by Year) - 100 as decimal(7,3))
	,AwiMedianCumPct:    cast(AwiMedian * 100.0 / first_value(AwiMedian) over (order by Year) - 100 as decimal(7,3))

	,MedianToMean:       cast(AwiMedian * 100.0 / AwiMean as decimal(7,3))

from
	AWI
;
