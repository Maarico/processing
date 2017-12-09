import themidibus.*;
import javax.sound.midi.MidiMessage;

MidiBus myBus;

String[] names=new String[12];
names=("a";"b");

PVector leftbounds=new PVector(44,55);
PVector rightbounds=new PVector(44,55);

int currentColor = 0;

IntList leftnotes = new IntList();
IntList rightnotes = new IntList();

boolean[] pressed = new boolean[88];


void setup() {
  fullScreen();
  myBus = new MidiBus(this, 0, 3);
}

void draw() {
  background(255);
  boolean[] truekeys = new boolean[88];
  for(int i=0;i<leftnotes.size();i++){
    truekeys[leftnotes.get(i)]=true;
  }
  for(int i=0;i<rightnotes.size();i++){
    truekeys[rightnotes.get(i)]=true;
  }
  boolean right=true;
  for(int i=0;i<pressed.length;i++){
    if(pressed[i]!=truekeys[i]){
      right=false;
    }
  }
  if(right){
    newnotes();
  }
  
  for(int i=0;i<pressed.length;i++){
    
  }
}

void midiMessage(MidiMessage message, long timestamp, String bus_name) { 
  int on = (((int)(message.getMessage()[0] & 0xFF))-128)/16 ;
  int note = (int)(message.getMessage()[1] & 0xFF)-21 ;
  int vel = (int)(message.getMessage()[2] & 0xFF);

  pressed[note]=on==1;
  //println(on+" Bus " + bus_name + ": Note "+ note + ", vel " + vel);
  if (vel > 0 ) {
    currentColor = vel*2;
  }
}


void newnotes(){
  
}