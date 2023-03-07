#!/bin/sh
#INSTALL JQ FIRST
sudo apt install jq

rm -rf text
rm -rf json
mkdir text
mkdir json
curl "https://api.coinmarketcap.com/data-api/v3/map/all?listing_status=active%2Cinactive%2Cuntracked&limit=10000&start=1" --output 'json/all.json'
jq -r .data.cryptoCurrencyMap[].id 'json/all.json' > 'text/id.txt'
jq -r .data.cryptoCurrencyMap[].symbol 'json/all.json' > 'text/symbol.txt'
jq -r .data.cryptoCurrencyMap[].name 'json/all.json' > 'text/name.txt'