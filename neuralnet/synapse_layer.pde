class synapselayer {
  ArrayList <synapse> synapses = new ArrayList();
  synapselayer(int a, int b) {
    for (int i=0; i<net.layers.get(a).neurons.size(); i++) {
      for (int j=0; j<net.layers.get(b).neurons.size(); j++) {
        synapses.add(new synapse(a, i, b, j));
      }
    }
  }

  void randomizelayer() {
    for (int i=0; i<synapses.size(); i++) {
      synapses.get(i).setamplifier(random(-0.1, 0.1));
    }
  }
  

  void setamplifiers(FloatList a) {

    if (a.size()!=synapses.size()) {
      println(a.size(), synapses.size());
      exit();
    }

    for (int i=0; i<a.size(); i++) {
      synapses.get(i).setamplifier(a.get(i));
    }
  }

  void display() {
    for (int i=0; i<synapses.size(); i++) {
      synapses.get(i).display();
    }
  }

  void convey() {
    for (int i=0; i<synapses.size(); i++) {
      synapses.get(i).convey();
    }
  }
  
  void conveydesired(){
    for (int i=0; i<synapses.size(); i++) {
      synapses.get(i).conveydesired();
    }
  }
  
  void calcgradient(){
    for (int i=0; i<synapses.size(); i++) {
      synapses.get(i).calcgradient();
    }
  }
  
  void applygradient(){
    for (int i=0; i<synapses.size(); i++) {
      synapses.get(i).applygradient();
    }
  }
  
}