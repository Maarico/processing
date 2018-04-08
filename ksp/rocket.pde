class rocket {
  float drymass;
  float fuel;
  float isp;
  float throttle=0;
  PVector pos;
  PVector vel;
  float heading;
  float angmom=0;
  int id;

  rocket(float dm, float f, float is, float px, float py, float vx, float vy, float h, int i) {
    drymass = dm;
    fuel = f;
    isp=is;
    pos=new PVector(px, py);
    vel=new PVector(vx, vy);
    heading = h;
    id=i;
  }

  void display() {
    translate(pos.x, height-pos.y);
    rotate(heading);
    triangle(-5, -10, 5, -10, 0, 10);
    translate(-pos.x, pos.y-height);
    rotate(-heading);
  }

  void move() {
    throttle=min(1, max(0, throttle));
    pos.add(vel.copy().mult(dt));
    heading+=angmom*dt;
    if (fuel>0) {
      vel.add(new PVector(-sin(heading), -cos(heading)).mult(isp*throttle*dt/(drymass+fuel)));
      fuel-=throttle*dt;
    }
  }
}
