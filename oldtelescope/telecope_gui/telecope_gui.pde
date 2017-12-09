import interfascia.*;
import processing.video.*;

Capture cam;

PVector target = new PVector();

int threshold = 100;
int brightthres = 10;

float[] red;
float[] green;
float[] blue;

String mode;


ArrayList <PImage> images = new ArrayList();
int amount = 500;
float brightness = 1;


GUIController main;


IFCheckBox targeting;


GUIController targetcontrol;

IFLabel brightthresdisp;

void setup() {
  size(1000, 700);
  background(255);
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    exit();
  }
  println(cameras.length);
  cam = new Capture(this, cameras[0]);
  cam.start();
  
  main = new GUIController(this);
  targetcontrol = new GUIController(this,false);
  
  mode="viewimage";
  
  brightthresdisp = new IFLabel(brightthres+"",30,60);
  
  targeting = new IFCheckBox ("select target", 30, 30);
  targeting.addActionListener(this);
  
  main.add(targeting);
  targetcontrol.add(brightthresdisp);
  
}

void draw() {
  background(255);
  image(cam, 0, 0);
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    int targeti = round((target.y+threshold/2)*cam.width+(target.x+threshold/2));
    PVector avg = new PVector(target.x, target.y);
    for (int i=0; i<threshold; i++) {
      for (int j=0; j<threshold; j++) {
        try {
          int pixeli=targeti-width*i-j;
          if (brightness(cam.pixels[pixeli])>brightthres) {
            avg.add(new PVector(((target.x+threshold/2)-j)*brightness(cam.pixels[pixeli]), ((target.y+threshold/2)-i)*brightness(cam.pixels[pixeli]), brightness(cam.pixels[pixeli])));
          }
        }
        catch(Exception e) {
        }
      }
    }
    target.lerp(avg.div(avg.z),1);
  }
  fill(255, 0, 0);
  ellipse(target.x, target.y, 5, 5);
  noFill();
  stroke(255, 0, 0);
  rect(target.x-threshold/2, target.y-threshold/2, threshold, threshold);

}

void actionPerformed (GUIEvent e) {
  if(e.getSource()==targeting){
    if(targeting.isSelected()){
      mode=("targeting");
      targetcontrol.setVisible(true);
    }else{
      mode=("viewimage");
      targetcontrol.setVisible(false);
    }
  }
}

void mouseClicked(){
  if(mode=="targeting"){
     target=new PVector(mouseX,mouseY);
  }
}