ArrayList <ArrayList <PVector>> points = new ArrayList();
PVector ampoints = new PVector(101, 101);
float dampener = 0.01;
float zoom = -500;

float scaler = 700;


void setup() {
  background(255);
  //size(700, 700, P3D);
  fullScreen(P3D);

  for (int i=0; i<ampoints.x; i++) {
    points.add(new ArrayList());
  }

  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<ampoints.y; j++) {
      points.get(i).add(new PVector(exp(-pow(sqrt(pow(ampoints.x/2-i,2)+pow(ampoints.y/2-j,2)),2)*0.1),0));
    }
  }
  //points.get(points.size()/2).get(points.get(points.size()/2).size()/2).x=1;
}


void draw() {
  background(0);
  translate(width/2-scaler/2,height/2-scaler/2);
  translate(0,0,scaler+zoom);
  translate(scaler/2,scaler/2);
  rotateX(PI/4*(-float(mouseY)/100));
  rotateZ(float(mouseX)/100);
  translate(-scaler/2,-scaler/2);//sin(float(frameCount)/20)*5;
  //points.get(points.size()/2).get(points.get(points.size()/2).size()/2).y=0; 
  noFill();
  stroke(255);
  for (int i=0; i<points.size()-1; i++) {
    for (int j=0; j<points.get(i).size()-1; j++) {/*
      noStroke();
      fill(map(points.get(i).get(j).x, -1, 1, 0, 255));
      rect(map(i, 0, points.size(), 0, width), map(j, 0, points.get(i).size(), 0,height), float(width)/points.size()+1, float(height)/points.get(i).size()+1);
      */
      beginShape();
      vertex(map(i, 0, points.size(), 0, scaler), map(j, 0, points.get(i).size(), 0,scaler),points.get(i).get(j).x*100);
      vertex(map(i+1, 0, points.size(), 0, scaler), map(j, 0, points.get(i).size(), 0,scaler),points.get(i+1).get(j).x*100);
      vertex(map(i+1, 0, points.size(), 0, scaler), map(j+1, 0, points.get(i).size(), 0,scaler),points.get(i+1).get(j+1).x*100);
      vertex(map(i, 0, points.size(), 0, scaler), map(j+1, 0, points.get(i).size(), 0,scaler),points.get(i).get(j+1).x*100);
      endShape(CLOSE);
    }
  }

  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {
      points.get(i).get(j).x+=points.get(i).get(j).y;
    }
  }
  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {
      float delta=0;
      int sum = 0;
      try {
        delta+=points.get(i-1).get(j).x;
        sum++;
      }
      catch(Exception e) {}
      try {
        delta+=points.get(i+1).get(j).x;
        sum++;
      }
      catch(Exception e) {}
      try {
        delta+=points.get(i).get(j-1).x;
        sum++;
      }
      catch(Exception e) {}
      try {
        delta+=points.get(i).get(j+1).x;
        sum++;
      }
      catch(Exception e) {}
      points.get(i).get(j).y+=(delta-sum*points.get(i).get(j).x)*dampener;
    }
  }
}



void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  zoom*=pow(2,event.getCount());
}