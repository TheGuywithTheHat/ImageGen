import java.util.List;
import java.util.Random;
import java.awt.event.KeyEvent;

Random r;

Colorizer colorizer;

int colorDepth = 7;
color[] data;

void setup() { // runs once at the beginning of the program
  //size(256, 256);
  size(displayWidth, displayHeight);
  noStroke();
  noSmooth();
  
  r = new Random();
  
  colorizer = new Colorizer();
}

void draw() { // runs every frame
  System.arraycopy(data, 0, pixels, 0, pixels.length); // copies the data generated so far into Processing's pixel buffer
  updatePixels(); // sets the on-screen pixels to the pixel buffer
}

void keyPressed() { // saves a screenshot when [S] key is pressed
  if(keyCode == KeyEvent.VK_S) {
    save(year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2) + ".png");
  }
}