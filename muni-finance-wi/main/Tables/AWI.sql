-- Average Wage Index
create table AWI
(
	 Year      int
	,AwiMean   decimal(17,2)
	,AwiMedian decimal(17,2)

	,constraint AWI_PK primary key (Year)
);
