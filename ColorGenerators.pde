/*Palette HBRainbow() {
  Palette p = new Palette();
  colorMode(HSB);
  
  p.colors = new color[min(width * height, (1 << colorDepth) * (1 << colorDepth))];
  p.counts = new int[p.colors.length];
  
  if(p.colors.length < (1 << colorDepth) * (1 << colorDepth)) {
    for(int i = 0; i < p.colors.length; i++) {
      p.colors[i] = color(map(i % width, 0, width, 0, 255), 255, map(i / height, 0, height, 0, 255));
      p.counts[i] = 1;
    }
  } else {
    for(int h = 0; h < 1 << colorDepth; h++) {
      for(int b = 0; b < 1 << colorDepth; b++) {
        p.colors[h + b * 1 << colorDepth] = color(h * pow(2, 8 - colorDepth), 255, b * pow(2, 8 - colorDepth));
      }
    }
    for(int i = 0; i < width * height; i++) {
      p.counts[r.nextInt(p.counts.length)]++;
    }
  }
  
  return p;
}*/

Palette hbRainbow() {
  Palette p = new Palette();
  colorMode(HSB);
  
  p.colors = new color[min(width * height, 128 * 128)];
  p.counts = new int[p.colors.length];
  
  if(p.colors.length < 128 * 128) {
    for(int i = 0; i < p.colors.length; i++) {
      p.colors[i] = color(map(i % width, 0, width, 0, 255), 255, map(i / height, 0, height, 0, 255));
      p.counts[i] = 1;
    }
  } else {
    for(int h = 0; h < 128; h++) {
      for(int b = 0; b < 128; b++) {
        p.colors[h + b * 128] = color(h * 2, 255, b * 2);
      }
    }
    
    Arrays.fill(p.counts, (width * height) / p.colors.length);
    for(int i = 0; i < (width * height) % p.colors.length; i++) {
      p.counts[i]++;
    }
  }
  
  return p;
}

Palette hbLightRainbow() {
  Palette p = new Palette();
  colorMode(HSB);
  
  p.colors = new color[min(width * height, 128 * 128)];
  p.counts = new int[p.colors.length];
  
  if(p.colors.length < 128 * 128) {
    for(int i = 0; i < p.colors.length; i++) {
      p.colors[i] = color(map(i % width, 0, width, 0, 255), 255, map(i / height, 0, height, 0, 255));
      p.counts[i] = 1;
    }
  } else {
    for(int h = 0; h < 128; h++) {
      for(int b = 0; b < 128; b++) {
        p.colors[h + b * 128] = color(h * 2, 255, b * 2);
      }
    }
    
    Arrays.fill(p.counts, (width * height) / p.colors.length);
    for(int i = 0; i < (width * height) % p.colors.length; i++) {
      p.counts[i]++;
    }
  }
  
  for(int i = 0; i < p.colors.length; i++) {
    p.colors[i] = ~p.colors[i] | 0xFF000000;
  }
  
  return p;
}

Palette lightReds() {
  Palette p = new Palette();
  colorMode(RGB);
  
  p.colors = new color[32 * 256];
  p.counts = new int[p.colors.length];
  
  for(int i = 0; i < p.colors.length; i++) {
    p.colors[i] = color(255, constrain(i / 32 + i % 32 - 16, 0, 255), constrain(i / 32 - i % 32 + 16, 0, 255));
  }
  
  Arrays.fill(p.counts, (width * height) / p.colors.length);
  for(int i = 0; i < (width * height) % p.colors.length; i++) {
    p.counts[i]++;
  }
  
  return p;
}

Palette reds() {
  Palette p = new Palette();
  colorMode(RGB);
  
  p.colors = new color[min(width * height, 128 * 128)];
  p.counts = new int[p.colors.length];
  
  if(p.colors.length < 128 * 128) {
    for(int i = 0; i < p.colors.length; i++) {
      p.colors[i] = color(255, map(i % width, 0, width, 0, 128), map(i / height, 0, height, 0, 128));
      p.counts[i] = 1;
    }
  } else {
    for(int g = 0; g < 128; g++) {
      for(int b = 0; b < 128; b++) {
        p.colors[g + b * 128] = color(255, g, b);
      }
    }
    
    Arrays.fill(p.counts, (width * height) / p.colors.length);
    for(int i = 0; i < (width * height) % p.colors.length; i++) {
      p.counts[i]++;
    }
  }
  return p;
}

Palette greens() {
  Palette p = new Palette();
  colorMode(RGB);
  
  p.colors = new color[min(width * height, 128 * 128)];
  p.counts = new int[p.colors.length];
  
  if(p.colors.length < 128 * 128) {
    for(int i = 0; i < p.colors.length; i++) {
      p.colors[i] = color(map(i % width, 0, width, 0, 128), 255, map(i / height, 0, height, 0, 128));
      p.counts[i] = 1;
    }
  } else {
    for(int g = 0; g < 128; g++) {
      for(int b = 0; b < 128; b++) {
        p.colors[g + b * 128] = color(g, 255, b);
      }
    }
    
    Arrays.fill(p.counts, (width * height) / p.colors.length);
    for(int i = 0; i < (width * height) % p.colors.length; i++) {
      p.counts[i]++;
    }
  }
  return p;
}

Palette blackWhite() {
  Palette p = new Palette();
  colorMode(RGB);
  
  p.colors = new color[2];
  p.counts = new int[p.colors.length];
  
  p.colors[0] = color(0);
  p.colors[1] = color(255);
  
  p.counts[0] = width * height / 2;
  p.counts[1] = width * height - (width * height / 2);
  
  return p;
}

Palette grayscale() {
  Palette p = new Palette();
  colorMode(RGB);
  
  p.colors = new color[255];
  p.counts = new int[p.colors.length];
  
  for(int i = 0; i < p.colors.length; i++) {
    p.colors[i] = color(i);
  }
  
  Arrays.fill(p.counts, (width * height) / p.colors.length);
  for(int i = 0; i < (width * height) % p.colors.length; i++) {
    p.counts[i]++;
  }
  
  return p;
}

Palette bluescale() {
  Palette p = new Palette();
  colorMode(RGB);
  
  p.colors = new color[255];
  p.counts = new int[p.colors.length];
  
  for(int i = 0; i < p.colors.length; i++) {
    p.colors[i] = color(constrain(i * 2 - 255, 0, 255), constrain(i * 2 - 255, 0, 255), constrain(i * 2, 0, 255));
  }
  
  Arrays.fill(p.counts, (width * height) / p.colors.length);
  for(int i = 0; i < (width * height) % p.colors.length; i++) {
    p.counts[i]++;
  }
  
  return p;
}