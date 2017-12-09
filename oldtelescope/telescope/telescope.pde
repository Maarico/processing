import processing.video.*;

Capture cam;

float[] red;
float[] green;
float[] blue;

boolean active = false;

ArrayList <PImage> images = new ArrayList();
int amount = 500;
float brightness = 1;

void setup() {
  background(255);
  size(1280, 720);
  String[] cameras = Capture.list();
  images = new ArrayList();

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
    images.add(cam.copy());
    if (amount>0) {
      while (images.size()>amount) {
        PImage last = images.get(0);
        last.loadPixels();
        for (int i=0; i<last.pixels.length; i++) {
          red[i]-=red(last.pixels[i]);
          green[i]-=green(last.pixels[i]);
          blue[i]-=blue(last.pixels[i]);
        }
        images.remove(0);
      }
    }
    if (!active) {
      try {
        red=new float[cam.width*cam.height];
        green=new float[cam.width*cam.height];
        blue=new float[cam.width*cam.height];
        for (int i=0; i<cam.pixels.length; i++) {
          red[i]=red(cam.pixels[i]);
          green[i]=green(cam.pixels[i]);
          blue[i]=blue(cam.pixels[i]);
        }
        active=true;
      }
      catch(Exception e) {
      }
    } else {
      for (int i=0; i<cam.pixels.length; i++) {  
        red[i]+=red(cam.pixels[i]);
        green[i]+=green(cam.pixels[i]);
        blue[i]+=blue(cam.pixels[i]);
      }
    }
  }
  if (images.size()>0) {
    PImage temp = new PImage(cam.width, cam.height);
    temp.loadPixels();
    for (int i=0; i<temp.pixels.length; i++) {
      temp.pixels[i]=color(min(red[i]*brightness, 255), min(green[i]*brightness, 255), min(blue[i]*brightness, 255));
    }
    temp.updatePixels();
    image(temp, 0, 0);
    text(amount, 30, 30);
    text(brightness, 30, 60);
    text(images.size(), 30, 90);
    text(round(frameRate), 30, 120);
    text(memoryusage(),30,150);
  }
}

float memoryusage(){
  float total =Runtime.getRuntime().totalMemory();
  float max = Runtime.getRuntime().maxMemory();
  return total/max;

}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      amount++;
    }  
    if (keyCode == DOWN) {
      amount--;
    }  
    if (keyCode == LEFT) {
      brightness*=0.5;
    }  
    if (keyCode == RIGHT) {
      brightness*=2;
      brightness=min(brightness, 256);
    }
  }
}