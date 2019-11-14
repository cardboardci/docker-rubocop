#!/bin/bash
set -e

# Emit the current versions
echo "Current versions"
cat provision/gemlist

mv provision/gemlist provision/gemlist.bak
touch provision/gemlist
while read line; do
    echo "Working with ${line}"
    input=(${line//:/ })
    echo "Determining version for ${input}"
    version=$(gem list "^${input}$" -r | grep -o '\((.*)\)$' | tr -d '() ' | tr ',' "\n")
    echo "Found version as ${version}"
    echo "${input}:${version}" >> provision/gemlist
done <provision/gemlist.bak

#
rm provision/gemlist.bak
cat provision/gemlist