#!/bin/bash
dir="/tmp/old"
backupdir="/tmp/backup"


now="$(date +'%d-%m-%Y-%T')"
# Build urls
url="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/jhu/COVID-19%20-%20Johns%20Hopkins%20University.csv"
url1="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/jhu/biweekly_cases.csv"
url2="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/jhu/biweekly_cases_per_million.csv"
url3="https://github.com/owid/covid-19-data/blob/master/public/data/jhu/biweekly_deaths.csv"
file="COVID-19 - Johns Hopkins University.csv".$now
file1="biweekly_cases.csv".$now
file2="biweekly_cases_per_million.csv".$now
file3="biweekly_deaths.csv".$now

### Check for dir, if not found create it using the mkdir ##
[ ! -d "$dir" ] && mkdir -p "$dir"
[ ! -d "$backupdir" ] && mkdir -p "$backupdir"


# Now download it
wget -qc "$url" -O "${dir}/${file}"
wget -qc "$url1" -O "${dir}/${file1}"
wget -qc "$url2" -O "${dir}/${file2}"
wget -qc "$url3" -O "${dir}/${file3}"


printf "New Directory '${dir}' recent files downloaded are below\n"
ls -Art ${dir} 

# Move the file which are three days old

find ${dir} -mtime +3 -exec mv "{}" ${backupdir};

printf "Ending script"
