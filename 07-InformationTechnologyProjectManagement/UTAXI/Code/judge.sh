#!/bin/bash
#a blind captian, a whispered portent, an infirm navigator
#so let the dance be eternal

RED="\e[0;31m"
GREEN="\e[0;32m"
ESC="\e[0m"

ERROR="${RED}ERROR:${ESC}"
OUTPUT="utaxi.out"
LOCATIONS="locations.csv"
NULL_DEVICE=/dev/null

make > $NULL_DEVICE

if [ $? -eq 1 ];
then 
    echo -e "${ERROR} compilation failed."
    exit
elif [ ! -f "${LOCATIONS}" ];
then
    echo -e "${ERROR} locations not found"
    exit
elif [ ! -f "${OUTPUT}" ];
then 
    echo -e "${ERROR} output file not found"
    exit
fi

WRONG_ANSWERS=0
TOTAL_TESTS=$(ls -1q testcaes/in/ | wc -l)

rm testcaes/err/*.err 2> /dev/null

for (( i=1 ; i<=TOTAL_TESTS ; i++ ))
do
    ./$OUTPUT $LOCATIONS < "testcaes/in/$i.in" > "testcaes/out/$i.out"
    cmp -s testcaes/ans/$i.ans testcaes/out/$i.out

    if [ $? -eq 1 ];
    then   
        if [ $WRONG_ANSWERS -eq 0 ];
        then 
            echo -e "${RED}SOME FAILED :(${ESC}"
        fi

        WRONG_ANSWERS=$((WRONG_ANSWERS+1))
        echo "test number $i failed."
        diff testcaes/ans/$i.ans testcaes/out/$i.out > testcaes/err/$i.err
        echo "----------------------------" 
    fi
done

if [ $WRONG_ANSWERS -eq 0 ];
then
    echo -e "${GREEN}ALL PASSED :)${ESC}"
else 
    echo "$WRONG_ANSWERS out of ${TOTAL_TESTS} failed."
fi