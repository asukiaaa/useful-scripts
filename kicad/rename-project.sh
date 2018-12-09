#!/bin/bash

if [[ $1 = "" || $2 = "" ]]; then
  echo "Please execute like this.
$0 current_project_name new_project_name"
  exit 1
fi

FROM=$1
TO=$2

FILES=`find . -type f -not -iwholename '*.git/*' | grep $FROM`
for file in $FILES
do
  toFile=${file/$FROM/$TO}
  mv $file $toFile
  echo moved $file as $toFile
done
echo replace $FROM as $TO in these files
FILES=`find . -type f -not -iwholename '*.git/*' | xargs egrep -lir $FROM`
for file in $FILES
do
  echo $file
  sed -i -e "s/${FROM}/${TO}/g" $file
done
