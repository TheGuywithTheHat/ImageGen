import java.util.List;
import java.util.Random;
import java.awt.event.KeyEvent;

Random r;

Colorizer colorizer;

int colorDepth = 7;
color[] data;

void setup() {
  //size(256, 256);
  size(displayWidth, displayHeight);
  noStroke();
  noSmooth();
  
  r = new Random();
  
  colorizer = new Colorizer();
}

void draw() {
  System.arraycopy(data, 0, pixels, 0, pixels.length);
  updatePixels();
}

void keyPressed() {
  if(keyCode == KeyEvent.VK_S) {
    save(year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png");
  }
}