.mode tabs

select
	 bud.Year
	,DecCPI                 :      cnv.Dec               
	,InflAdjNatlMedianWage  : cast(cnv.AwiMedian   * cnv.Inflation as bigint)

	,InflAdjLocalMedianWage : cast(cnv.AgiMedian   * cnv.Inflation as bigint)
	,pop.Population

	,MedianSFTax            :      cnv.MedianSFTax
	,InflAdjMedSFTax        : cast(cnv.MedianSFTax * cnv.Inflation as bigint)

	,MedianMFTax            :      cnv.MedianMFTax
	,InflAdjMedMFTax        : cast(cnv.MedianMFTax * cnv.Inflation as bigint)

	,LevyCityTotal          :      cnv.LevyCityTotal
	,LevyOverlyingTotal     :      cnv.LevyOverlyingTotal
	,LevyGrandTotal         :      cnv.LevyGrandTotal
	,LevyCityPct            : cast(cnv.LevyCityTotal * 100 / cnv.LevyGrandTotal as decimal(6,3))

	,InflAdjCityPerCapita   : cast(per.CityPerCap    * cnv.Inflation as bigint)
	,InflAdjCityPerCapitaVRF: cast(per.CityPerCapVRF * cnv.Inflation as bigint)

	,SFTaxToNatlMedianWage  : cast(cnv.MedianSFTax   * 100 / cnv.AwiMedian as decimal(6,3))
	,SFTaxToLocalMedianWage : cast(cnv.MedianSFTax   * 100 / cnv.AgiMedian as decimal(6,3))

	,PerCapToNatlMedianWage : cast(per.CityPerCap    * 100 / cnv.AwiMedian as decimal(6,3))
	,PerCapToLocalMedianWage: cast(per.CityPerCapVRF * 100 / cnv.AgiMedian as decimal(6,3))

from           MuniBudget_View    bud
     left join CPI                cpi on cpi.Year = bud.Year
     left join AWI                awi on awi.Year = bud.Year
     left join MuniAgi            agi on agi.Year = bud.Year and agi.MuniCode = bud.MuniCode
     left join lateral (select * from CPI cur where cur.Dec is not null order by Year desc limit 1) cur on true
     -- population is estimate on Jan 1.  So, e.g., 2024 population estimate should be used for 2023 budget because it's paid in Dec 2023/Jan 2024
     left join lateral (select * from MuniPop pop where pop.Year = bud.Year+1 and pop.MuniCode = bud.MuniCode order by IsCensus desc limit 1) pop on true
    ,lateral (
	select
		 Dec               :      nullif(cpi.Dec               ,0)
		,AwiMedian         : cast(nullif(awi.AwiMedian         ,0) as bigint)
		,AgiMedian         : cast(nullif(agi.AgiMedian         ,0) as bigint)
		,MedianSFTax       : cast(nullif(bud.MedianSFTax       ,0) as bigint)
		,MedianMFTax       : cast(nullif(bud.MedianMFTax       ,0) as bigint)
		,LevyCityTotal     : cast(nullif(bud.LevyCityTotal     ,0) as bigint)
		,OperatingTotal    : cast(nullif(bud.OperatingTotal    ,0) as bigint)
		,LevyOverlyingTotal: cast(nullif(bud.LevyOverlyingTotal,0) as bigint)
		,LevyGrandTotal    : cast(nullif(bud.LevyGrandTotal    ,0) as bigint)
		,Inflation         : cur.Dec / cpi.Dec
     ) cnv
    ,lateral (
	select
		 CityPerCap   :  cnv.OperatingTotal        / pop.Population
		,CityPerCapVRF: (cnv.OperatingTotal + 1e6) / pop.Population
     ) per

where bud.MuniCode = 13225 -- Fitchburg
order by bud.Year
;
