interface DistCalculator {
  float distc(color c1, color c2);
}

DistCalculator basicDistc = new DistCalculator() {
  float distc(color c1, color c2) {
    int r = int(red(c1) - red(c2));
    int g = int(green(c1) - green(c2));
    int b = int(blue(c1) - blue(c2));
    return r * r + g * g + b * b;
  }
};

DistCalculator dist3Shift = new DistCalculator() {
  float distc(color c1, color c2) {
    int r = int(red(c1) - green(c2));
    int g = int(green(c1) - blue(c2));
    int b = int(blue(c1) - red(c2));
    return r * r + g * g + b * b;
  }
};

DistCalculator oddDist1 = new DistCalculator() {
  float distc(color c1, color c2) {
    int r = (c1 >> 16) & 0xFF - (c2 >> 16) & 0xFF;
    int g = (c1 >> 8) & 0xFF - (c2 >> 8) & 0xFF;
    int b = c1 & 0xFF - c2 & 0xFF;
    return r * r + g * g + b * b;
  }
};

DistCalculator oddDist2 = new DistCalculator() {
  float distc(color c1, color c2) {
    return ((c1 >> 16) & 0xFF - (c2 >> 16) & 0xFF) << 1 + ((c1 >> 8) & 0xFF - (c2 >> 8) & 0xFF) << 1 + (c1 & 0xFF - c2 & 0xFF) << 1;
  }
};

DistCalculator bitXOR = new DistCalculator() {
  float distc(color c1, color c2) {
    return c1 ^ c2;
  }
};

DistCalculator bitOR = new DistCalculator() {
  float distc(color c1, color c2) {
    return c1 | c2;
  }
};

DistCalculator bitAND = new DistCalculator() {
  float distc(color c1, color c2) {
    return c1 & c2;
  }
};

DistCalculator fastDist = new DistCalculator() {
  float distc(color c1, color c2) {
    return 0;
  }
};