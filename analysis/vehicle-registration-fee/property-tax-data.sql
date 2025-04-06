.mode tabs

select
	 bud.Year
	,DecCPI                     :      cln.Dec
	,NatlMedianWage             : cast(cln.AwiMedian                   as bigint)
	,InflAdjNatlMedianWage      : cast(cln.AwiMedian   * cln.Inflation as bigint)

	,LocalMedianWage            : cast(cln.AgiMedian                   as bigint)
	,InflAdjLocalMedianWage     : cast(cln.AgiMedian   * cln.Inflation as bigint)
	,pop.Population
	,bud.AssessedValue
	,bud.EqualizedValue

	,MedianSFAssessedK          :      cln.MedianSFAssessedK
	,MedianSFTax                :      cln.MedianSFTax
	,InflAdjMedSFTax            : cast(cln.MedianSFTax * cln.Inflation as bigint)

	,MedianMFAssessedK          :      cln.MedianMFAssessedK
	,MedianMFTax                :      cln.MedianMFTax
	,InflAdjMedMFTax            : cast(cln.MedianMFTax * cln.Inflation as bigint)

	,LevyCityTotal              :      cln.LevyCityTotal
	,LevyOverlyingTotal         :      cln.LevyOverlyingTotal
	,LevyGrandTotal             :      cln.LevyGrandTotal
	,LevyCityPct                : cast( cln.LevyCityTotal        * 100 / cln.LevyGrandTotal as decimal(6,3))
	,LevyCityPctVRF             : cast((cln.LevyCityTotal + 1e6) * 100 / cln.LevyGrandTotal as decimal(6,3))

	,CityPerCapita              :      cnv.CityPerCap
	,InflAdjCityPerCapita       : cast(cnv.CityPerCap    * cln.Inflation as bigint)
	,InflAdjCityPerCapitaVRF    : cast(cnv.CityPerCapVRF * cln.Inflation as bigint)

	,SFTaxToNatlMedianWage      : cast(cln.MedianSFTax    * 100 / cln.AwiMedian as decimal(6,3))
	,SFTaxToNatlMedianWageVRF   : cast(cnv.MedianSFTaxVRF * 100 / cln.AwiMedian as decimal(6,3))
	,SFTaxToLocalMedianWage     : cast(cln.MedianSFTax    * 100 / cln.AgiMedian as decimal(6,3))
	,SFTaxToLocalMedianWageVRF  : cast(cnv.MedianSFTaxVRF * 100 / cln.AgiMedian as decimal(6,3))

	,PerCapToNatlMedianWage     : cast(cnv.CityPerCap     * 100 / cln.AwiMedian as decimal(6,3))
	,PerCapToNatlMedianWageVRF  : cast(cnv.CityPerCapVRF  * 100 / cln.AwiMedian as decimal(6,3))
	,PerCapToLocalMedianWage    : cast(cnv.CityPerCap     * 100 / cln.AgiMedian as decimal(6,3))
	,PerCapToLocalMedianWageVRF : cast(cnv.CityPerCapVRF  * 100 / cln.AgiMedian as decimal(6,3))

from           MuniBudget_View    bud
     left join CPI                cpi on cpi.Year = bud.Year
     left join AWI                awi on awi.Year = bud.Year
     left join MuniAgi            agi on agi.Year = bud.Year and agi.MuniCode = bud.MuniCode
     left join lateral (select * from CPI cur where cur.Dec is not null order by Year desc limit 1) cur on true
     -- population is estimate on Jan 1.  So, e.g., 2024 population estimate should be used for 2023 budget because it's paid in Dec 2023/Jan 2024
     left join lateral (select * from MuniPop pop where pop.Year = bud.Year+1 and pop.MuniCode = bud.MuniCode order by IsCensus desc limit 1) pop on true
    ,lateral (
	select
		 Dec               :      nullif(cpi.Dec                    ,0)
		,AwiMedian         : cast(nullif(awi.AwiMedian              ,0) as bigint)
		,AgiMedian         : cast(nullif(agi.AgiMedian              ,0) as bigint)
		,MedianSFAssessedK : cast(nullif(bud.MedianSFAssessed / 1000,0) as bigint)
		,MedianSFTax       : cast(nullif(bud.MedianSFTax            ,0) as bigint)
		,MedianMFAssessedK : cast(nullif(bud.MedianMFAssessed / 1000,0) as bigint)
		,MedianMFTax       : cast(nullif(bud.MedianMFTax            ,0) as bigint)
		,LevyCityTotal     : cast(nullif(bud.LevyCityTotal          ,0) as bigint)
		,OperatingTotal    : cast(nullif(bud.OperatingTotal         ,0) as bigint)
		,LevyOverlyingTotal: cast(nullif(bud.LevyOverlyingTotal     ,0) as bigint)
		,LevyGrandTotal    : cast(nullif(bud.LevyGrandTotal         ,0) as bigint)
		,Inflation         : cur.Dec / cpi.Dec
     ) cln
    ,lateral (
	select
		 CityPerCap     :  cln.OperatingTotal        / pop.Population
		,CityPerCapVRF  : (cln.OperatingTotal + 1e6) / pop.Population
		,MedianSFTaxVRF : cln.MedianSFTax + 40*2
     ) cnv

where bud.MuniCode = 13225 -- Fitchburg
order by bud.Year
;
