#bash diff.sh_mmddyyyy 2>&1 | tee data.txt
#!/bin/sh
COUNT=1
# GETTING HOW MANY LINES IN URL FILE
#STOP=$(wc -l 'text/id.txt' | awk '{ print $1 }')

#CHANGE STOP IN ORDER HOW MANY TOP COIN DATA U WANT HERE TOP 500 SET
STOP=500 #CHANGE ME#
echo "ENTER START DATE in mm/dd/yyyy format"
read var1
st=$(date --date="$var1 00:00:00" +"%s")
echo $st

echo "ENTER END DATE in mm/dd/yyyy format"
read var2
et=$(date --date="$var2 00:00:00" +"%s")
echo $et

while [ $COUNT -le $STOP ]
do
idn=$(sed "$COUNT!d" 'text/id.txt')
nm=$(sed "$COUNT!d" 'text/symbol.txt')
fn=$(sed "$COUNT!d" 'text/name.txt')
fn=$(echo $fn | sed 's/ /-/g')

#USE EPOCH CONVERTOR (1652297400 = GMT: Wednesday, 11 May 2022 19:30:00)
#HERE USED START TIME 12 MAY(1652297400) END TIME 28 JUNE(1656460800)
# CHANGE st et VALUE AS PER WHICH TIME DURATION DATA U WANT. USE THIS SITE TO CONVERT https://www.epochconverter.com/
#START TIME 12 MAY

#st=1652297400  #CHANGE ME# 
#ENDTIME 28 JUNE DAILY CLOSE
#et=1656460800  #CHANGE ME#


curl -s "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/historical?id="$idn"&convertId=2781&timeStart=$st&timeEnd=$et" --output "json/$nm.json"

#GRABBING START DATE(12 MAY) LOWEST VALUE
lw=$(jq -r .data.quotes[0].quote.low "json/$nm.json")
#GRABBING START DATE(12 MAY) HIGHEST VALUE
#lw=$(jq -r .data.quotes[0].quote.high "json/$nm.json")
#GRABBING START DATE(12 MAY) DAILY CLOSE VALUE
#lw=$(jq -r .data.quotes[0].quote.close "json/$nm.json")
#GRABBING START DATE(12 MAY) OPEN VALUE
#lw=$(jq -r .data.quotes[0].quote.open "json/$nm.json")


#GRABBING END DATE(28 JUNE) DAILY CLOSE VALUE
cl=$(jq -r '.data.quotes[-1].quote.close' "json/$nm.json")
#GRABBING END DATE(28 JUNE) HIGHEST VALUE
#cl=$(jq -r .data.quotes[-1].quote.high "json/$nm.json")
#GRABBING END DATE(28 JUNE) DAILY CLOSE VALUE
#cl=$(jq -r .data.quotes[-1].quote.close "json/$nm.json")
#GRABBING END DATE(28 JUNE) OPEN VALUE
#cl=$(jq -r .data.quotes[-1].quote.open "json/$nm.json")

#CACULATE DIFF OF START DATE LOW TO END DATE DAILY CLOSE IN PERCENTAGE
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
#TO PREVENT ABUSE TO API USE DELAY
sleep 2
COUNT=$(($COUNT+1))
done
