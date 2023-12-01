

int[][] grid;
int scale;
int rows;
int cols;

void setup() {
  //size(800, 600);
  fullScreen();
  scale = 5;
  cols = int(width /scale);
  rows = int(height /scale);

  grid = new int[rows][cols];
  grid[int(rows/2)][int(cols / 2)] = 50000;
  
  background(0);
  textSize(128);
  textAlign(CENTER);
  text("Calculating...", width / 2, height / 2 );
  while(!(grid[int(rows/2)][int(cols / 2)] == 4)){
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        int g = grid[y][x];
        if (g >= 4) {
          if ( x > 0 && x < cols - 1 && y > 0 && y < rows - 1) {
            grid[  y  ][x + 1] += 1;
            grid[  y  ][x - 1] += 1;
            grid[y + 1][  x  ] += 1;
            grid[y - 1][  x  ] += 1;
            grid[  y  ][  x  ] -= 4;
          }
        }
      }
    }
  }

  
}

void draw() {
  background(51, 255);
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int g = grid[y][x];
      //colorMode(HSB);
      noStroke();
      fill(map(g, 0, 4, 0, 255), map(g, 0, 4, 5, 100), map(g, 0, 4, 0, 30));
      rect(x * scale, y * scale, scale, scale);
    }
  }
  noLoop();
}
