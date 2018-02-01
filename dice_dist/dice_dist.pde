int dice=10;

int total = 0;

float scaling = 100;

IntList count = new IntList();

int throwsperdraw = 10000;

boolean shapemode = true;



void setup() {
  background(255);
  size(1080,720);
  for (int i=dice-1; i<dice*6; i++) {
    count.append(0);
  }
}


void draw() {
  background(255);
  fill(255);
  if (shapemode) {
    beginShape();
    for (int i=0; i<count.size(); i++) {
      vertex(map(float(i+1)/float(count.size()+1), 0, 1, 0, width), map(count.get(i), 0, count.max(), height, 0));
    }
    endShape();
  } else {
    for (int i=0; i<count.size(); i++) {
      rect(map(float(i+1)/float(count.size()+1), 0, 1, 0, width), height, 5, -map(count.get(i), 0, count.max(), 0, height));
    }
  }
  for (int j=0; j<throwsperdraw; j++) {
  total++;
    int temp = 0;
    for (int i=0; i<dice; i++) {
      temp+=floor(random(1, 7));
    }

    count.add(temp-dice, 1);
  }
  fill(0);
  text(min(max(floor(map(mouseX,0,width,0,1)*(count.size()+1)+dice-0.5),dice),dice*6),mouseX,mouseY);
  text(round(frameRate)+" fps",30,30);
  text("most frequent #: "+(dice-1+count.maxIndex()+1),30,45);
  text(100*float(count.max())/float(total)+"%of all throws hitting most frequent #: ",30,60);
  text(total + " total throws",30,75);
  text(dice+" dice",30,90);
}


void keyPressed() {
  if (key==' ') {
    shapemode=!shapemode;
  }
}