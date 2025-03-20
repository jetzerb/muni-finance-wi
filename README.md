# Wisconsin Municipality Financial Database

A [DuckDB](https://duckdb.org) database holding various bits of publicly
available datasets, so that they can be joined and queried at the same time.


## Datasets
Initial motivation was for the ability to query shared revenue (Dept of Revenue)
per resident (Dept of Admin), along with the median Adjusted Gross Income (Dept
of Revenue) in each municipality.

### Municipality Identifier Disagreement
WI has 72 counties.  71 of them were created between 1818 and 1901 (though Gates
we renamed to Rusk in 1905).
Apparently, government departments gave them numeric identifiers based on
alphabetical order sometime after 1905.
Then, in 1959, the Menominee Indian Reservation was recognized as a county.

The Dept of Admin inserted Menominee alphabetically and incremented all
subsequent counties by 1.

The Dept of Revenue added Menominee to the end with ID 72. The following table
illustrates the differences:

+-----+-----+-----------+
| DOR | DOA |  County   |
+-----+-----+-----------+
| ... | ... | ...       |
| 37  | 37  | Marathon  |
| 38  | 38  | Marinette |
| 39  | 39  | Marquette |
| 40  | 41  | Milwaukee |
| 41  | 42  | Monroe    |
| 42  | 43  | Oconto    |
| 43  | 44  | Oneida    |
| ... | ... | ...       |
| 70  | 71  | Winnebago |
| 71  | 72  | Wood      |
| 72  | 40  | Menominee |
+-----+-----+-----------+

Because the initial datasets consisted of two from the DOR and one from the DOA,
the DOR identifier is `MuniCode` everywhere, and in the `Municipality` table,
there is a second column `DoaCode` which is also a unique identifier.
