import processing.video.*;

Capture cam;

PImage temp= new PImage(1280, 720);

float error;

int counter;

int lasttime;

void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();
  cam = new Capture(this, cameras[0]);
  cam.start();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  cam.loadPixels();
  temp.loadPixels();
  error = 0;
  for (int i=0; i<temp.width*temp.height; i++) {
    try {
      if (dist(red(cam.pixels[i]), green(cam.pixels[i]), blue(cam.pixels[i]), red(temp.pixels[i]), green(temp.pixels[i]), blue(temp.pixels[i]))>100) {
        error++;
      }
    }
    catch(Exception e) {
    }
  }
  if (error>100) {
    if(lasttime==second()){
      counter++;
    }else{
      counter=0;
    }
    saveFrame("out/"+month()+"/"+day()+"/"+hour()+":"+minute()+":"+second()+"_"+counter+".jpg");
    lasttime=second();
  }
  image(cam, 0, 0);
  //text(hour()+":"+minute()+":"+second(), 30, 30);
  temp=cam.copy();
}