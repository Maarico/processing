import processing.video.*;

Capture cam;
FloatList red = new FloatList();
FloatList green = new FloatList();
FloatList blue = new FloatList();

float brightness = 1;
int counter = 0;

void setup() {
  background(255);
  size(1280, 720);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  }
  println(cameras[0]);
  cam = new Capture(this, cameras[0]);
  cam.start();
}      


void draw() {
  background(0);
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    if (counter==0) {
      for (int i=0; i<cam.pixels.length; i++) {
        red.set(i, red(cam.pixels[i]));
        green.set(i, green(cam.pixels[i]));
        blue.set(i, blue(cam.pixels[i]));
        println(i);
      }
    } else {
      for (int i=0; i<cam.pixels.length; i++) {
        red.add(i, red(cam.pixels[i]));
        green.add(i, green(cam.pixels[i]));
        blue.add(i, blue(cam.pixels[i]));
      }
    }
    counter++;
  }
  PImage temp = new PImage(cam.width, cam.height);
  temp.loadPixels();
  for (int i=0; i<temp.pixels.length; i++) {
    temp.pixels[i]=color(min(red.get(i)*brightness, 255), min(green.get(i)*brightness, 255), min(blue.get(i)*brightness, 255));
  }
  temp.updatePixels();
  image(temp, 0, 0);
  text(counter, 30, 30);
  text(brightness, 30, 60);
  text(round(frameRate), 30, 120);
}

void keyPressed() {
  if (key == CODED) { 
    if (keyCode == LEFT) {
      brightness*=0.5;
    }  
    if (keyCode == RIGHT) {
      brightness*=2;
    }
  }
  if (key == ' ') {
    red = new FloatList();
    green = new FloatList();
    blue = new FloatList();
    counter=0;
  }
}