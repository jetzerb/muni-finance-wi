-- Population by Year
create table MuniPop
(
	 MuniCode   char( 5)
	,Year        int
	,Population  int
	,IsCensus   bool

	,constraint MuniPop_PK primary key (MuniCode,Year,IsCensus)
);
