#!/usr/bin/sh

# extract Patstat data
# create database tables
# insert patstat data
# count patstat data

#grep -o '[^ ]*tls201[^ ]*' patstat-structure.sql

declare -A PATSTATENTRIES
declare -A PATSTATTABLES

#PATSTATENTRIES[tls201]=100

# get all zip files
#ls | grep -i '\.zip'

#zip -r tls201.zip raw/tls201.txt

psql -p 6432 -d patstat < patstat-structure.sql

BASEDIR=$(pwd)

cd raw/

rm *.csv


for FILE in *.zip
do
    echo ${FILE}
    SHORTNAME=${FILE%".zip"}
	INDEX="${SHORTNAME:0:6}"
    unzip ${FILE}
    ROWS=$(wc -l "${SHORTNAME}.csv")
    ROWS=${ROWS%"${SHORTNAME}.csv"}
    #echo ${ROWS}
    #echo ${SHORTNAME}
    #echo ${PATSTATENTRIES[${SHORTNAME}]}
    #remove header line from line counting
    ((PATSTATENTRIES[${INDEX}]=${PATSTATENTRIES[${INDEX}]}+${ROWS}-1))
    TABLENAME=$(grep -o "[^ ]*${INDEX}[^ ]*" ../patstat-structure.sql | head -1)
PATSTATTABLES[${INDEX}]=${TABLENAME}
    echo ${TABLENAME}
	psql -p 6432 -d patstat -c "COPY ${TABLENAME} FROM '${BASEDIR}/raw/${SHORTNAME}.csv' CSV HEADER delimiter ','"
done

echo "checking rows"

echo 

for i in "${!PATSTATTABLES[@]}"
do
	#echo "checking: $i"
	DBROWS=$(psql -p 6432 -d patstat -c "select count(*) from ${PATSTATTABLES[$i]}";)
	DBROWS=$(echo $DBROWS | grep -o '[0-9]*' | head -1)
	echo "${i}: rows in db: ${DBROWS} - in csv ${PATSTATENTRIES[${i}]}"
done
