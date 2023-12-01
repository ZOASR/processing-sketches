Point point1;
Point point2;
Point center;

ArrayList<Point> points;

void setup() {
  size (800, 600);
  point1 = new Point(-100, 0, 300, -0.01);
  point2 = new Point(100, 0, 200, 0.1);
  center = new Point();
  points = new ArrayList<Point>();
}

void draw() {
  translate(width/2, height/2);
  background(60);


  point1.move();
  point2.move();
  line(point1.x, point1.y, point2.x, point2.y);
  point1.display();
  point2.display();

  center.x = (point1.x + point2.x)/2;
  center.y = (point1.y + point2.y)/2;
  points.add(new Point(center.x, center.y, 100, -1));
  strokeWeight(2);

  noFill();
  stroke(255, 0, 0, 100);
  strokeWeight(10);
  beginShape();
  for (Point point : points) {
    vertex(point.x, point.y);
  }
  endShape();
  center.display();
}
