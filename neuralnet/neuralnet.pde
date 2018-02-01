IntList configuration = new IntList(1, 1, 1);
neural_net net ;
float stepsize = 0.001;
PImage current;

int answer;
int guesses=1;

int stepevery=50;

String saveloadas="net1.csv";

void setup() {
  fullScreen();
  //size(700,700);
  background(255);
  net= new neural_net();
  guicontrollers.add(new guicontroller(true, "main"));
  guicontrollers.get(0).addbutton(new button(50, 30, 80, 20, "save net", "savenet"));
  guicontrollers.get(0).addbutton(new button(50, 80, 80, 20, "load net", "loadnet"));
  guicontrollers.get(0).addbutton(new button(50, 130, 80, 20, "random net", "randomnet"));
  guicontrollers.get(0).addbutton(new button(50, 180, 80, 20, "new input", "newinput"));
}

void draw() {
  background(255);
  try {
    net.calculate();
  }
  catch(Exception e) {
    println("calculate error");
  }

  try {
    image(current, width/2, 30);
    fill(0);
    textAlign(LEFT, CENTER);
    text("correct answer: "+answer, 0.6*width, 45);
    text("guess: "+net.getanswer(), 0.6*width, 35);
    text("guesses: "+guesses, 0.6*width, 55);
    net.calcgradient();
    if (guesses%stepevery==0) {
      net.learn();
    }
    guesses++;
  }
  catch(Exception e) {
    println("image error");
  }

  for (int i=0; i<guicontrollers.size(); i++) {
    guicontrollers.get(i).display();
  }


  try {
    //newinput();
  }
  catch(Exception e) {
    println("input error");
  }
  net.display();
  //delay(500);
}




void newinput() {
  //answer = floor(random(0,10));
  //answer=floor(random(0,2));
  answer=1-answer;
  current=loadImage("data/digits/"+answer+"/digit-"+floor(random(0, 5500))+".png");
  FloatList temp = new FloatList();
  current.loadPixels();
  for (int i=0; i<net.layers.get(0).neurons.size(); i++) {
    temp.append(map(brightness(current.pixels[i]), 0, 255, 0, 1));
  }
  //net.input(temp);
  if (answer==0) {
    net.input(new FloatList(1, 0));
  } else {
    net.input(new FloatList(0, 1));
  }
}