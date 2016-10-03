class Location {
  int x, y;
  color c;
  Location(int x, int y, color c) {
    this.x = x;
    this.y = y;
    this.c = c;
  }
}

class Palette {
  color[] colors;
  int[] counts;
  
  void trim() {
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