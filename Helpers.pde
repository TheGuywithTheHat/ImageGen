class Location { // represents a nexel, i.e. the two coordinates and the color that this nexel's color will be generated from
  int x, y;
  color c;
  Location(int x, int y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }
}

class Palette { // represents a finite pallete of colors that can be used up
  color[] colors; // the set of unique colors
  int[] counts; // the number of times each color can be used, generally equal to the number of onscreen pixels divided by the number of unique colors
  
  void trim() { // removes colors that have been used up
    int total = 0;
    for(int count : counts) {
      if(count > 0) {
        total++;
      }
    }
    
    color[] newColors = new color[total];
    int[] newCounts = new color[total];
    total = 0;
    
    for(int i = 0; i < colors.length; i++) {
      if(counts[i] > 0) {
        newColors[total] = colors[i];
        newCounts[total] = counts[i];
        total++;
      }
    }
    colors = newColors;
    counts = newCounts;
  }
}