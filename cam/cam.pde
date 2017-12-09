import processing.video.*;

Capture cam;
ArrayList <PImage> image = new ArrayList();
float ar;
int active =-1;
int first;
int delay = 0;
boolean saving = false;
int maximages = 200;
int counter = 0;

void setup() {
  background(255);
  size(700, 700);
  surface.setResizable(true);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  }
  println(cameras[0]);
  cam = new Capture(this, cameras[0]);
  cam.start();
}      

void draw() {
  if (counter%100==0) {
    thread("caminteract");
  }
  if (image.size()==0) {
    background(255);
    textAlign(CENTER, CENTER);
    textSize(height*0.1);
    fill(0);
    text("lade Kamera", width*0.5, height*0.2);
    ellipse(map(sin(float(frameCount)/30), -1, 1, width*0.4, width*0.6), height/2+map(-cos(float(frameCount)/30), -1, 1, width*-0.1, width*0.1), 10, 10);
  }
  try {
    //thread("loadimg");
    while (image.size()>10) {
      image.remove(0);
    }
    image.get(image.size()-5).resize(width, round(width*ar));
    image(image.get(image.size()-5), 0, 0);
    fill(0);
    textSize(width*0.01);
    text(frameRate, width*0.5, height*0.01);
    if (saving) {
      //image.get(active).save("/out/out_"+active);
      if (sin(float(frameCount)*0.08)<0) {
        fill(255, 0, 0);
        ellipse(width*0.05, height*0.1, width*0.02, width*0.02);
      }
    }
  }
  catch(Exception e) {
    if (image.size()>0) {
      background(255);
      fill(0);
      text("noch "+ ((-millis()+first)/1000+delay) + " Sekunden \nbis Stream Beginn", width*0.5, height*0.45);
    }
  }
}


void keyPressed() {
  if (key==' ') {
    saving=!saving;
  }
}

void loadimg() {
  int temp = image.size();
  image.add(new PImage());
  image.set(temp, loadImage("/temp/temp_"+(active-3)+".png"));
}


void caminteract() {
  for (int i=0; i<1; i++) {
    if (cam.available() == true) {
      first=min(first, millis());
      cam.read();
      int temp = counter;
      counter+=1;
      cam.save("/temp/temp_"+temp+".png");
      ar=float(cam.height)/float(cam.width);
      surface.setSize(width, round(width*ar));
    }
    if (millis()-first>delay*1000) {
      active+=1;
    }
  }
}