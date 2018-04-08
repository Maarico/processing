class vector {
  float[] values;
  int dimension;

  vector(int a) {
    values=new float[a];
    dimension = a;
  }

  void add(vector a) {
    if (dimension==a.dimension) {
      for (int i=0; i<values.length; i++) {
        values[i]+=a.values[i];
      }
    }
  }

  void randomize(float a, float b) {
    for (int i=0; i<values.length; i++) {
      values[i]=random(a, b);
    }
  }
  vector multiply(float a) {
    vector temp = new vector(dimension);
    for (int i=0; i<values.length; i++) {
      temp.values[i]=values[i]*a;
    }

    return temp;
  }
  vector multiply(matrix a) {
    vector temp = new vector(a.dimensions.get(1));
    if (a.values.length==values.length) {
      for (int i=0; i<values.length; i++) {
        temp.add(a.values[i].multiply(values[i]));
      }
    }else{println("vectormultiplydimerror");}
    return temp;
  }
  


  void fromarray(float[] a) {
    for (int i=0; i<a.length; i++) {
      values[i]=a[i];
    }
  }

  vector copy() {
    vector temp = new vector(dimension);
    temp.fromarray(values);
    return temp;
  }
  float sum(){
    float temp =0;
    for(int i=0;i<values.length;i++){
      temp+=values[i];
    }
    return temp;
  }
}