-- Municipality
/*
	Note: DOA and DOR "mostly" use the same identifiers for municipalities.
	IDs are 2 digit county ID (alphabetical order) plus 3 digit municipality id.
	Menonimee county was created in 1959, after the other 71 counties were established.
	Alphabetically it falls 40th in line.
	DOA inserted it using 40 as the county identifier. incrementing all subsequent county IDs by 1
	DOR added it to the end of the list, giving it ID 72.

	Since most of the data comes from the DOR, we'll use that as "MuniCode",
	and explicitly label the DOA's ID separately.
*/
create table Municipality
(
	 MuniCode    char( 5) -- Converted ID to match Dept of Revenue
	,DoaCode     char( 5) -- from the DOA files
	,FIPS        char(10) -- 2 digit State, 3 digit County, 5 digit Locality
	,County   varchar(30)
	,MuniType varchar(10)
	,MuniName varchar(30)

	,constraint Municipality_PK primary key (MuniCode)
);
create unique index Municipality_DoaCode on Municipality(DoaCode);
