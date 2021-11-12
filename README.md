# Import patstat data into postgres

This script creates the database structure, unpacks the files automatically and then inserts them into the database.

In the end, the script compares the rows in the database and in the csv files, to make sure all rows got inserted.

The script assumes, that the database used is named `patstat` and owned by a user named `patstat`. It is tested with postgres 13 and the `PATSTAT 2021 Autumn edition`


## TODO

* connection parameters are hardcoded

## Datasource

* https://www.epo.org
* https://forums.epo.org/patstat-2021-autumn-edition-ready-for-download-11244
