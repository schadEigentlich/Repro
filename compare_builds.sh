#!/bin/bash
BINDIFF=$(dirname $0)/bindiff/bindiff

FILES_A=$(find $1 -iname "*.o" -type f)
DIFFS=""
for i in $FILES_A; do
    j=${i/$1/$2}
    if [[ -f "$j" ]]; then
	if ! diff -q "$i" "$j" > /dev/null ; then
            echo "$j"	
            $BINDIFF "$i" "$j"
            DIFFS=$DIFFS$'\n'${i#$1}
	else
	   echo "$j identical"
        fi
    else
        echo "$j does not exist!"
    fi

done
echo "$DIFFS" > diffs-${1%"/"}-${2%"/"}
