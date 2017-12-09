ArrayList <PVector> points = new ArrayList();
int ampoints = 1000;
float dampener = 0.001;

void setup(){
  size(700,700);
  //fullScreen();
  background(255);
  
  for(int i=0;i<ampoints;i++){
    points.add(new PVector(0,0));
  }
}

void draw(){
  background(255);
  for(int i=1;i<points.size();i++){
    line(map(i-1,0,points.size(),0,width),map(points.get(i-1).x,-1,1,height,0),map(i,0,points.size(),0,width),map(points.get(i).x,-1,1,height,0));
  }
  
  for(int i=1;i<points.size()-1;i++){
    points.get(i).y+=points.get(i-1).x+points.get(i+1).x-2*points.get(i).x;
  }
  for(int i=0;i<points.size();i++){
    points.get(i).x+=points.get(i).y*dampener;
  }
  
  if (mousePressed){
  //points.get(floor(map(mouseX,0,width,0,ampoints))
  
    points.get(0).y+=map(mouseY,height,0,-1,1)-points.get(0).x;
  }
  points.get(0).y/=1.5;
  
}