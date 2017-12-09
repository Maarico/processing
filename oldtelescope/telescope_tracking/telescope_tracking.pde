import processing.video.*;

Capture cam;

PVector target = new PVector();

int threshold = 100;

float brightness = 1;

void setup() {
  background(255);
  size(1280, 720);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  }
  println(cameras.length);
  cam = new Capture(this, cameras[0]);
  cam.start();
}      


void draw() {
  background(0);
  //println(red.length);
  image(cam, 0, 0);
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    
  }
  fill(255);
  text(round(target.z), 30, 30);
  text(brightness, 30, 60);
  text(round(frameRate), 30, 90);
  fill(0);
  text(round(target.z), 90, 30);
  text(brightness, 90, 60);
  text(round(frameRate), 90, 90);
  fill(255, 0, 0);
  ellipse(target.x, target.y, 5, 5);
  noFill();
  stroke(255, 0, 0);
  rect(target.x-threshold/2, target.y-threshold/2, threshold, threshold);
}

void mousePressed() {
  target=new PVector(mouseX, mouseY);
}

void keyPressed() {
  if (key == CODED) { 
    if (keyCode == LEFT) {
      brightness*=0.5;
    }  
    if (keyCode == RIGHT) {
      brightness*=2;
      brightness=min(brightness, 256);
    }
    if (keyCode == UP) {
      threshold+=5;
    }
    if (keyCode == DOWN) {
      threshold-=5;
    }
  }
  if(key==' '){
    for(int i=0;i<cam.pixels.length;i++){
      try{
      if(brightness(cam.pixels[i])>target.z){
        target=new PVector(i%cam.width,floor(i/cam.width),brightness(cam.pixels[i]));
      }
      }catch(Exception e){}
    }
  }
}