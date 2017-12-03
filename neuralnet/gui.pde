ArrayList <guicontroller> guicontrollers = new ArrayList();

class guicontroller {//parent class of all gui elements
  boolean visible;
  String name;
  ArrayList <button> buttons = new ArrayList();
  ArrayList <text> texts = new ArrayList();
  guicontroller(boolean a, String b) {
    visible = a;
    name = b;
  }

  void display() {//display method for guicontroller
    if (visible) {//visibility check
      for (int i=0; i<buttons.size(); i++) {//loop through buttons
        buttons.get(i).display();
      }
      for (int i=0; i<texts.size(); i++) {//loop through texts
        texts.get(i).display();
      }
    }
  }

  button clickcheck() {//method to check if a button was clicked
    if (visible) {
      for (int i=0; i<buttons.size(); i++) {
        if (buttons.get(i).checkclicked()!=null) {
          return buttons.get(i).checkclicked();
        }
      }
    }
    return null;
  }


  void addbutton(button a) {//method that adds a button to a guicontroller
    buttons.add(a);
  }

  void addtext(text a) {//method that adds a text to a guicontroller
    texts.add(a);
  }

  text gettextbyid(String id) {//method to get a text with a specific id
    for (int i=0; i<texts.size(); i++) {
      if (texts.get(i).id==id) {
        return texts.get(i);
      }
    }
    return null;
  }
}



class button {
  PVector pos, size;
  String text, action;

  button(float a, float b, float c, float d, String e, String f) {
    pos = new PVector(a, b);
    size=new PVector(c, d);
    text=e;
    action=f;
  }

  void display() {//display method for button class
    fill(255);
    stroke(0);
    rect(pos.x-size.x/2, pos.y-size.y/2, size.x, size.y);
    textAlign(CENTER, CENTER);
    fill(0);
    text(text, pos.x, pos.y);
  }

  button checkclicked() {//check if button was clicked
    if (mouseX>pos.x-size.x/2&&mouseX<pos.x+size.x/2&&mouseY>pos.y-size.y/2&&mouseY<pos.y+size.y/2) {
      return this;
    }
    return null;
  }
}

class text {//text class
  String text, id;
  PVector pos;
  text(String a, String b, float c, float d) {
    id=a;
    text=b;
    pos=new PVector(c, d);
  }

  void display() {
    stroke(0);
    textAlign(LEFT, CENTER);
    fill(200);
    text(text, pos.x, pos.y);
  }
}



guicontroller getguibyID(String id, ArrayList <guicontroller> list) {//method to get a guicontroller by its id
  for (int i=0; i<list.size(); i++) {
    if (list.get(i).name==id) {
      return list.get(i);
    }
  }
  return null;
}


void displaygui(ArrayList <guicontroller> list) {//method that displays all guicontrollers in a list
  for (int i=0; i<list.size(); i++) {
    list.get(i).display();
  }
}

button getclickedbutton() {//method that gives the pressed button
  for (int i=0; i<guicontrollers.size(); i++) {
    if (guicontrollers.get(i).clickcheck()!=null) {
      return guicontrollers.get(i).clickcheck();
    }
  }
  return null;
}