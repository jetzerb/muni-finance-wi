-- Municipal Adjusted Gross Income
create table MuniAgi
(
	 MuniCode        char( 5)
	,Year             int
	,County       varchar(30)
	,MuniName     varchar(30)
	,MuniType     varchar(10)
	,Population       int
	,ReturnCount      int
	,AgiTotal     decimal(17,2)  -- total of all returns
	,AgiMean      decimal(17,2)  -- mean of all returns
	,AgiMedian    decimal(17,2)  -- median of all returns
	,NetTaxTotal  decimal(17,2)  -- tax due before refundable credits included
	,NetTaxMean   decimal(17,2)  -- mean of tax due
	,NetTaxMedian decimal(17,2)  -- median of tax due

	,constraint MuniAgi_PK primary key (MuniCode,Year)
);
