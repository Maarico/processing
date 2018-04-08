IntList netsetup = new IntList(28*28,30,30,10);
neural_net net = new neural_net(netsetup);
float[] answer;
float learningrate = 0.0005;
PImage inputim;
  
void setup(){
  size(700,700);
  background(255);
}

void draw(){
  int ans = floor(random(0,10));
  inputim=loadImage("data/"+ans+"/digit-"+floor(random(0,1000))+".png");
  inputim.loadPixels();
  answer = new float[10];
  for(int i=0;i<answer.length;i++){
    if(i==ans){
      answer[i]=1;
    }
  }
  float[] inarray = new float[inputim.pixels.length];
  for(int i=0;i<inputim.pixels.length;i++){
    inarray[i]=map(brightness(inputim.pixels[i]),0,255,0,1);
  }
  net.newinput(inarray);
  background(255);
  net.display();
  net.fwpropagate();
  net.bkpropagate();
  fill(0);
  text("answer:"+ans,30,30);
  text("guess:"+net.getanswer(),30,60);
}