PVector dimensions=new PVector(40, 10);

PVector gravity = new PVector(0, 0.1, 0);

PVector target=new PVector(350, 350);

int generations=0;

int popsize = 100;

float timepergen = 5;

int starttime=0;

float power= 1;

float removeprob=0.2;

ArrayList <copter> copters = new ArrayList();

void setup() {
  size(700, 700);
  background(255);
  for (int i=0; i<popsize; i++) {
    copters.add(new copter(0, 0, 0, 0, 0, 0, 0.1, 0.1));
    copters.get(i).restart();
  }
}


void draw() {
  background(255);
  fill(0);
  text(generations,30,30);
  text(round(timepergen-(millis()-starttime)/1000),30,60);
  for (int i=0; i<copters.size(); i++) {
    copters.get(i).show();
  }
  if ((millis()-starttime)/1000>timepergen) {
    newgen();
  } else {
    rungen();
  }

  fill(255, 0, 0);
  ellipse(target.x, target.y, 10, 10);
}

void newgen() {
  generations++;
  ArrayList <copter> ordered = new ArrayList();
  int startsize=copters.size();
  for (int i=0; i<startsize; i++) {
    float best = 1e10;
    int bestin = -1;
    for (int j=0; j<copters.size(); j++) {
      if (copters.get(j).error<best) {
        best=copters.get(j).error;
        bestin=j;
      }
    }
    ordered.add(copters.get(bestin));
    copters.remove(bestin);
  }

  ArrayList <copter> newgeneration = new ArrayList();

  for (int i=0; i<startsize-1; i++) {
    int temp=round((ordered.size()-1)*pow(random(0, 1), 5));
    newgeneration.add(ordered.get(temp));
    if (removeprob>random(0, 1)) {
      ordered.remove(temp);
    }
  }

  for (int i=0; i<newgeneration.size(); i++) {
    newgeneration.get(i).mutate();
  }


  newgeneration.add(ordered.get(0));


  copters=new ArrayList();

  for (int i=0; i<newgeneration.size(); i++) {
    copters.add(newgeneration.get(i).copy());
  }

  for (int i=0; i<copters.size(); i++) {
    copters.get(i).restart();
  }
  starttime = millis();
}

void rungen() {
  for (int i=0; i<copters.size(); i++) {
    copters.get(i).move();
  }
}

void keyPressed(){
  if(key==CODED){
    if(keyCode==UP){
      timepergen++;
    }
    if(keyCode==DOWN){
      timepergen--;
    }
  }
}