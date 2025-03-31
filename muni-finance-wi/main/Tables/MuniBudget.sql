-- Municipality Budget
create table MuniBudget
(
	-- City operating budget
	 MuniCode              char( 5)
	,Year                   int
	,LevyGeneral        decimal(17,2)
	,LevyTransit        decimal(17,2)
	,LevyLibrary        decimal(17,2)
	,LevyDebt           decimal(17,2)
	,LevyCapital        decimal(17,2)
	,LevyTID            decimal(17,2)
	,LevyCityOther      decimal(17,2) -- any other city-related collections

	-- Pass-throughs to other jurisdictions
	,LevySchool1        decimal(17,2)
	,LevySchool2        decimal(17,2)
	,LevySchool3        decimal(17,2)
	,LevyTechCollege    decimal(17,2)
	,LevyCounty         decimal(17,2)
	,LevyOverlyingOther decimal(17,2)

	-- Valuation and per unit stats
	,AssessedValue      decimal(17,2)
	,EqualizedValue     decimal(17,2)
	,MedianSFAssessed   decimal(17,2)
	,MedianMFAssessed   decimal(17,2)
	,MedianSFTax        decimal(17,2)
	,MedianMFTax        decimal(17,2)

	,constraint MuniBudget_PK primary key (MuniCode,Year)
);
