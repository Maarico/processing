class synapse {
  PVector start, destination;
  float amplifier, gradient;

  synapse(int a, int b, int c, int d) {
    start = new PVector(a, b);
    destination=new PVector(c, d);
  }

  void setamplifier(float a) {
    amplifier=a;
  }

  void convey() {
    net.layers.get(round(destination.x)).neurons.get(round(destination.y)).addinput(amplifier*net.layers.get(round(start.x)).neurons.get(round(start.y)).activation);
  }

  void conveydesired() {
    net.layers.get(round(start.x)).neurons.get(round(start.y)).desiredact+=net.layers.get(round(destination.x)).neurons.get(round(destination.y)).desiredact/amplifier;
  }

  void calcgradient() {
    if (!(abs(net.layers.get(round(start.x)).neurons.get(round(start.y)).activation)<0.1)) {
      neuron destneuron = net.layers.get(round(destination.x)).neurons.get(round(destination.y));
      neuron startneuron = net.layers.get(round(start.x)).neurons.get(round(start.y));
      float desiredamp = (destneuron.desiredact-destneuron.activation)/startneuron.activation;
      gradient+=(desiredamp)*stepsize;
    }
  }

  void applygradient() {
    amplifier+=gradient;
    gradient=0;
  }

  void display() {
    stroke(map(amplifier, -1, 1, 0, 255));
    line(net.layers.get(round(start.x)).neurons.get(round(start.y)).x, net.layers.get(round(start.x)).neurons.get(round(start.y)).y, net.layers.get(round(destination.x)).neurons.get(round(destination.y)).x, net.layers.get(round(destination.x)).neurons.get(round(destination.y)).y);
    fill(0);
    text(amplifier+","+gradient, lerp(net.layers.get(round(start.x)).neurons.get(round(start.y)).x, net.layers.get(round(destination.x)).neurons.get(round(destination.y)).x, 0.5), lerp(net.layers.get(round(start.x)).neurons.get(round(start.y)).y, net.layers.get(round(destination.x)).neurons.get(round(destination.y)).y, 0.5));
  }
}