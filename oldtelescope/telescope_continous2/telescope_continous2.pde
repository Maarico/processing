import processing.video.*;

Capture cam;


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
  text(brightness, 30, 60);
  text(round(frameRate), 30,90);
  fill(0);
  text(counter, 90, 30);
  text(brightness, 90, 60);
  text(round(frameRate), 90,90);
  
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
  }
  if (key == ' ') {
    counter=0;
  }
}