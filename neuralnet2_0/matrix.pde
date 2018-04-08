
class matrix {
  vector[] values;
  IntList dimensions;

  matrix(int a, int b) {
    dimensions=new IntList(a, b);
    values = new vector[a];
    for (int i=0; i<a; i++) {
      values[i]=new vector(b);
      values[i].randomize(-1, 1);
    }
  }
  void add(matrix a) {
    if (a.dimensions.get(0)==dimensions.get(0)&&a.dimensions.get(1)==dimensions.get(1)) {
      for (int i=0; i<values.length; i++) {
        values[i].add(a.values[i]);
      }
    } else {
      println("matrixadddimensionerror");
      println(a.dimensions,dimensions);
    }
  }
  /*
  matrix multiply(vector a) {
    matrix temp = new matrix(dimensions.get(0),dimensions.get(1));
    for(int i=0;i<values.length;i++){
      temp.values[i]=values[i].multiply(a.values[i]);
    }
    return temp;
  }*/
  
  matrix flip(){
    matrix temp = new matrix(dimensions.get(1),dimensions.get(0));
    for(int i=0;i<values.length;i++){
      for(int j=0;j<values[i].values.length;j++){
        temp.values[j].values[i]=values[i].values[j];
      }
    }
    return temp;
  }
}

matrix multiply(vector a, vector b){
  matrix temp = new matrix(b.dimension,a.dimension);
  for(int i=0;i<b.dimension;i++){
    temp.values[i]=a.multiply(b.values[i]);
  }
  return temp;
}