#!/bin/bash
#Purpose: Process Network Canvas data from within the unzipped directories
##Author: Bryan Brickman
#Written: Tue Jul 20 17:32:16 CDT 2021

start=$(date +%s.%5N)

#decrypt

#Un-7zip into 'Network Canvas Exports'
for i in *z; do 7z x $i -aou -y; done;
cd Network\ Canvas\ Exports/

##un .zip and collate
for i in .; do 7z x ${i} -aou -y; done
mkdir unzipped && mv *.csv *.graphml unzipped && cd unzipped

#Check if output directories are already present, create if absent (mkdir -p flag)
dirs="
net_canvas_outputs
net_canvas_outputs/raw_csv_data
net_canvas_outputs/processed_csv_data
net_canvas_outputs/graphml_data
"
mkdir -p $dirs

#Collate csv files into one compilation file by line
cat *ego.csv      | sort -u > net_canvas_outputs/processed_csv_data/all_egos.csv
cat *Person.csv   | sort -u > net_canvas_outputs/processed_csv_data/all_attributeLists.csv
cat *edgeList.csv | sort -u > net_canvas_outputs/processed_csv_data/all_edgeLists.csv

#Gather raw (non-processed) files
mv *.graphml net_canvas_outputs/graphml_data
mv *.csv net_canvas_outputs/raw_csv_data

end=$(date +%s.%5N)
echo "Elapsed time: $(echo "$end-$start" | bc) seconds"
