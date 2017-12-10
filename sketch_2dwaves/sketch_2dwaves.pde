ArrayList <ArrayList <PVector>> points = new ArrayList();
PVector ampoints = new PVector(501, 501);
float dampener = 0.001;

void setup() {
  background(255);
  size(700, 700);

  for (int i=0; i<ampoints.x; i++) {
    points.add(new ArrayList());
  }

  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<ampoints.y; j++) {
      points.get(i).add(new PVector());
    }
  }
}


void draw() {
  points.get(points.size()/2).get(points.get(points.size()/2).size()/2).x=sin(float(frameCount)/50)*2;
  points.get(0).get(0).y=0;  
  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {
      points.get(i).get(j).x+=points.get(i).get(j).y;
      noStroke();
      fill(map(points.get(i).get(j).x, -1, 1, 0, 255));
      rect(map(i, 0, points.size(), 0, width), map(j, 0, points.get(i).size(), 0,height), width/points.size(), height/points.get(i).size());
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
  saveFrame("out/#####.png");
}