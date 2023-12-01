class Boid{
    PVector p;
    PVector v;
    PVector acc;
    PVector gravity;
    float maxSpeed;
    float maxForce;
    float r;
    Boid(float x, float y){
        p = new PVector(x, y);
        v = PVector.random2D();
        acc = new PVector();
        gravity = new PVector(0, -0.0001);
        maxSpeed = 5;
        maxForce = 0.03;
        r = 20;
    }


    void edges() {
        if (p.x > width) {
            p.x = 0;
        } else if (p.y > height) {
            p.y = 0;
        } else if (p.y < 0) {
            p.y = height;
        } else if (p.x < 0) {
            p.x = width;
        }
    }

    void show(){
        pushMatrix();
        colorMode(HSB);
        float hue = map(v.mag(), 0, maxSpeed, 0, 360);
        stroke(hue, 360 - hue, 400 - hue);
        PVector l = PVector.fromAngle(v.heading());
        l.setMag(v.mag() * 2.5);
        translate(p.x, p.y);
        strokeWeight(5);
        line(l.x, l.y, 0, 0);
        strokeWeight(10);
        point(l.x, l.y);
        popMatrix();
    }

    void update() {
        p.add(v);
        v.add(acc);
        v.limit(maxSpeed);
        acc.limit(maxForce);
    }

    PVector separation(Boid[] boids) {
        float perceptionRadius = 100;
        PVector steering = new PVector();
        float total = 0;
        for (Boid other : boids) {
            float d = dist(
                p.x,
                p.y,
                other.p.x,
                other.p.y
            );
            if (other != this && d < perceptionRadius) {
                PVector diff = PVector.sub(p, other.p);
                diff.div(d * d);
                steering.add(diff);
                total++;
            }
        }
        if (total > 0) {
            steering.div(total);
            steering.setMag(maxSpeed);
            steering.sub(v);
            steering.limit(maxForce);
        }
        return steering;
    }

    PVector align(Boid[] boids) {
        float perceptionRadius = 100;
        PVector steering = new PVector();
        float total = 0;
        for (Boid other : boids) {
            float d = dist(
                p.x,
                p.y,
                other.p.x,
                other.p.y
            );
            if (other != this && d < perceptionRadius) {
                steering.add(other.v);
                total++;
            }
        }
        if (total > 0) {
            steering.div(total);
            steering.setMag(maxSpeed);
            steering.sub(v);
            steering.limit(maxForce);
        }
        return steering;
    }

    PVector cohesion(Boid[] boids) {
        float perceptionRadius = 50;
        PVector steering = new PVector();
        float total = 0;
        for (Boid other : boids) {
            float d = dist(
                p.x,
                p.y,
                other.p.x,
                other.p.y
            );
            if (other != this && d < perceptionRadius) {
                steering.add(other.p);
                total++;
            }
        }
        if (total > 0) {
            steering.div(total);
            steering.sub(p);
            steering.setMag(maxSpeed);
            steering.sub(v);
            steering.limit(maxForce);
        }
        return steering;
    }

    void flock(Boid[] boids, float a, float c, float s) {
        PVector alignment = align(boids);
        PVector cohesion = cohesion(boids);
        PVector separation = separation(boids);

        alignment.mult(a);
        cohesion.mult(c);
        separation.mult(s);

        acc.add(alignment);
        acc.add(cohesion);
        acc.add(separation);
        acc.add(gravity);
    }
}
