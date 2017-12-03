byte im[];
byte la[];
int m=0;
IntList digitscount = new IntList();
void setup(){
  for(int i=0;i<10;i++){
    digitscount.append(0);
  }
 im = loadBytes("trainingcompressed.idx3-ubyte"); 
 la = loadBytes("train-labels.idx1-ubyte");
 size(28,28);
 background(0);
}


void draw(){
  background(0);
  for(int x=0;x<width;x++){
    for(int y=0;y<height;y++){
       stroke(im[m*28*28+x*width+y+16] & 0xff);
       point(y,x);
    }
  }
  saveFrame("out/"+(la[m+8] & 0xff)+"/digit-"+digitscount.get(la[m+8] & 0xff)+".png");
  digitscount.add(la[m+8] & 0xff,1);
  m++;
  if(m>60000){exit();}
}