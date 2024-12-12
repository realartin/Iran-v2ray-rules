#!/bin/bash

gh api https://api.github.com/repos/MasterKia/PersianBlocker/contents/PersianBlockerHosts.txt -H "Accept: application/vnd.github.raw" | sed -e 's/^\(|\|\*\|\.\|\-\|0\.0\.0\.0\|127\.0\.0\.1\)*//g' -e 's/\^.*$//g' -e '/!\|?\|@\|#\|\*\|_\|\\\|\/\|\[\|]\|\[\|\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/d' -e '/\.$/d' -e '/^\s*$/d' | awk '{$1=$1};1' | dos2unix | idn2 --no-alabelroundtrip --no-tr46 | LC_ALL=C sort -u > ads.txt
gh api https://api.github.com/repos/MasterKia/PersianBlocker/contents/PersianBlockerHosts.txt -H "Accept: application/vnd.github.raw" > category-ads-all-raw.txt
gh api https://api.github.com/repos/hagezi/dns-blocklists/contents/wildcard/light-onlydomains.txt -H "Accept: application/vnd.github.raw" >> category-ads-all-raw.txt
gh api https://api.github.com/repos/jerryn70/GoodbyeAds/contents/Extension/GoodbyeAds-Samsung-AdBlock.txt -H "Accept: application/vnd.github.raw" >> category-ads-all-raw.txt
gh api https://api.github.com/repos/jerryn70/GoodbyeAds/contents/Extension/GoodbyeAds-Xiaomi-Extension.txt -H "Accept: application/vnd.github.raw" >> category-ads-all-raw.txt
# List of URLs to download
urls=(
  "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
  "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
  "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
  "https://v.firebog.net/hosts/Prigent-Crypto.txt"
  "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
  "https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt"
  "https://phishing.army/download/phishing_army_blocklist_extended.txt"
  "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt"
  "https://v.firebog.net/hosts/RPiList-Malware.txt"
  "https://v.firebog.net/hosts/RPiList-Phishing.txt"
  "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt"
  "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts"
  "https://urlhaus.abuse.ch/downloads/hostfile/"
  "https://v.firebog.net/hosts/Easyprivacy.txt"
  "https://v.firebog.net/hosts/Prigent-Ads.txt"
  "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
  "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
  "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
  "https://adaway.org/hosts.txt"
  "https://v.firebog.net/hosts/AdguardDNS.txt"
  "https://v.firebog.net/hosts/Admiral.txt"
  "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
  "https://v.firebog.net/hosts/Easylist.txt"
  "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
  "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
  "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
  "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt"
  "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts"
  "https://v.firebog.net/hosts/static/w3kbl.txt"
)

# Downloading each URL, applying cleansing, and appending its content to the category-ads-all-raw.txt file
for url in "${urls[@]}"; do
  curl -s "$url" | \
    sed -e 's/^\(|\|\*\|\.\|\-\|0\.0\.0\.0\|127\.0\.0\.1\|::1\)*//g' \
        -e 's/\^.*$//g' \
        -e '/!\|?\|@\|#\|\*\|_\|\\\|\/\|\[\|]\|\[\|\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/d' \
        -e '/\.$/d' \
        -e '/^\s*$/d' | \
    awk '{$1=$1};1' | dos2unix | idn2 --no-alabelroundtrip --no-tr46 | LC_ALL=C sort -u >> category-ads-all-raw.txt
done

cat category-ads-all-raw.txt | sed -e 's/^\(|\|\*\|\.\|\-\|0\.0\.0\.0\|127\.0\.0\.1\)*//g' -e 's/\^.*$//g' -e '/!\|?\|@\|#\|\*\|_\|\\\|\/\|\[\|]\|\[\|\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/d' -e '/\.$/d' -e '/^\s*$/d' | awk '{$1=$1};1' | dos2unix | idn2 --no-alabelroundtrip --no-tr46 | LC_ALL=C sort -u > category-ads-all-temp.txt

gh api https://api.github.com/repos/AdguardTeam/AdGuardSDNSFilter/contents/Filters/exclusions.txt -H "Accept: application/vnd.github.raw" > whitelist-raw.txt
gh api https://api.github.com/repos/AdguardTeam/AdGuardSDNSFilter/contents/Filters/exceptions.txt -H "Accept: application/vnd.github.raw" >> whitelist-raw.txt

cat whitelist-raw.txt | sed -e 's/^\(|\|@\|\*\|\.\|\-\|0\.0\.0\.0\|127\.0\.0\.1\)*//g' -e 's/\^.*$//g' -e '/!\|?\|@\|#\|\*\|_\|\\\|\/\|\[\|]\|\[\|\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}/d' -e '/\.$/d' -e '/^\s*$/d' | awk '{$1=$1};1' | dos2unix | idn2 --no-alabelroundtrip --no-tr46 | LC_ALL=C sort -u > whitelist-temp.txt

comm -23 category-ads-all-temp.txt whitelist-temp.txt > category-ads-all-temp-temp.txt
sed -e 's/^/\./' -e 's/\./\\./g' -e 's/\-/\\-/g' -e 's/$/\$/' category-ads-all-temp-temp.txt > category-ads-all-sub.txt
cat category-ads-all-temp-temp.txt | LC_ALL=C grep -f category-ads-all-sub.txt | LC_ALL=C sort -u > category-ads-all-redundant-sub.txt
comm -23 category-ads-all-temp-temp.txt category-ads-all-redundant-sub.txt > category-ads-all.txt
rm -f category-ads-all-raw.txt whitelist-raw.txt category-ads-all-temp.txt whitelist-temp.txt
mv ads.txt category-ads-all.txt release
