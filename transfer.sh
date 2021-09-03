#!/bin/bash

#This script pulls all .7z files from the desktop hopper into the cygwin <user>/home directory

#import
mkdir -p cyg_hopper
cp -r c://Users/$USER/Desktop/hopper/* cyg_hopper

#process
cd cyg_hopper
bash process_NC_data.sh #This leaves you in cyg_hopper
date=$(date +%Y-%m-%d-%H-%M)

#export
mv Network\ Canvas\ Exports/unzipped/net_canvas_outputs ./net_canvas_outputs_${date}
cp -r net_canvas_outputs_${date} c://Users/$USER/Desktop/outhopper

#cleanup/document
mkdir -p output_archive
mv net_canvas_outputs_${date} output_archive
rm -r Network\ Canvas\ Exports
mkdir output_archive/input_files && mv *7z output_archive/input_files
cd ~
