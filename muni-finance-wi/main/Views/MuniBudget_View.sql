/*
	Show Municipal Budget information
*/
create or replace view MuniBudget_View
as
select
	 *
	,LevyGrandTotal: cnv.LevyCityTotal + cnv.LevyOverlyingTotal
	,OperatingTotal: cnv.LevyCityTotal + coalesce(InterGovRevenue,0)

from
	 MuniBudget
	,lateral (values (
		   coalesce(LevyGeneral       ,0)
		 + coalesce(LevyTransit       ,0)
		 + coalesce(LevyLibrary       ,0)
		 + coalesce(LevyDebt          ,0)
		 + coalesce(LevyCapital       ,0)
		 + coalesce(LevyTID           ,0)
		 + coalesce(LevyCityOther     ,0)

		,  coalesce(LevySchool1       ,0)
		 + coalesce(LevySchool2       ,0)
		 + coalesce(LevySchool3       ,0)
		 + coalesce(LevyTechCollege   ,0)
		 + coalesce(LevyCounty        ,0)
		 + coalesce(LevyOverlyingOther,0)
	)) cnv(LevyCityTotal, LevyOverlyingTotal)
;
