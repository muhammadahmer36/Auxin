#!/bin/bash
dir="/tmp/download"
bkpdir="/tmp/backup"

now="$(date +'%d-%m-%Y-%T')"
# Build urls
url="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv"
file="owid-covid-data.csv".$now
url1="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/jhu/biweekly_cases.csv"
file1="biweekly_cases.csv".$now

url2="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/jhu/biweekly_cases_per_million.csv"
file2="biweekly_cases_per_million.csv".$now

url3="https://github.com/owid/covid-19-data/blob/master/public/data/jhu/biweekly_deaths.csv"
file3="biweekly_deaths.csv".$now




### Check for dir, if not found create it using the mkdir ##
[ ! -d "$dir" ] && mkdir -p "$dir"
[ ! -d "$bkpdir" ] && mkdir -p "$bkpdir"


# Now download it
wget -qc "$url" -O "${dir}/${file}"
wget -qc "$url1" -O "${dir}/${file1}"
wget -qc "$url2" -O "${dir}/${file2}"
wget -qc "$url3" -O "${dir}/${file3}"


printf "New Directory '${dir}' recent files downloaded are below\n"
ls -Art ${dir}

cd ${dir}
count=$(ls | wc -l)
printf "Downloaded files count is ::-> ${count} \n\n"



printf "Checking 3 days old files  '${dir}'  \n"
find $dir -type f -mtime +3 -exec mv "{}" $bkpdir \;

cd ${bkpdir}
countbkp=$(ls | wc -l)

printf "Removing number of files that is old than  3 days count is : ${countbkp} \n\n"
rm -rf *.*

printf "Ending script"
