import java.util.Arrays;


// contains the thread that does the actual generating
class Colorizer implements Runnable {
  Thread t;
  color def = 0; // the default/"blank" color
  List<Blob> blobs;
  
  Colorizer() {
    loadPixels();
    data = new color[pixels.length];
    Arrays.fill(data, def);
    blobs = new ArrayList<Blob>();
    t = new Thread(this, "colorizer");
    t.start();
  }
  
  void run() {
    // these generate all the palletes
    Palette reds = reds();
    Palette bw = blackWhite();
    Palette gray = grayscale();
    Palette blue = bluescale();
    Palette greens = greens();
    Palette rainbow = hbRainbow();
    
    // these create all the blobs
    
    blobs.add(new Blob(rainbow, bitXOR, width / 2, height / 2));
    //blobs.add(new Blob(bw, basicDistc, width / 2, height / 2));
    //blobs.add(new Blob(gray, basicDistc, width / 2, height / 2));
    
    /*blobs.add(new Blob(gray, bitXOR, width / 3, height / 3));
    blobs.add(new Blob(gray, bitXOR, width / 4, 2 * height / 3));
    blobs.add(new Blob(gray, bitXOR, 3 * width / 4, height / 2));*/
    
    /*blobs.add(new Blob(rainbow, bitXOR, width / 2 + 1, height / 2 + 1));
    blobs.add(new Blob(reds, bitAND, width / 2 + 1, height / 2 - 1));
    blobs.add(new Blob(greens, basicDistc, width / 2 - 1, height / 2 + 1));*/
    
    /*blobs.add(new Blob(rainbow, fastDist, width / 2 + 1, height / 2 + 1));
    blobs.add(new Blob(rainbow, fastDist, width / 2 + 1, height / 2 - 1));
    blobs.add(new Blob(rainbow, fastDist, width / 2 - 1, height / 2 + 1));*/
    
    /*blobs.add(new Blob(blue, dist3Shift, new int[][] {
        {width / 2 + 1, height / 2 + 1},
        {width / 2 + 1, height / 2 - 1},
        {width / 2 - 1, height / 2 + 1},
        {width / 2 - 1, height / 2 - 1}
      }));*/
    
    while(blobs.size() > 0) { // while there are still blobs that can grow, grow each blob by one pixel
      for(int i = 0; i < blobs.size(); i++) {
        blobs.get(i).tick();
        if(!blobs.get(i).canGrow) {
          blobs.remove(i);
          i--;
        }
      }
    }
  }
  
  void setc(int x, int y, int c) {
    data[y * width + x] = c;
  }
  
  color getc(int x, int y) {
    return data[y * width + x];
  }
}