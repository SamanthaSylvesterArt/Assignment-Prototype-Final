/*
* Demonstrates the use of the GifAnimation library.
* the left animation is looping, the one in the middle 
* plays once on mouse click and the one in the right
* is a PImage array. 
* the first two pause if you hit the spacebar.
*/

import gifAnimation.*;

PImage[] animation;
Gif loopingGif;
Gif loopingGifB;
Gif loopingGifC;
boolean pause = false;

public void setup() {
  size(1200, 800);
  frameRate(100);
  
  println("gifAnimation " + Gif.version());
  // create the GifAnimation object for playback
  loopingGif = new Gif(this, "knives.gif");
  loopingGif.loop();
  loopingGifB = new Gif(this, "ramona.gif");
  loopingGifB.loop();
  loopingGifC = new Gif(this, "scott.gif");
  loopingGifC.loop();
  // create the PImage array for the interactive display
  animation = Gif.getPImages(this, "scott.gif");
}

void draw() {
  background(255);
  image(loopingGifC,  10, height / 2 - loopingGifC.height / 2);
  image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
  image(loopingGifB, width - 10 - animation[0].width, height / 2 - loopingGifB.height / 2);
}


void keyPressed() {
  if (key == ' ') {
    if (pause) {
      loopingGifC.play();
      loopingGifB.play();
      loopingGif.play();
      pause = false;
    } 
    else {
      loopingGif.pause();
      loopingGifC.pause();
      loopingGifB.pause();
      pause = true;
    }
  }
}