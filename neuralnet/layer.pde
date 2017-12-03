class layer{
  ArrayList <neuron> neurons =new ArrayList();
  float depth;
  int amount;
  layer(float a,int b){
    depth=a;
    amount=b;
    for(int i=0;i<amount;i++){
      neurons.add(new neuron(depth*width,map(i+1,0,amount+1,height*0.1,height*0.90),height/amount*0.5));
    }
  }
  
  void randomizelayer(){
    for(int i=0;i<neurons.size();i++){
      neurons.get(i).setbias(random(-1,1));
    }
  }
  
  void setbiases(FloatList a){
    for(int i=0;i<a.size();i++){
      neurons.get(i).setbias(a.get(i));
    }
  }
  
  void display(){
    for(int i=0;i<neurons.size();i++){
      neurons.get(i).display();
    }
  }
  
  void setactivation(){
    for(int i=0;i<neurons.size();i++){
      neurons.get(i).setactivation();
    }
  }
  
  void calcgradient(){
    for(int i=0;i<neurons.size();i++){
      neurons.get(i).calcgradient();
    }
  }
  
  void applygradient(){
    for(int i=0;i<neurons.size();i++){
      neurons.get(i).applygradient();
    }
  }
}