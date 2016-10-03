class Blob {
  Palette palette;
  List<Location> locs = new ArrayList((width + height) * 2);
  DistCalculator distc;
  float growthRate = 1;
  boolean canGrow = true;
  
  Blob() {
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
  
  Blob(Palette palette, DistCalculator distc, int[][] positions) {
    this.palette = palette;
    this.distc = distc;
    for(int[] pos : positions) {
      addPixel(pos[0], pos[1], r.nextInt(palette.colors.length));
    }
    init();
  }
  
  Blob(Palette palette, DistCalculator distc, int x, int y) {
    this.palette = palette;
    this.distc = distc;
    addPixel(x, y, r.nextInt(palette.colors.length));
    init();
  }
  
  void init() {
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
  
  void tick() {
    if(locs.size() == 0 || palette.colors.length == 0) {
      canGrow = false;
      return;
    }
    if(random(1.0) < growthRate) {
      //addPixel(r.nextInt(locs.size()));
      addPixel(constrain(locs.size() - 1 - r.nextInt(8), 0, locs.size() - 1));
    }
    if(palette.colors.length == 0) {
      canGrow = false;
      return;
    }
  }
    
  void addPixel(int loc) {
    int x = locs.get(loc).x;
    int y = locs.get(loc).y;
    color pc = locs.get(loc).c;
    
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
    
    locs.remove(loc);
    addPixel(x, y, index);
  }
  
  void addPixel(int x, int y, int c1) {
    color c = palette.colors[c1];
    palette.counts[c1]--;
    setc(x, y, c);
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
  
  void addLoc(int x, int y, int c) {
    locs.add(new Location(x, y, c));
    setc(x, y, colorizer.def ^ 0x01000000);
  }
  
  void setc(int x, int y, int c) {
    colorizer.setc(x, y, c);
  }
  
  color getc(int x, int y) {
    return colorizer.getc(x, y);
  }
}