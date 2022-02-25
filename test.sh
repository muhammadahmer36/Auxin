#!/bin/bash
dir="/tmp/old"
newdir="/tmp/new"
three="3"

now="$(date +'%d-%m-%Y-%T')"
# Build urls
url="https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.csv"
file="owid-covid-data.csv".$now 
### Check for dir, if not found create it using the mkdir ##
[ ! -d "$dir" ] && mkdir -p "$dir"
 
# Now download it
wget -qc "$url" -O "${dir}/${file}"


printf "New Directory '${dir}' recent files downloaded are below\n"
ls -Art ${dir} | tail -n 5

cd ${dir}
count=$(ls | wc -l)
printf "Downloaded files count is ::-> ${count} \n\n"

if [[ "${count}" -ge "${three}" ]]
then

check="1"
printf "Moving Recent three files into New directory ${newdir} \n\n"
mv `ls -Art ${dir} | tail -n 3` ${newdir}

fi



if [[ "${check}"  -eq  "1" ]]
then
printf "Deleting all files into old directory ${dir}\n\n"

cd ${dir}
rm -rf *.*
fi

printf "Ending script"
