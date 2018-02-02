class neuron {
  float activation=0;
  float x, y, dia, bias, desiredact, gradient, lastdes;
  FloatList inputs = new FloatList();
  neuron(float a, float b, float c) {
    x=a;
    y=b;
    dia=c;
    desiredact=0;
    gradient=0;
  }

  void setbias(float a){
    bias=a;
  }

  void display() {
    fill(activation*255);
    stroke(0);
    ellipse(x, y, dia, dia);
    //fill(255);
    //text(activation+","+gradient+","+lastdes,x,y);
  }

  void setactivation() {
    float temp=0;//bias;
    for (int i=0; i<inputs.size(); i++) {
      temp+=inputs.get(i);
    }
    activation=1/(1+exp(-temp));
    inputs= new FloatList();
  }
  
  void calcgradient(){
    gradient+=desiredact-activation;
    lastdes=desiredact;
    desiredact=0;
  }
  
  void applygradient(){
    bias+=gradient*stepsize;
    gradient=0;
  }

  void addinput(float a) {
    inputs.append(a);
  }
}