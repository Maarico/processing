void mousePressed() {
  button clicked = getclickedbutton();
  if (clicked!=null) {
    if (clicked.action=="loadnet") {
      net.getnet(saveloadas);
    }
    if (clicked.action=="savenet") {
      net.savenet(saveloadas);
    }
    if (clicked.action=="randomnet") {
      net= new neural_net();
      net.randomnet(configuration);
    }
    if(clicked.action=="newinput"){
      newinput();
    }
  }
}