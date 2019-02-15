#!/bin/bash

issues=$(ghi list -s closed|grep 'For [JFMAJSOND].*'|awk -F "[\t ]+" '{print $2}')

mkdir -p processed
for i in $issues;do
	ghi show $i |tee -a processed/$i.md
done

cd processed
for i in $(ls *.md);do
	dir=$(sed -n '2p' $i|sed -r 's/^@(.*)? opened .*$/\1/g')
	mkdir -p $dir
	mv $i $dir
done
echo "done processing"
