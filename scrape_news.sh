bin/bash/!#
wget https://www.ynetnews.com/category/3082
grep -o -E  ""https:\/\/www\.ynetnews\.com\/article\/[a-zA-Z0-9]+"" 3082 > temp.txt
sort -u temp.txt >list.txt
wget -P /home/mamat/URLS -i list.txt
cd URLS
for FILE in *;do grep -o -E  'Netanyahu' $FILE  |wc -l;done >/home/mamat/Bibi_Results.txt
for FILE in *;do grep -o -E  'Gantz' $FILE  |wc -l;done >/home/mamat/Gantz_Results.txt
cd ~
awk 'NR==1{a="Netanyahu,"}{print a,$0}' Bibi_Results.txt > Ver2_Bibi.txt
awk 'NR==1{a="Gantz,"}{print a,$0}' Gantz_Results.txt > Ver2_Gantz.txt
paste Ver2_Bibi.txt Ver2_Gantz.txt|sed 's/\t/ /' > Ver2_Results.txt
paste list.txt Ver2_Results.txt|sed 's/\t/ /'>Ver2_Results_Http.txt
awk '$3=$3","' Ver2_Results_Http.txt>Ver3_Results_Http.txt
awk '$1=$1","' Ver3_Results_Http.txt>Ver4_Results_Http.txt
awk 'BEGIN {OFS=FS=" "} {if ($3 =="0," && $5 =="0")sub("Netanyahu,","-",$2)sub("0,","",$3)sub("Gantz,","",$4)sub("0","",$5); print}' Ver4_Results_Http.txt>results.csv
cd URLS
ls |wc -l > /home/mamat/temp.txt
cd ~
echo "$(cat temp.txt results.csv)" > results.csv
rm *.txt
