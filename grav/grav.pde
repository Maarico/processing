class body {
  float mass;
  PVector pos;
  PVector vel;

  body(float a, float b, float c, float d, float e) {
    mass = a;
    pos = new PVector(b, c);
    vel = new PVector(d, e);
  }

  void display() {
    ellipse(pos.x, pos.y, pow(mass, 1/3)*magnifier, pow(mass, 1/3)*magnifier);
  }

  void move() {
    if(pos.x>width||pos.x<0){
      vel.x=-vel.x;
      pos.add(vel);
    }
    if(pos.y>height||pos.y<0){
      vel.y=-vel.y;
      pos.add(vel);
    }
    pos.add(vel);
  }

  void force(body a) {
    vel.add(a.pos.copy().sub(pos).normalize().mult(gravconst*mass*a.mass/max(pow(dist(pos.x, pos.y, a.pos.x, a.pos.y), 2),1)));
  }
}

ArrayList <body> moving = new ArrayList();
float magnifier = 100;
float gravconst = 0.1;


void setup() {
  background(255);
  size(1000, 700);
  noFill();
}


void draw() {
  background(255);
  for (int i=0; i<moving.size(); i++) {
    moving.get(i).display();
    moving.get(i).move();
  }
  for (int i=0; i<moving.size(); i++) {
    for (int j=0; j<moving.size(); j++) {
      if (i!=j) {
        moving.get(i).force(moving.get(j));
      }
    }
  }
}


void mousePressed() {
  moving.add(new body(random(1, 10), mouseX, mouseY, 0, 0));
}