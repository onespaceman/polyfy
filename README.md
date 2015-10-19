# polyfy
add cool polygons to any wallpaper

#####samples:
![](https://github.com/onespaceman/polyfy/blob/master/samples/sea-polyfy.jpg)
![](https://github.com/onespaceman/polyfy/blob/master/samples/forest-polyfy.jpg)
![](https://github.com/onespaceman/polyfy/blob/master/samples/grass-polyfy.jpg)

#####usage:
```
chmod +x polyfy  
polyfy /path/to/image <options>
```

#####options:
`r|g|b` Choose r, g, b, or any combination of the three ( bg rg ) to control which colors turn negative (default: rgb)  
`traingle|square|diamond>` Draw a triangle, square, or diamond (default: diamond)  
`-s or --size <size>` Change the polygon size as a fraction of the image's height (default: 3 #this means the polygon side length is 1/3 of the image's height)  
`-b or --borderwidth <borderwidth>` Change the border width of the polygons (default: 10)
`over|under|none` Choose if the second polygon is drawn over the first, under, or not at all (default: over)


#####examples:
```
polyfy path/to/image
```
polyfy the image with the default options
```
polyfy path/to/image diamond br -s 2 -b 20
```
polyfy with a diamond | negate the blue and red channels | with the polygon's side length at 1/2 the image's height | with a border width of 20pt


#####dependencies:  
imagemagick

#####roadmap:
* more shapes if I can figure out the math
