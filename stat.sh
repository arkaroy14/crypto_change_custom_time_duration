#bash diff.sh >> data.txt
echo "ENTER MORE OR LESS THAN HOW MUCH % UP DOWN U WANT TO SEE:"
read var
echo "-------------------------------------------------------------------"
echo "COIN DUMPED MORE THAN $var% FROM MAY 12 BOTTOM SORTED"
echo "-------------------------------------------------------------------"
cat data.txt | grep "DOWN" | LC_ALL=C awk '{if ($6 > '"$var"') print $0}' | sort -r -t" " -nk6
echo "-------------------------------------------------------------------"
echo "COIN PUMPED MORE THAN $var% FROM MAY 12 BOTTOM SORTED"
echo "-------------------------------------------------------------------"
cat data.txt | grep "UP" | LC_ALL=C awk '{if ($6 > '"$var"') print $0}' | sort -r -t" " -nk6
