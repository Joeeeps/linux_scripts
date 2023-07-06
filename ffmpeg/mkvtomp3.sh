#!/bin/bash 
#use the bash interpreter

script_dir=$(dirname "$0") #script_dir variable is taken from directory path of this script
input_dir="$script_dir" #input_dir is same as script_dir, change to /<dir> if .mkv are in deeper directory than script 
output_dir="$script_dir/Audio" #outputs in /Audio/ folder within current directory

# Create the "Audio" directory if it doesn't exist
mkdir -p "$output_dir" #create nested directory for output_dir (if it doesn't exist)

for file in "$input_dir"/*.mkv; do #start of loop, looks at all .mkv files
    filename=$(basename "$file") #assigns file name to match basename of current .mkv
    output_file="$output_dir/$filename.mp3"
    ffmpeg -i "$file" -map 0:a:1 -vn -c:a libmp3lame -q:a 4 "$output_file" 
done

#use mffmpeg; specify -i(nput) file; 
#-map 0:a:0 = choose input file (we only use one); choose a(udio) stream; choose audio track. I.e. if we have two tracks, 0:a:1 grabs audio track 2 
#-vn disables video recording, so we get rid of the video
#-c:a chooses audio codec, libmp3lame for .mp3 in our case 
#-q:a 4 sets audio quality for our chosen output file  