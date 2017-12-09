ArrayList <ArrayList <PVector>> points = new ArrayList();
PVector ampoints = new PVector(10, 10);
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
  points.get(0).get(0).x=map(mouseY,height,0,-1,1);
  points.get(0).get(0).y=0;  
  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {
      points.get(i).get(j).x+=points.get(i).get(j).y;
      noStroke();
      fill(map(points.get(i).get(j).x, -1, 1, 0, 255));
      rect(map(i, 0, points.size(), 0, width), map(j+1, 0, points.get(i).size(), height, 0), width/points.size(), height/points.get(i).size());
    }
  }

  for (int i=0; i<points.size(); i++) {
    for (int j=0; j<points.get(i).size(); j++) {
      try {
        points.get(i).get(j).y+=(points.get(i-1).get(j).x+points.get(i+1).get(j).x+points.get(i).get(j-1).x+points.get(i).get(j+1).x-4*points.get(i).get(j).x)*dampener;
      }
      catch(Exception e) {
        try {
          points.get(i).get(j).y+=(points.get(i-1).get(j).x+points.get(i+1).get(j).x-2*points.get(i).get(j).x)*dampener;
        }
        catch(Exception e2) {}
        try {
          points.get(i).get(j).y+=(points.get(i).get(j-1).x+points.get(i).get(j+1).x-2*points.get(i).get(j).x)*dampener;
        }
        catch(Exception e2) {}
        
      }
    }
  }
}