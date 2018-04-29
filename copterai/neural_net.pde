class neural_net {
  ArrayList <float[]> weights = new ArrayList();
  ArrayList <float[]> biasses = new ArrayList();
  ArrayList <float[]> values= new ArrayList();

  neural_net(IntList configuration) {
    for (int i=0; i<configuration.size(); i++) {
      if (i>0) {
        weights.add(new float[configuration.get(i-1)*configuration.get(i)]);
        biasses.add(new float[configuration.get(i)]);
      }
      values.add(new float[configuration.get(i)]);
    }
  }

  void randomize() {
    for (int i=0; i<weights.size(); i++) {
      for (int j=0; j<weights.get(i).length; j++) {
        weights.get(i)[j]=random(-1, 1);
      }
      for (int j=0; j<biasses.get(i).length; j++) {
        biasses.get(i)[j]=random(-1, 1);
      }
    }
  }

  void newinput(FloatList inputs) {
    if (inputs.size()==values.get(0).length) {
      for (int i=0; i<inputs.size(); i++) {
        values.get(0)[i]=inputs.get(i);
      }
    }
  }

  void calc() {
    for (int i=1; i<values.size(); i++) {
      for (int j=0; j<values.get(i).length; j++) {
        values.get(i)[j]=biasses.get(i-1)[j];
        for (int k=0; k<values.get(i-1).length; k++) {
          values.get(i)[j]+=values.get(i-1)[k]*weights.get(i-1)[k*j];
        }
        values.get(i)[j]=1/(1+exp(-values.get(i)[j]));
      }
    }
  }
  FloatList getout() {
    FloatList temp = new FloatList();
    for (int i=0; i<values.get(values.size()-1).length; i++) {
      temp.append(values.get(values.size()-1)[i]);
    }
    return temp;
  }

  neural_net copy() {
    neural_net temp = new neural_net(new IntList());
    for (int i=0; i<biasses.size(); i++) {
      temp.biasses.add(new float[biasses.get(i).length]);
      for(int j=0;j<biasses.get(i).length;j++){
        temp.biasses.get(i)[j]=biasses.get(i)[j];
      }
      temp.weights.add(new float[weights.get(i).length]);
      
      for(int j=0;j<weights.get(i).length;j++){
        temp.weights.get(i)[j]=weights.get(i)[j];
      }
    }
    for(int i=0;i<values.size();i++){
      temp.values.add(new float[values.get(i).length]);
    }
    return temp;
  }

  void mutate(float rate, float prob) {
    for (int i=0; i<weights.size(); i++) {
      for (int j=0; j<weights.get(i).length; j++) {
        if (prob>random(0, 1)) {
          weights.get(i)[j]+=random(-rate, rate);
        }
      }
      for (int j=0; j<biasses.get(i).length; j++) {
        if (prob>random(0, 1)) {
          biasses.get(i)[j]+=random(-rate, rate);
        }
      }
    }
  }
}