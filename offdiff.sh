#!/bin/sh
#USEFULL IF JSON DUMPED ALREADY NO NEED TO REQUEST TO API AGAIN
COUNT=1
# GETTING HOW MANY LINES IN URL FILE
#STOP=$(wc -l 'text/id.txt' | awk '{ print $1 }')
#CHANGE DTOP IN ORDER HOW MANY TOP COIN DATA U WANT HERE TOP 500 SET
STOP=500
while [ $COUNT -le $STOP ]
do
idn=$(sed "$COUNT!d" 'text/id.txt')
nm=$(sed "$COUNT!d" 'text/symbol.txt')
fn=$(sed "$COUNT!d" 'text/name.txt')

fn=$(echo $fn | sed 's/ /-/g')

lw=$(jq -r .data.quotes[0].quote.low "json/$nm.json")
cl=$(jq -r '.data.quotes[-1].quote.close' "json/$nm.json")

mn=$(echo "$lw" "$cl" | awk '{print ($1-$2)/$1*100}')
zr=0
if (( $(echo "$mn >= $zr" |bc -l) )); then
echo "$COUNT. $fn($nm) DOWN = - $mn % | FROM $lw to $cl"
echo "-------------------------------------------------------------------"
else
mn=$(echo $mn | sed 's/-//g')
echo "$COUNT. $fn($nm) UP = + $mn % | FROM $lw to $cl"
echo "-------------------------------------------------------------------"
fi
#sleep 5
COUNT=$(($COUNT+1))
done
