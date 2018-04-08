float bodymass = 5.972 * pow(10, 24);
float gravityconst = 6.7 * pow(10, -11);
float rocketmass = 10000;
float rocketisp = 2000;
float rocketdmass = 0;
float rocketdrymass =2000;
PVector currentstate = new PVector(6525140, 7014.0140862802, 200);
PVector desiredstate=new PVector(6528140, 7814.0140862802, 0);
float dt = 2;
float acc=5;
PVector bestguide= new PVector(PI/4,0,1000);


void setup() {
  size(700, 700);
  background(255);
}

void draw() {
  background(255);
  ellipse(width/2, map(currentstate.x, 6000000, desiredstate.x*1.5, height, 0), 10, 10);
  PVector newbestguide=new PVector();/*
  for (float t=bestguide.z-acc*100; t<=bestguide.z+acc*100; t+=acc) {
    for (float i=bestguide.x-acc*0.2; i<bestguide.x+acc*0.2; i+=acc*0.01) {
      for (float j=bestguide.y-acc*0.2; j<bestguide.y+acc*0.2; j+=acc*0.01) {
        if (orbitpred(currentstate, i, j, t, rocketmass).dist(desiredstate)<orbitpred(currentstate,newbestguide.x,newbestguide.y,newbestguide.z,rocketmass).dist(desiredstate)) {
          newbestguide=new PVector(i, j, t);
        }
      }
    }
  }
  bestguide=newbestguide;
  println(bestguide,orbitpred(currentstate,newbestguide.x,bestguide.y,bestguide.z,rocketmass));
  acc*=0.5;
  dt*=0.5;*/
  println(orbit
}

PVector orbitpred(PVector state, float theta, float dtheta, float time, float mass) {
  if(time<0){
    return new PVector(-10000000,-100000000);
  }
  for (float i=0; i<time&&mass>=rocketdrymass; i+=dt) {
    float newalt=state.x+state.z*dt;
    PVector coriolis = new PVector(0, 0, state.y/state.x).cross(new PVector(state.y, state.z, 0));
    float newvx= state.y+coriolis.x*dt+cos(theta)*rocketisp*rocketdmass*dt/mass;
    float newvy=state.z-coriolis.y*dt-(bodymass*gravityconst)/(state.x*state.x)*dt+sin(theta)*rocketisp*rocketdmass*dt/mass;
    mass-=rocketdmass*dt;
    theta+=dtheta;
    state=new PVector(newalt, newvx, newvy);
  }
  return state;
}