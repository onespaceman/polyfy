#! /bin/bash

#adds totally awesome polygons to any wallpaper
#check if file is specified
if [ "$#" -ne 1 ]
then
        echo "no file specified"
        echo "polyfy /path/to/file"
        exit 1
fi

#variables
bordercolor="white"
borderwidth="15"
file="$1"
filename=$(identify -format "%t" $file)
directory=$(identify -quiet -format "%d" $file)
format=$(identify -format "%e" $file)
imagewidth=$(identify -format "%w" $file)
imageheight=$(identify -format "%h" $file)
length=$(echo "$imageheight/3" | bc -l | awk '{print int($1+0.5)}')
height=$(echo "$length * sqrt(3) / 2" | bc -l | awk '{print int($1+0.5)}')
point1=$((imagewidth/2))
pointa=$((imageheight/2-height/2))
point2=$((imagewidth/2-length/2))
pointb=$((imageheight/2+height/2))
point3=$((imagewidth/2+length/2))

echo "Pick which colors to invert"
echo "r g b or any combination (rg rb rgb etc.)"
read channel
negate="-channel $channel -negate"


convert -size "$imagewidth"x"$imageheight" xc:none -fill black -draw "path 'M $point1,$pointa $point2,$pointb $point3,$pointb Z'" /tmp/polyfy1.$format
convert $file /tmp/polyfy1.$format -alpha set -compose Dstin -composite $negate /tmp/polyfy2.$format
composite -gravity center /tmp/polyfy2.$format $file /tmp/polyfy3.$format
convert /tmp/polyfy3.$format -stroke $bordercolor -strokewidth $borderwidth -fill none -draw "path 'M $point1,$pointa $point2,$pointb $point3,$pointb Z M $point1,$pointb $point2,$pointa $point3,$pointa Z'" $directory$filename-polyfy.$format #M 1280,1042 1000,557 1560,557 Z

rm -f /tmp/{polyfy1.$format,polyfy2.$format,polyfy3.$format}

echo "file saved to "$directory"/"$filename"-polify."$format""

