class neural_net {
  ArrayList <layer> layers = new ArrayList();
  ArrayList <synapselayer> synapselayers = new ArrayList();


  neural_net() {
  }

  void savenet(String a) {
    Table neurontable = new Table();
    neurontable.setColumnCount(layers.size());
    for (int i=0; i<layers.size(); i++) {
      neurontable.setInt(0, i, layers.get(i).neurons.size());
      for (int j=0; j<layers.get(i).neurons.size(); j++) {
        neurontable.setFloat(j+1, i, layers.get(i).neurons.get(j).bias);
      }
    }
    Table synapsetable = new Table();
    synapsetable.setColumnCount(layers.size());
    for (int i=0; i<synapselayers.size(); i++) {
      synapsetable.setInt(0, i, synapselayers.get(i).synapses.size());
      for (int j=0; j<synapselayers.get(i).synapses.size(); j++) {
        synapsetable.setFloat(j+1, i, synapselayers.get(i).synapses.get(j).amplifier);
      }
    }


    saveTable(neurontable, "data/neurons_"+a);
    saveTable(synapsetable, "data/synapses_"+a);
  }

  void getnet(String a) {

    layers=new ArrayList();
    synapselayers=new ArrayList();
    Table neurontable = loadTable("data/neurons_"+a);

    for (int i=0; i<neurontable.getColumnCount(); i++) {
      layers.add(new layer(float(i+1)/float(neurontable.getColumnCount()+1), neurontable.getInt(0, i)));
      FloatList temp = new FloatList();
      for (int j=1; j<=neurontable.getInt(0, i); j++) {
        temp.append(neurontable.getFloat(j, i));
      }
      layers.get(layers.size()-1).setbiases(temp);
    }

    afterinit();

    Table synapsetable = loadTable("data/synapses_"+a);

    for (int i=0; i<synapsetable.getColumnCount()-1; i++) {
      FloatList temp = new FloatList();
      for (int j=1; j<=synapsetable.getInt(0, i); j++) {
        temp.append(synapsetable.getFloat(j, i));
      }
      synapselayers.get(i).setamplifiers(temp);
    }
  }

  void randomnet(IntList a) {
    layers=new ArrayList();
    synapselayers=new ArrayList();
    for (int i=0; i<a.size(); i++) {
      layers.add(new layer(float(i+1)/float(a.size()+1), a.get(i)));
      layers.get(layers.size()-1).randomizelayer();
    }
    afterinit();
    for (int i=0; i<synapselayers.size(); i++) {
      synapselayers.get(i).randomizelayer();
    }
  }

  void afterinit() {
    for (int i=0; i<layers.size()-1; i++) {
      synapselayers.add(new synapselayer(i, i+1));
    }
  }

  void display() {
    for (int i=0; i<layers.size(); i++) {
      layers.get(i).display();
    }
    for (int i=0; i<synapselayers.size(); i++) {
      synapselayers.get(i).display();
    }
  }

  void calculate() {
    for (int i=0; i<synapselayers.size(); i++) {
      synapselayers.get(i).convey();
      layers.get(i+1).setactivation();
    }
  }

  void input(FloatList a) {
    for (int i=0; i<layers.get(0).neurons.size()&&i<a.size(); i++) {
      layers.get(0).neurons.get(i).activation=a.get(i);
    }
  }

  int getanswer() {
    ArrayList <neuron> outneurons=layers.get(layers.size()-1).neurons;
    int best=-1;
    float bestval=0;
    for (int i=0; i<outneurons.size(); i++) {
      if (outneurons.get(i).activation>bestval) {
        best=i;
        bestval=outneurons.get(i).activation;
      }
    }
    return best;
  }

  void calcgradient() {
    ArrayList <neuron> outneurons=layers.get(layers.size()-1).neurons;
    for (int i=0; i<outneurons.size(); i++) {
      if (i==answer) {
        outneurons.get(i).desiredact=1;
      } else {
        outneurons.get(i).desiredact=0;
      }
    }
    for (int i=synapselayers.size()-1; i>=0; i--) {
      synapselayers.get(i).conveydesired();
      synapselayers.get(i).calcgradient();
    }
    for (int i=layers.size()-2; i>=0; i--) {
      layers.get(i).calcgradient();
    }
  }

  void learn() {
    for (int i=synapselayers.size()-1; i>=0; i--) {
      synapselayers.get(i).applygradient();
    }
    for (int i=synapselayers.size()-1; i>=0; i--) {
      layers.get(i).applygradient();
    }
    println("learned");
  }
}