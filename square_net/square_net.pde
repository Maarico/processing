Table connections = new Table();
float dampener=0.9;
float forceconst = 0.01;
float conconst = 0.002;
ArrayList <number> numbers = new ArrayList();

void setup() {
  size(700, 700);
  background(255);
  textAlign(CENTER,CENTER);
}

void draw() {
  background(255);
  for(int i=0;i<numbers.size();i++){
    numbers.get(i).display();
    numbers.get(i).force();
  }
  for(int i=0;i<numbers.size();i++){
    numbers.get(i).move();
  }
  
  for(int i=0;i<connections.getColumnCount();i++){
    for(int j=0;j<connections.getRowCount();j++){
      if(connections.getInt(j,i)==1){
        line(numbers.get(i).pos.x,numbers.get(i).pos.y,numbers.get(j).pos.x,numbers.get(j).pos.y);
      }
    }
  }
  
  if(frameCount%20==0){
    newnumber();
  }
  
  
}

boolean hasconnection(){
   for(int i = 0;i<numbers.size();i++){
     ArrayList <IntList> beenthere = new ArrayList();
     while (true){
       
     }
   }
  
  return false;
}

void newnumber(){

  int newval = numbers.size()+1;
  float newx=random(0,width);
  float newy=random(0,height);
  connections.addColumn();
  connections.addRow();
  int count=1;
  for(int i = 0;i<numbers.size();i++){
    if(sqrt(newval+numbers.get(i).value)==floor(sqrt(newval+numbers.get(i).value))){
      newx+=numbers.get(i).pos.x;
      newy+=numbers.get(i).pos.y;
      connections.setInt(newval-1,i,1);
      connections.setInt(i,newval-1,1);
      count++;
    }
  }
  if(count>0){
    numbers.add(new number(newx/count,newy/count,newval));
  }else{
    numbers.add(new number(newx,newy,newval));
  }
}





class number{
  PVector pos;
  PVector vel=new PVector();
  int value;
  
  number(float x, float y, int val){
    pos= new PVector(x,y);
    value = val;
  }
  
  void display(){
    fill(255);
    ellipse(pos.x,pos.y,width/numbers.size(),width/numbers.size());
    fill(0);
    text(value,pos.x,pos.y);
  }
  
  void force(){
    for(int i=0;i<numbers.size();i++){
      if(i+1!=value){
        vel.add(pos.copy().sub(numbers.get(i).pos).mult(forceconst).div(pow(dist(pos.x,pos.y,numbers.get(i).pos.x,numbers.get(i).pos.y),2)/100));
        if(connections.getInt(value-1,i)==1){
          vel.sub(pos.copy().sub(numbers.get(i).pos).mult(conconst));
        }
      }
    }
    vel.mult(dampener);
  }
  
  void move(){
    pos.add(vel);
    if(pos.x>width){
      pos.x=width;
      vel.x=0;
    }
    if(pos.x<0){
      pos.x=0;
      vel.x=0;
    }
    if(pos.y>height){
      pos.y=height;
      vel.y=0;
    }
    if(pos.x<0){
      pos.y=0;
      vel.y=0;
    }
  }
}