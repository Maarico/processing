import processing.video.*;

Capture cam;

PVector target = new PVector();

int threshold = 100;


float[] red;
float[] green;
float[] blue;

float brightness = 1;
int counter = 0;

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
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    int targeti = round((target.y+threshold/2)*cam.width+(target.x+threshold/2));
    PVector best = new PVector(target.x, target.y);
    for (int i=0; i<threshold; i++) {
      for (int j=0; j<threshold; j++) {
        try {
          int pixeli=targeti-width*i-j;
          if (brightness(cam.pixels[pixeli])>best.z) {
            best=new PVector((target.x+threshold/2)-j, (target.y+threshold/2)-i, brightness(cam.pixels[pixeli]));
          }
        }
        catch(Exception e) {
        }
      }
    }
    target=best;
    if (counter==0) {
      try {
        red=new float[cam.width*cam.height];
        green=new float[cam.width*cam.height];
        blue=new float[cam.width*cam.height];
        for (int i=0; i<cam.pixels.length; i++) {
          red[i]=red(cam.pixels[i]);
          green[i]=green(cam.pixels[i]);
          blue[i]=blue(cam.pixels[i]);
        }
        counter++;
      }
      catch(Exception e) {
      }
    } else {
      for (int i=0; i<cam.pixels.length; i++) {  
        red[i]+=red(cam.pixels[i]);
        green[i]+=green(cam.pixels[i]);
        blue[i]+=blue(cam.pixels[i]);
      }
      counter++;
    }
  }
  if (counter>0) {
    PImage temp = new PImage(cam.width, cam.height);
    temp.loadPixels();
    for (int i=0; i<temp.pixels.length; i++) {
      temp.pixels[i]=color(min(red[i]*brightness, 255), min(green[i]*brightness, 255), min(blue[i]*brightness, 255));
    }
    temp.loadPixels();
    image(temp, 0, 0);
  }
  fill(255);
  text(counter, 30, 30);
  text(round(target.z), 30,120);
  text(brightness, 30, 60);
  text(round(frameRate), 30,90);
  fill(0);
  text(counter, 90, 30);
  text(brightness, 90, 60);
  text(round(frameRate), 90,90);
  text(round(target.z), 90,120);
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
      brightness=min(brightness,256);
    }
    if (keyCode == UP) {
      threshold+=5;
    }
    if (keyCode == DOWN) {
      threshold-=5;
    }
  }
  if (key == ' ') {
    counter=0;
  }
}