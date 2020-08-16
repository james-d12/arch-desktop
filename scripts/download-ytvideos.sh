#!bin\sh

# Check for existence of dependencies
command -v youtube-dl >/dev/null 2>&1 || { echo >&2 "Script requires 'youtube-dl' but it is not installed."; exit 1; }

# Check if no arguments were provided, if they were check if the passed file exists or not.
[[ $# -eq 0 ]] && { echo "No video file provided!"; exit 1; } || \
{ [[ -f $1 ]] && video_file=$1; } || { echo "Video file does not exist!"; exit 1; }

cp $video_file "$video_file.cop"; temp_video_file="$video_file.cop"
sed -i "s/\s*#.*//g; /^$/ d; /#.*/ d;" $temp_video_file

counter=1
while IFS= read -r line
do
    video_type=$(awk 'NR=='$counter'{ print $1 }' $temp_video_file)
    dir=$(awk 'NR=='$counter'{ print $2 }' $temp_video_file)
    line=$(awk 'NR=='$counter'{ print $3 }' $temp_video_file)
    mkdir -p $dir
    youtube-dl -f bestvideo --format mp4 -o ''$dir'/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' $line
    counter=`expr $counter + 1`
done < "$temp_video_file"

rm -rf $temp_video_file
