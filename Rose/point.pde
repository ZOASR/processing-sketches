class Point{
    float x;
    float y;
    float cx;
    float cy;
    float radius;
    float rate;
    float angle;
    float d_rate;

    Point(float x_, float y_, float radius_, float rate_){
        x = x_;
        y = y_;
        cx = x_;
        cy = y_;
        radius = radius_;
        rate = rate_;
        d_rate = 0.000001;
        angle = 0;
    }
    
     Point(){
       x = 0;
       y = 0;
       rate = 0;
       angle = 0;
       radius = 0;
    }

    void display(){
        stroke(255);
        strokeWeight(7);
        point(x, y);
        strokeWeight(2);
        push();
        stroke(255, 50);
        circle(cx, cy, radius * 2);
        pop();
    }

    void move(){
        x = cx + cos(angle) * radius;
        y = cy + sin(angle) * radius;
        angle += rate;
        rate += d_rate;
    }
}
