class neural_net {
  vector[] activations;
  matrix[] weights;


  neural_net(IntList neuroncount) {
    activations=new vector[neuroncount.size()];
    weights=new matrix[neuroncount.size()-1];
    for (int i=0; i<neuroncount.size(); i++) {
      activations[i]=new vector(neuroncount.get(i));
    }
    for (int i=0; i<neuroncount.size()-1; i++) {
      weights[i]=new matrix(neuroncount.get(i), neuroncount.get(i+1));
    }
  }

  void display() {
    for (int i=0; i<activations.length; i++) {
      for (int j=0; j<activations[i].values.length; j++) {
        fill(activations[i].values[j]*255);
        ellipse(map(i+1, 0, activations.length+1, 0, width), map(j+1, 0, activations[i].values.length+1, height, 0), 10, 10);
      }
    }
  }

  void fwpropagate() {
    for (int i=0; i<weights.length; i++) {
      activations[i+1]=new vector(activations[i+1].dimension);
      activations[i].values[activations[i].dimension-1]=1;
      activations[i+1].add(activations[i].multiply(weights[i]));
    }
    activations[activations.length-1].values[activations[activations.length-1].dimension-1]=-1;
  }

  void newinput(float[] input) {
    vector temp=new vector(input.length);
    temp.fromarray(input);
    activations[0]=temp;
  }

  void bkpropagate() {
    vector newsigma;
    vector sigma=activations[activations.length-1].copy();
    matrix deltaw=multiply(activations[activations.length-2],sigma.multiply(-learningrate)).flip();
    vector ansvect = new vector(answer.length);
    ansvect.fromarray(answer);
    sigma.add(ansvect.multiply(-1));
    for(int i=activations.length-2;i>0;i--){
      newsigma=sigma.multiply(weights[i].flip());
      weights[i].add(deltaw);
      sigma=newsigma;
      deltaw=multiply(activations[i-1],sigma.multiply(-learningrate)).flip();
    }
    weights[0].add(deltaw);
    
    
    /*
    float[][][] deltaw = new float[weights.length][][];
    float[][] sigmas = new float[activations.length][];



    for (int i=0; i<weights.length; i++) {
      for (int j=0; j<weights[i].length; j++) {
        for (int k=0; k<weights[i][j].length; k++) {
          weights[i][j][k]+=deltaw[i][j][k]*learningrate;
        }
      }
    }*/
  }

  int getanswer() {
    float temp = -1;
    int tempans=-1;
    for (int i=0; i<activations[activations.length-1].dimension-1; i++) {
      if (activations[activations.length-1].values[i]>temp) {
        tempans=i;
        temp=activations[activations.length-1].values[i];
      }
    }
    return tempans;
  }
}