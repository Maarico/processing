PImage processimage() {
  if (mode=="longexposure") {
    cachedimages.add(cam.copy()); //adding current image to cached ones
    cam.loadPixels();
    for (int i=0; i<cam.pixels.length; i++) {
      RED[i]+=red(cam.pixels[i]);
      GREEN[i]+=green(cam.pixels[i]);
      BLUE[i]+=blue(cam.pixels[i]); //adding current image to arrays
    }
    while (cachedimages.size()>maximages) {
      PImage temp = cachedimages.get(0);
      temp.loadPixels();
      for (int i=0; i<temp.pixels.length; i++) {
        RED[i]-=red(temp.pixels[i]);
        GREEN[i]-=green(temp.pixels[i]);
        BLUE[i]-=blue(temp.pixels[i]);//subtraction expired images from array
      }
      cachedimages.remove(0); //deleting expired images from cached ones
    }
    PImage temp = new PImage(cam.width,cam.height);
    temp.loadPixels();
    for(int i=0;i<RED.length;i++){
      temp.pixels[i]=color(RED[i],GREEN[i],BLUE[i]);//finalizing image to be returned
    }
    temp.updatePixels();
    return temp;
  }
  return null;
}