#! /usr/bin/env bash
#
# Copyright (c) 2015
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

SHORT="hr:s:o:n:b:"
LONG="help,rotate:,blur:,border-color:,border-width:,overlay:,size:,negate:,shape:,sides:,saturate:,output:"
OPTIONS=$(getopt -o $(echo $SHORT) \
                 -l $(echo $LONG) \
                 -n "$0" \
                 -- "$@")

eval set -- "$OPTIONS"

# Default variables
num_sides="4" #default polygon
overlay="over" #default drawing option for the second polygon
border_w="10" #default border width
border_c="white" #default border color
size="2" #default size of polygon
rotation_f="0"
rotation_s="0"
dup_c=2

while true; do
    case "$1" in
        -n|--negate)
            # TODO: Elegant of not parsing the -channel and -negate when there's
            # other characters specified apart from 'rgb'.
            negate="-channel ${2//[^rgb]/} -negate"
            shift 2 ;;
        -r|--rotate)
            rotation_f="${2%,*}"
            rotation_s="${2#*,}"
            shift 2 ;;
        -o|--overlay)
            overlay="$2"
            shift 2 ;;
        --blur)
            blur="-blur 0x$2"
            shift 2 ;;
        --size)
            size="$2"
            shift 2 ;;
        --saturate)
            saturation="$2"
            saturate="-modulate 100,$((saturation+100))"
            shift 2;;
        --output)
            output="$2"
            shift 2 ;;
        -s|--shape|--sides)
            num_sides="$2"
            shift 2 ;;
        -b|--border-width)
            border_w="$2"
            shift 2 ;;
        --border-color)
            border_c="$2"
            shift 2 ;;
        -h|--help)
            echo "
$(tput bold)NAME$(tput sgr0)
    Polyfy - Add cool polygons to any wallpaper

$(tput bold)SYNOPSIS$(tput sgr0)
    $(tput bold)polyfy$(tput sgr0) [option$(tput sgr0)]... $(tput sitm)file$(tput sgr0) [$(tput sitm)second file$(tput sgr0)]

$(tput bold)DESCRIPTION$(tput sgr0)
    $(tput bold)polyfy$(tput sgr0) is a bash script used to add polygons to images, mainly for the
    purpose of customizing desktop wallpapers.

    Either one or two image files may be specified. If a second image is specified, the
    center of the second image shall be "cut out" and inserted into the center
    of the polygon.

    By default, the output is saved in the current directory as \"[input filename]-polyfy\".
    This may be changed with the --output flag. If the filename that $(tput bold)polyfy$(tput sgr0) attempts to use
    already exists, a number shall be affixed to the end to prevent the existing file from
    being overwritten.

    $(tput bold)polyfy$(tput sgr0) is hosted at https://github.com/onespaceman/polyfy

$(tput bold)OPTIONS$(tput sgr0)
    $(tput bold)-h, --help $(tput sgr0)
        You're looking at it.

    $(tput bold)--output$(tput sgr0) <file>
        Allows the output filename (and, optionally, directory) to be specified. The file
        extension should not be given as part of \`filename\`.
        If a directory is not specified, the file shall be saved in the current directory.
		
    $(tput bold)-r, --rotate$(tput sgr0) <first>,<second>
        Specify the rotations done on the first and second polygon. Split the 
        degrees with a ',' 

    $(tput bold)-b, --border-width$(tput sgr0) <number>
        The border width.

        The default value is 10.

    $(tput bold)--border-color$(tput sgr0) <color>
        The color of the border.

        The default value is white.

    $(tput bold)--blur$(tput sgr0) <sigma>
        Amount to blur the image excluding the area inside polygon.
        The numbers are floating point values, so you can use a very small
        value like '0.5'.

        The default value is 0.

    $(tput bold)--size$(tput sgr0) <number>
        The size of the polygon as a fraction of image height.

        The default value is 2.

    $(tput bold)-s, --shape, --sides$(tput sgr0) <number>
        What shape should be drawn, defined by the number of sides

        By default the shape will be a square.

    $(tput bold)--saturate$(tput sgr0) <level>
        Amount to (de)saturate the image exluding the are inside polygon.
        At -100 the image is completely desaturated and at 100, completely saturated.

        The default value is 0.

    $(tput bold)-n, --negate$(tput sgr0) <colors>
        Specify which color channels to negate.

        The color channels are red, green, and blue and are shortened to just the
        first letter: r, g, and b. Enter them without any characters or spaces
        between them.

        They can be in any combination or order like: 'g', 'bg' or 'grb'.
        Repeating the same channel twice cancels itself out.

        By default there will be no negated channels.

    $(tput bold)-o, --overlay$(tput sgr0) <type>
        Draw the second polygon over or under the first, or not at all.

        | Type    | Description                                 |
        |-------------------------------------------------------|
        | Under   | Draw a second polying beneath the first one |
        | Over    | Draw a second polygon over the first one    |
        | None    | Don't draw a second polygon                 |

        The default will be 'over'.

$(tput bold)EXAMPLES$(tput sgr0)
    polyfy the image with the default options:

        polyfy path/to/image

    polyfy with a hexagon, negate the blue and red channels, set the
    polygon's side length to 1/2 the image's height, and set the polygon's
    border width to 20 pixels:

        polyfy -s 6 -n br --size 2 -b 20 /path/to/image

    overlay a clipping from the second image onto the first image:

        polyfy /path/to/image /path/to/second/image
            "
            exit  ;;
        --) shift
            break ;;
        * ) break ;;
    esac
done

[[ -f ${1} ]] && {
    file_f="${1//~/$HOME}"; shift
    [[ -f ${1} ]] && {
        file_s="${1//~/$HOME}"; shift
    } || {
        file_s=$file_f
    }
} || {
    echo "You did not specify a file."
    exit 0
}
directory=$(dirname $file_f)
filename=$(basename ${file_f%.*})
image_h=$(identify -format "%h" $file_f)
image_w=$(identify -format "%w" $file_f)
format=$(basename ${file_f##*.})
dup_c=""

if [[ -z $output ]]; then
    [[ -e $directory/$filename-polyfy.$format ]] && {
        dup_c=2
        while [[ -e $directory/$filename-polyfy"$dup_c".$format ]]; do
            let dup_c++
        done
    }
    filename="$directory/$filename-polyfy"$dup_c".$format"
else
    directory=$(dirname $output)
    filename=$(basename ${output%.%})
    [[ -e $directory/$filename.$format ]] && {
        dup_c=2
        while [[ -e $directory/$filename"$dup_c".$format ]]; do
            let dup_c++
        done
    }
    filename="$directory/$filename"$dup_c".$format"
fi

#calculate the path of the given shape
length=$(echo "$image_h / $size" | bc -l | awk '{print int($1 + 0.5)}')
center_x=$(echo "$length / 2" | bc -l)
#the radius
radius=$(echo "($length - $border_w) / 2" | bc -l)
pi=$(echo "scale=10; 4 * a(1)" | bc -l)

#align the shape to be vertically symetrical
if [ $((num_sides%2)) -eq 0 ]; then
   align_shape="1"
   rotate_s=$(echo "180 / $num_sides" | bc -l | awk '{print int ($1 + 0.5)}')
else
   align_shape="0.5"
   rotate_s="180"
fi

degrees=$(echo "180 / $num_sides * $align_shape" | bc -l)
theta=$(echo "$pi / 180 * $degrees" | bc -l)

#calculate vertices and place in arrays
for ((i=0;i<num_sides;i++)) do
   vertix[$i]=$(echo "$center_x + $radius * c(2 * $pi * $i / $num_sides + $theta)" | bc -l | awk '{print int($1 + 0.5)}')
   vertiy[$i]=$(echo "$center_x - $radius * s(2 * $pi * $i / $num_sides + $theta)" | bc -l | awk '{print int($1 + 0.5)}')
done

path+=(polygon)

#combine the x and y arrays into x,y coordinates
for ((i=0;i<num_sides;i++)) do
   path+=(${vertix[$i]},${vertiy[$i]})
done

#make the matte
convert -size "$length"x"$length" xc:none -fill black -draw "${path[*]}" \
        -background none -rotate $rotation_f -trim /tmp/polyfy1.png

# Cut out the first polygon from the original image and negate it.
convert $file_s /tmp/polyfy1.png -gravity center -alpha set -compose Dstin \
        -composite $negate -trim +repage /tmp/polyfy2.png

[[ $border_w -ne 0 ]] && {
    # Draw the border.
    convert -size "$length"x"$length" xc:none -stroke $border_c \
            -strokewidth $border_w -fill none -draw "${path[*]}" -background none \
            -rotate $rotation_f -trim /tmp/polyfy1.png
    case $overlay in
        over)
            # Combine the border and rotated border.
            convert -gravity center -background none /tmp/polyfy1.png \
                    -rotate $((rotation_s+rotate_s)) /tmp/polyfy1.png \
                    -compose Over -composite /tmp/polyfy1.png
            # Place borders over clipping
            convert -gravity center /tmp/polyfy1.png /tmp/polyfy2.png \
                    -compose DstOver -composite /tmp/polyfy2.png
            ;;
        under)
            # Place rotated border under clipping
            convert -gravity center -background none /tmp/polyfy1.png \
                    -rotate $((rotation_s+rotate_s)) /tmp/polyfy2.png \
                    -compose Over -composite /tmp/polyfy2.png
            # Place border over clipping
            convert -gravity center -background none /tmp/polyfy2.png \
                    /tmp/polyfy1.png -compose Over -composite /tmp/polyfy2.png
            ;;
        none)
            # Place border over clipping.
            convert -gravity center /tmp/polyfy1.png /tmp/polyfy2.png \
                    -compose DstOver -composite /tmp/polyfy2.png
            ;;
    esac
}

# Combine clipping and original image, apply blur
convert -gravity center $file_f $blur $saturate /tmp/polyfy2.png -compose Over -composite $filename
# Remove temporary files.
rm -f /tmp/polyfy{1,2}.png
# Tell the user where and what.
echo "file saved to $filename"
