#!/bin/bash

# if [[ $1 = "" || $2 = "" ]]; then
if [[ $1 = "" ]]; then
  echo "Please execute like this.
$0 new_project_name"
  exit 1
fi

NEW_NAME=$1

for file in *.pro
do
  OLD_NAME=${file/.pro/}
done

echo rename $OLD_NAME as $NEW_NAME
FILES=`find . -type f -not -iwholename '*.git/*' | grep $OLD_NAME`
for file in $FILES
do
  toFile=${file/$OLD_NAME/$NEW_NAME}
  mv $file $toFile
  echo moved $file as $toFile
done
echo replace $OLD_NAME as $NEW_NAME in these files
FILES=`find . -type f -not -iwholename '*.git/*' | xargs egrep -lir $OLD_NAME`
for file in $FILES
do
  echo $file
  sed -i -e "s/${OLD_NAME}/${NEW_NAME}/g" $file
done
