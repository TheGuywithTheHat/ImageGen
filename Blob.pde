// represents a single initial pixel or a collection of initial pixels, as well as all the pixels generated from the initial
class Blob {
  Palette palette; // the list of colors to use
  List<Location> locs = new ArrayList((width + height) * 2); // the list of locations that can have a pixel generated on the next tick. I call these "nexels" (next-pixels)
  DistCalculator distc; // the method to select what color to use for the next pixel
  float growthRate = 1; // how fast the blob grows. 1.0 == every tick, 0.0 == never
  boolean canGrow = true; // whether or not there are both colors left in the pallete *and* pixels left to color
  
  Blob() { // initializes with default for everything
    init();
  }
  
  Blob(DistCalculator distc) {
    this.distc = distc;
    init();
  }
  
  Blob(Palette palette) {
    this.palette = palette;
    init();
  }
  
  Blob(Palette palette, DistCalculator distc) {
    this.palette = palette;
    this.distc = distc;
    init();
  }
  
  Blob(Palette palette, DistCalculator distc, int[][] positions) { // sets multiple initial pixels
    this.palette = palette;
    this.distc = distc;
    for(int[] pos : positions) {
      addPixel(pos[0], pos[1], r.nextInt(palette.colors.length));
    }
    init();
  }
  
  Blob(Palette palette, DistCalculator distc, int x, int y) { // sets a single initial pixel
    this.palette = palette;
    this.distc = distc;
    addPixel(x, y, r.nextInt(palette.colors.length));
    init();
  }
  
  void init() { // initializes the blob with defaults, if not yet set
    if(palette == null) {
      palette = hbRainbow();
    }
    if(distc == null) {
      distc = basicDistc;
    }
    if(locs.size() == 0) {
      addPixel(width / 2, height / 2, r.nextInt(palette.colors.length));
    }
  }
  
  void destroy() {
    canGrow = false;
    for(Location loc : locs) {
      setc(loc.x, loc.y, colorizer.def);
    }
  }
  
  void tick() { // runs every frame
    if(locs.size() == 0 || palette.colors.length == 0) { // if no colors or nexels left, can't grow any more
      canGrow = false;
      return;
    }
    if(random(1.0) < growthRate) { // color the next nexel. there are many way to select which nexel is the "next"
      try {
        addPixel(r.nextInt(locs.size())); // selects a completely random nexel
        addPixel(locs.size() - 1); // selects the newest nexel
        //addPixel(0); // selects the oldest nexel
        //addPixel(constrain(locs.size() - 1 - r.nextInt(8), 0, locs.size() - 1)); // selects one of the most recent nexels, resulting a close approximation of brownian motion
      } catch(ArrayIndexOutOfBoundsException e) { /* no more to grow */ }
    }
    if(palette.colors.length == 0) { // if we just used the last color, can't grow any more
      canGrow = false;
      return;
    }
  }
    
  void addPixel(int loc) { // colors the pixel at the given index in the array of nexels
    int x = locs.get(loc).x;
    int y = locs.get(loc).y;
    color pc = locs.get(loc).c;
    
    // the following shenanigans make that if there are multiple possible colors with the same "distance," we don't always select the first one.
    
    float diff = Float.MAX_VALUE;
    int[] candidates = {-1, -1};
    
    for(int i = 0; i < palette.colors.length; i++) {
      if(palette.counts[i] <= 0) {
        continue;
      }
      float d = distc.distc(palette.colors[i], pc);
      if(d < diff) {
        diff = d;
        candidates[0] = i;
        candidates[1] = -1;
      } else if(d == diff) {
        candidates[1] = i;
      }
    }
    
    if(candidates[0] < 0) {
      palette.trim();
      destroy();
      return;
    }
    
    int index = (candidates[1] > -1 ? candidates[r.nextInt(2)] : candidates[0]);
    
    locs.remove(loc); // removes this nexel from the array, because it is about to be colored
    addPixel(x, y, index); // sets the pixel at the given screen coords to the color at index "index" of the pallete's color array
  }
  
  void addPixel(int x, int y, int c1) { // sets the pixel at the given screen coords to the color at index "c1" of the pallete's color array
    color c = palette.colors[c1];
    palette.counts[c1]--;
    setc(x, y, c);
    
    // adds the blank pixels around the pixel we just colored to the array of nexels
    if(                 y > 0 &&          getc(x    , y - 1) == colorizer.def) {
      addLoc(x    , y - 1, c);
    }
    if(x < width - 1 &&                   getc(x + 1, y    ) == colorizer.def) {
      addLoc(x + 1, y    , c);
    }
    if(                 y < height - 1 && getc(x    , y + 1) == colorizer.def) {
      addLoc(x    , y + 1, c);
    }
    if(x > 0         &&                   getc(x - 1, y    ) == colorizer.def) {
      addLoc(x - 1, y    , c);
    }
    
    if(x > 0         && y > 0 &&          getc(x - 1, y - 1) == colorizer.def) {
      addLoc(x - 1, y - 1, c);
    }
    if(x < width - 1 && y > 0 &&          getc(x + 1, y - 1) == colorizer.def) {
      addLoc(x + 1, y - 1, c);
    }
    if(x < width - 1 && y < height - 1 && getc(x + 1, y + 1) == colorizer.def) {
      addLoc(x + 1, y + 1, c);
    }
    if(x > 0         && y < height - 1 && getc(x - 1, y + 1) == colorizer.def) {
      addLoc(x - 1, y + 1, c);
    }
  }
  
  void addLoc(int x, int y, int c) { // adds the nexel to the nexel array
    locs.add(new Location(x, y, c));
    setc(x, y, colorizer.def ^ 0x01000000);
  }
  
  void setc(int x, int y, int c) { // sets the pixel (in the data array) at the coords to color c
    colorizer.setc(x, y, c);
  }
  
  color getc(int x, int y) { // returns the color of the pixel (in the data array) at the given coords
    return colorizer.getc(x, y);
  }
}