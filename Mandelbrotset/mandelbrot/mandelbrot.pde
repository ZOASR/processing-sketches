
int max = 1000;
int resolution = 400;
int n = 0;
double minX, maxX, minY, maxY;
double pointX = -0.6981848315349968;
double pointY = 0.37837090017418545;
double inc = 0.0001;
double zoom = 2;


void settings(){
  size(resolution, resolution, P2D);
  //fullScreen(P2D);
}

void setup() {
  
}


void keyPressed() {
    if (key == '+') {
        zoom -= zoom / 4;
    } else if (key == '-') {
        zoom += zoom / 4;
    }
}


double map_(double in, double inMin, double inMax, double outMin, double outMax) {
  if (inMin<inMax) { 
    if (in <= inMin) 
      return outMin;
    if (in >= inMax)
      return outMax;
  } else { 
    if (in >= inMin) 
      return outMin;
    if (in <= inMax)
      return outMax;
  }
  double scale = (in-inMin)/(inMax-inMin);
  return outMin + scale*(outMax-outMin);
}



void mandel(double w) {
    loadPixels();
    for (int i = 0; i < w; i++) {
        for (int j = 0; j < height; j++) {

            double a = map_(i, 0, w, minX, maxX);
            double b = map_(j, height, 0, minY, maxY);
            double aa =0;
            double bb = 0;

            double ca = a;
            double cb = b;

            n = 0;


            while (n < max) {
                aa = a * a - b * b;
                bb = 2 * a * b;

                //double aaa = (a * a * a) - (3 * a * b * b);
                //double bbb = (3 * a * a * b) - (b * b * b);
                a = (aa + ca);
                b = (bb + cb);
                if (abs((float)a + (float)b) > 20) {
                    break;
                }
                n++;
            }

            double bright = map_(n, 0,max, 0, 360);
            //let bright = 100;
            if (n == max) {
                bright = 255;
            }
            int index = (i + j * width);
            pixels[index + 0] = color((float)bright, 255, 255);
        }
    }
    updatePixels();

    minX = pointX - zoom;
    maxX = pointX + zoom;
    minY = pointY - zoom;
    maxY = pointY + zoom;
    //zoom -= zoom / 4 * 0.99;
    strokeWeight(4);
    point((float)w / 2, height / 2);
}


void mousePressed() {
  
    pointX = map_(mouseX, 0, width, minX, maxX);
    pointY = map_(mouseY, height, 0, minY, maxY);
    println(pointX, pointY);
    
}

void draw() {
    colorMode(HSB);
    stroke(255, 0, 0);
    mandel(width);
    
    //julia(800);
}
