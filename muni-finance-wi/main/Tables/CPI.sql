-- Consumer Price Index
create table CPI
(
	 Year      int
	,Jan       decimal(12,3)
	,Feb       decimal(12,3)
	,Mar       decimal(12,3)
	,Apr       decimal(12,3)
	,May       decimal(12,3)
	,Jun       decimal(12,3)
	,Jul       decimal(12,3)
	,Aug       decimal(12,3)
	,Sep       decimal(12,3)
	,Oct       decimal(12,3)
	,Nov       decimal(12,3)
	,Dec       decimal(12,3)
	,YearAvg   decimal(12,3)
	,DecDecPct decimal(12,3)
	,AvgAvgPct decimal(12,3)

	,constraint CPI_PK primary key (Year)
);
