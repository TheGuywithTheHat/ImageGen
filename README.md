# ImageGen

Generates images like these: 

![](http://i.imgur.com/Kb2I64ws.png) ![](http://i.imgur.com/JUipk71s.png) ![](http://i.imgur.com/gDt866rs.png) ![](http://i.imgur.com/vERbeYUs.png)  
![](http://i.imgur.com/uNcqg2Rs.png) ![](http://i.imgur.com/NTJg0OJs.png) ![](http://i.imgur.com/eYSCEJOs.png) ![](http://i.imgur.com/zIJr7uos.png)

[A larger album.](http://imgur.com/a/fwBfb)

Essentially what the program does is manually color one (or more) pixel(s), then while there are blank pixels left, color a pixel next to a pixel that has already been colored.

The extreme variation comes from the many different ways to

 - decide what pallette of colors to use.
 - select which pixel to color next.
 - select the color to use, based on the previous color.

## Understanding the Code

If you want to try to understand the code, I tried to document it a bit. `ImageGen.pde` is the entry point of the program, `Colorizer.pde` has the code that starts the algoritm in another thread, `ColorGenerators.pde` has the code that generates pallettes, `DistCalculators.pde` contains the many methods to compare two colors, `Blob.pde` has the class representing a growing blob of pixels, and `Helpers.pde` contains various small classes to just better organize data.

## Method

### Definitions

 - **Distance**: Originally intended to be "a quantification of the visual difference between two colors," it devolved into "any way to compare two colors," and then "any way to generate an `int` based on two other `int`s."
 - **Pallette**: A list of colors to be used up. Internally, it is an array of unique colors and an array of the number of each color, e.g. `{red, red, red, green, blue, blue}` is:
        
        colors = {red, green, blue}
        counts = {  3,     1,    2}
        
 - **Nexel**: One of the next pixels that could be colorized on the current tick.
 - **Blob**: A group of colorized pixels as well as all the nexels surrounding those pixels.

### Algorithm

 1. #### Initialize
    
    Here's what happens when we start the algorithm:
    
     1. Create an array "data" that holds the current color of each pixel.
     2. Instantiate one or more blobs.
     3. For each blob: select a pallette, select a distance calculator, and colorize one or more initial pixels.
     4. Create all the nexels for each of the inital pixels.
     
 2. #### Tick
 
    On each tick, for each blob:
    
     1. If the pallette is empty or there are no nexels left, destroy the blob, else:
     2. Pick a nexel using one of several methods (e.g. the oldest one, a random one, one of the 8 newest ones, etc.).
     3. Select a color from the specified pallette for that nexel, using the specified distance calculator to compare all colors from the pallte to the nexel's "parent's" color.
     4. Colorize the nexel and turn it into a "colorized pixel" by setting the color in the data array.
     5. Create new "children" nexels from the blanks in the data array around the current pixel.
     6. Tell the new nexels the color of their parent pixel.
     
### Output

While a thread runs the algoritm in realtime, the main loop of the program runs at a given framerate (usually 60fps). It reads the colors from the data array, and writes them to screen. Additionally, a `.png` is saved whenever the [S] key is pressed.
