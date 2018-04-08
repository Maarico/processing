ArrayList <rocket> rockets= new ArrayList();
float dt = 0.1;
int active = 0;

void setup() {
  rockets.add(new rocket(10, 1, 300, 300, 300, 0, 0, PI*2, 0));
  size(700, 700);
  background(255);
}

void draw() {
  background(255);
  translate(-(getactive().pos.x-width/2),-(height/2-getactive().pos.y));
  for (int i=0; i<rockets.size(); i++) {
    rockets.get(i).display();
    rockets.get(i).move();
  }
}

void keyPressed() {
  if (key==CODED) {
    if (keyCode==SHIFT) {
      getactive().throttle+=0.01*dt;
    } else if (keyCode==CONTROL) {
      getactive().throttle-=0.01*dt;
    }
  }
  if(key=='x'){
    getactive().throttle=0;
  }
  if(key=='y'){
    getactive().throttle=1;
  }
  if(key=='d'){
    getactive().angmom-=0.1*dt;
  }
  if(key=='a'){
  getactive().angmom+=0.1*dt;  
  }
}

rocket getactive() {
  for (int i=0; i<rockets.size(); i++) {
    if (rockets.get(i).id==active) {
      return rockets.get(i);
    }
  }
  return null;
}
