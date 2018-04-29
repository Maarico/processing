class copter {
  PVector pos;
  PVector vel;
  float rot;
  float rotvel;
  float error=0;
  float mutativity;
  float mutationprob;
  neural_net brain = new neural_net(new IntList(6, 20, 20, 2));

  copter(float a, float b, float c, float d, float e, float f, float g, float h) {
    pos = new PVector(a, b);
    vel=new PVector(c, d);
    rot=e;
    rotvel=f;
    brain.randomize();
    mutativity=g;
    mutationprob=h;
  }

  void show() {
    noFill();
    translate(pos.x, pos.y);
    rotate(rot);
    rect(-dimensions.x*0.5, -dimensions.y*0.5, dimensions.x, dimensions.y);
    textAlign(CENTER);
    fill(0);
    text(error, 0, 0);
    rotate(-rot);
    translate(-pos.x, -pos.y);
  }

  void move() {
    brain.newinput(new FloatList(target.x-pos.x, target.y-pos.y, vel.x, vel.y, rot, rotvel));
    brain.calc();
    FloatList ctrlseq=brain.getout();
    vel.add(new PVector(sin(rot)*(ctrlseq.get(0)+ctrlseq.get(1)), -cos(rot)*(ctrlseq.get(0)+ctrlseq.get(1))).mult(power));
    rotvel+=power*0.01*(ctrlseq.get(0)-ctrlseq.get(1));
    pos.add(vel);
    vel.add(gravity);
    rot+=rotvel;
    error=dist(pos.x, pos.y, target.x, target.y);
  }
  void mutate() {
    brain.mutate(mutativity, mutationprob);
    /*if (mutationprob>random(0, 1)) {
      mutativity+=random(-mutativity, mutativity);
    }
    if (mutationprob>random(0, 1)) {
      mutationprob+=random(-mutativity, mutativity);
    }*/
  }

  copter copy() {
    copter temp = new copter(pos.x, pos.y, vel.x, vel.y, rot, rotvel,mutativity,mutationprob);
    temp.brain=brain.copy();
    return temp;
  }

  void restart() {
    pos=new PVector(width/2,height/2);//random(0,width),random(0,height));
    vel=new PVector();
    rot=0;
    rotvel=0;
  }
}