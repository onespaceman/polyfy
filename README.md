# polyfy
add cool polygons to any wallpaper

#####usage:
```
chmod +x polyfy  
polyfy /path/to/image <options>
```

#####options:
[color] Choose r, g, b, or any combination of the three such as rg br. Controls which colors to turn negative (default: rgb)  
[polygon] Draw a triangle, square, or diamond (default: triangle)  
[size] Change the polygon size as a fraction of the image's height with an s followed by a number (default: s3 #this means the polygon side length is 1/3 of the image's height)  
[borderwidth] Change the border width of the polygon with b followed by a number (default: b15)


#####examples:
```
polyfy path/to/image
```
polyfy the image with the default options
```
polyfy path/to/image diamond br s2 b20
```
polyfy with a diamond | negate the blue and red channels | with the polygon's side length at 1/2 the image's height | with a border width of 20pt


#####dependencies:  
imagemagick

#####roadmap:
>setting borders at 0 still gives an outline.  
>allow drawing second polygon behind the coloured part
