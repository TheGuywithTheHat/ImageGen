// represents a method to select which colo to use based on the previous pixel
interface DistCalculator {
  float distc(color c1, color c2);
}

DistCalculator basicDistc = new DistCalculator() { // basically the standard deviation of each of the color channels
  float distc(color c1, color c2) {
    int r = int(red(c1) - red(c2));
    int g = int(green(c1) - green(c2));
    int b = int(blue(c1) - blue(c2));
    return r * r + g * g + b * b;
  }
};

DistCalculator dist3Shift = new DistCalculator() { // same as basicDistc, but rotates hue by 1/3
  float distc(color c1, color c2) {
    int r = int(red(c1) - green(c2));
    int g = int(green(c1) - blue(c2));
    int b = int(blue(c1) - red(c2));
    return r * r + g * g + b * b;
  }
};

DistCalculator oddDist1 = new DistCalculator() { // idk but it looks cool
  float distc(color c1, color c2) {
    int r = (c1 >> 16) & 0xFF - (c2 >> 16) & 0xFF;
    int g = (c1 >> 8) & 0xFF - (c2 >> 8) & 0xFF;
    int b = c1 & 0xFF - c2 & 0xFF;
    return r * r + g * g + b * b;
  }
};

DistCalculator oddDist2 = new DistCalculator() { // idk but it looks cool
  float distc(color c1, color c2) {
    return ((c1 >> 16) & 0xFF - (c2 >> 16) & 0xFF) << 1 + ((c1 >> 8) & 0xFF - (c2 >> 8) & 0xFF) << 1 + (c1 & 0xFF - c2 & 0xFF) << 1;
  }
};

DistCalculator bitXOR = new DistCalculator() { // bitwise XOR of the two colors
  float distc(color c1, color c2) {
    return c1 ^ c2;
  }
};

DistCalculator bitOR = new DistCalculator() { // bitwise OR of the two colors
  float distc(color c1, color c2) {
    return c1 | c2;
  }
};

DistCalculator bitAND = new DistCalculator() { // bitwise AND of the two colors
  float distc(color c1, color c2) {
    return c1 & c2;
  }
};

DistCalculator fastDist = new DistCalculator() { // nothing yet
  float distc(color c1, color c2) {
    return 0;
  }
};