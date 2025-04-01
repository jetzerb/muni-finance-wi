.mode tabs

select
	 bud.Year
	,DecCPI                 : cpi.Dec
	,InflAdjNatlMedianWage  : cast(awi.AwiMedian          * cur.Dec / cpi.Dec as bigint)

	,InflAdjLocalMedianWage : cast(agi.AgiMedian          * cur.Dec / cpi.Dec as bigint)
	,pop.Population

	,MedianSFTax            : cast(bud.MedianSFTax                            as bigint)
	,InflAdjMedSFTax        : cast(bud.MedianSFTax        * cur.Dec / cpi.Dec as bigint)

	,MedianMFTax            : cast(bud.MedianMFTax                            as bigint)
	,InflAdjMedMFTax        : cast(bud.MedianMFTax        * cur.Dec / cpi.Dec as bigint)

	,LevyCityTotal          : cast(bud.LevyCityTotal                          as bigint)
	,LevyOverlyingTotal     : cast(bud.LevyOverlyingTotal                     as bigint)
	,LevyGrandTotal         : cast(bud.LevyGrandTotal                         as bigint)
	,LevyCityPct            : cast(bud.LevyCityTotal      * 100 / nullif(bud.LevyGrandTotal,0) as decimal(5,1))

	,InflAdjCityPerCapita   : cast(bud.LevyCityTotal / pop.Population * cur.Dec / cpi.Dec as bigint)
	,InflAdjCityPerCapitaVRF: cast((bud.LevyCityTotal + 1e6) / pop.Population * cur.Dec / cpi.Dec as bigint)

from           MuniBudget_View    bud
     left join CPI                cpi on cpi.Year = bud.Year
     left join AWI                awi on awi.Year = bud.Year
     left join MuniAgi            agi on agi.Year = bud.Year and agi.MuniCode = bud.MuniCode
     left join lateral (select * from CPI cur where cur.Dec is not null order by Year desc limit 1) cur on true
     left join lateral (select * from MuniPop pop where pop.Year = bud.Year+1 and pop.MuniCode = bud.MuniCode order by IsCensus desc limit 1) pop on true

where bud.MuniCode = 13225 -- Fitchburg
order by bud.Year
;

