-- Shared Revenue
create table SharedRevenue
(
	 MuniCode            char( 5)
	,Year                 int
	,MuniName         varchar(30)
	,CountyMuniAid    decimal(17,2)
	,SupplementalAid  decimal(17,2)
	,UtilityAid       decimal(17,2)
	,ErpAid           decimal(17,2)
	,TotalAid         decimal(17,2)
	,JulyPayment      decimal(17,2)
	,RevisedPreRecast decimal(17,2)
	,PriorYearRecast  decimal(17,2)
	,RevisedFinal     decimal(17,2)

	,constraint SharedRevenue_PK primary key (MuniCode,Year)
);
