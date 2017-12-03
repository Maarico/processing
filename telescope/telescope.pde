import processing.video.*;

Capture cam; //the Object through wich to controll the camera

PImage display; //the Image wich will be displayed at the end of draw

String mode="longexposure"; //the mode the program is in right now

int maximages = 100; //amount of images after wich images will be deleted if mode=longexposure

ArrayList <PImage> cachedimages = new ArrayList(); //images wich are remembered to be able to delete them out of long exposure

float[] RED;
float[] GREEN;
float[] BLUE; // the 3 arrays in wich the long exposure is saved


void setup() {
  size(1280, 720);

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {

    cam = new Capture(this, cameras[0]); //initialisation of camera object
    cam.start();     

    RED = new float[width*height]; 
    GREEN = new float[width*height];
    BLUE = new float[width*height]; // initialisation of arrays
  }
  
}
  


void draw() {
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
  }
  try{
  display = processimage();

  image(display, 0, 0);
  }catch(Exception e){println(e);}
}