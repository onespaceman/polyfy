# polyfy
add cool polygons to any wallpaper

#####samples:
![](https://github.com/onespaceman/polyfy/blob/master/samples/sea-polyfy.jpg)
![](https://github.com/onespaceman/polyfy/blob/master/samples/forest-polyfy.jpg)
![](https://github.com/onespaceman/polyfy/blob/master/samples/mountains-polyfy.jpg)
![](https://github.com/onespaceman/polyfy/blob/master/samples/grass-polyfy.jpg)

#####usage:
```
chmod +x polyfy  
polyfy /path/to/image <options>
```

#####options:
`-h or --help`
Display the instructions

`--output`
Allows the output filename (and, optionally, directory) to be specified. The file extension should not be given as part of `filename`.                             
If a directory is not specified, the file shall be saved in the current directory
                                                                                 
The default filename is the input filename suffixed with "-polyfy".            
The default directory is the current directory.                                  
                                                                                 
If the filename that polyfy attempts to use already exists, a number shall       
be affixed to the end, starting with "2".                                      

`-r or --rotate <first> <second>`
Specify the rotations done on the first and second polygon. Split the degrees with a ',' 

`--border-width <number>`
The border width.

The default value is 10.

`--border-color <color>`
The color of the border.

The default value is white.

`--blur <sigma>`
Amount to blur the image excluding the area inside polygon.
The numbers are floating point values, so you can use a very small value like '0.5'.

The default value is 0.

`--size <number>`
The size of polygon as a fraction of image height.

The default value is 3.

`-s or --shape <type>`
What shape should be drawn.
The available shapes are: Diamond, square, circle, triangle.

By default the shape will be a diamond.

`--saturate <level>`
Amount to (de)saturate the image exluding the are inside polygon.
At -100 the image is completely desaturated and at 100, completely saturated.

The default value is 0.

`-n or --negate <colors>`
Specify which color channels to negate.

The color channels are red, green, and blue and are shortened to just the first letter: r, g, and b. Enter them without any characters or spaces between them.

They can be in any combination or order like: 'g', 'bg' or 'grb'.  
Repeating the same channel twice cancels itself out.

By default there will be no negated channels.

`-o or --overlay <type>`
Draw the second polygon over or under the first, or not at all.

Type | Description
-----|-----
Over | Draw a second polygon over the first one
Under | Draw a second polying beneath the first one
None | Don't draw a second polygon

The default will be 'over'.


#####examples:
```
polyfy path/to/image
```
polyfy the image with the default options

```
polyfy path/to/image -s diamond -n br --size 2 -b 20
```
1. polyfy with a diamond
2. negate the blue and red channels
3. with the polygon's side length at 1/2 the image's height
4. with a border width of 20pt

```
polyfy path/to/image path/to/second/image
```
overlay a clipping from the second image onto the first image


#####dependencies:  
[ImageMagick](http://www.imagemagick.org/)

#####roadmap:
* more shapes if I can figure out the math
