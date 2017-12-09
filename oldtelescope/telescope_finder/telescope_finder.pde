import processing.video.*;

Capture cam;
ArrayList <PImage> images = new ArrayList();
int amount = 50;
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
    images.add(cam.copy());
    if(amount>0){
      while(images.size()>amount){
        images.remove(0);
      }
    }
  }
  if(images.size()>0){
    PImage end = new PImage(cam.width,cam.height);
    end.loadPixels();
    for(int i=0;i<images.size();i++){
      PImage temp = images.get(i);
      temp.loadPixels();
      for(int j=0;j<temp.pixels.length;j++){
        end.pixels[j]=color(min(red(temp.pixels[j])*brightness+red(end.pixels[j]),255),min(green(temp.pixels[j])*brightness+green(end.pixels[j]),255),min(blue(temp.pixels[j])*brightness+blue(end.pixels[j]),255));
      }
    }
    end.updatePixels();
  image(end, 0, 0);
  text(amount,30,30);
  text(brightness,30,60);
  text(images.size(),30,90);
  text(round(frameRate),30,120);
  }
}

void keyPressed(){
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
    }  
  }
}