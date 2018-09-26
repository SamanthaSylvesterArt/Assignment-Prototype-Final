/**
 * Sketch By Samantha Sylvester, 3165592
 * September 2018
 * Resources:
 * Processing Sound Library, Example 5
 * 
 */
import gifAnimation.*;
import processing.opengl.*;
import processing.sound.*;

int sceneCounter = 0;
//pacman location
float pacX = -50;

//text
PFont coolFont;//declare font 
float x;
float y;  

//rain
int rainNum = 100;
ArrayList rain = new ArrayList();
ArrayList splash = new ArrayList();
float current;
float reseed = random(0, .2);

// Create a smoothing factor
float smooth_factor = 0.2;
PImage img;
float offset = 0;
float easing = 0.05;

//gifs
PImage[] animation;
Gif loopingGif;
Gif loopingGifB;
Gif loopingGifC;
boolean pause = false;

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;
int scale = 5;// Declare a scaling factor
int bands = 128;// Define how many FFT bands we want
float r_width;// declare a drawing variable for calculating rect width
float[] sum = new float[bands];// Create a smoothing vector
int f;//lines for act 2

void setup() {
  size(1200, 800, P3D);
  frameRate(100); 
  img = loadImage("spvsw.jpg");  // Load an image into the program
  coolFont = loadFont("AlphaTaurus3D-30.vlw");//font
  y = height;

  //rain
  colorMode(HSB, 100);
  rain.add(new Rain());
  current = millis();
  
  // create the GifAnimation object for playback
   loopingGifB = new Gif(this, "ramona2.gif");
   loopingGifB.loop();
   loopingGif = new Gif(this, "knives.gif");
   loopingGif.loop();
   loopingGifC = new Gif(this, "scott.gif");
   loopingGifC.loop();
  

  //Audio
  device = new AudioDevice(this, 44000, bands); // If the Buffersize is larger than the FFT Size, the FFT will fail, so we set Buffersize equal to bands
  r_width = width/float(bands);// Calculate the width of the rects depending on how many bands we have
  sample = new SoundFile(this, "Threshold (8 Bit) - Brian LeBarton.mp3");// Load and play a soundfile and loop it. This has to be called before the FFT is created.
  sample.loop();
  fft = new FFT(this, bands);// Create and patch the FFT analyzer
  fft.input(sample);
}     
void draw() {
  
  //animations
  image(loopingGifC, 10, height / 2 - loopingGifC.height / 2);
  image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
  image(loopingGifB, width - 10 - loopingGifB.width, height - loopingGifB.height);

  //counter for mouseclicks
  if (sceneCounter == 0) {
    act1();
    text("Scott Pilgrim VS The World", 300, 150); 
    text("Starring:", 200, 250);
    text("Michael Cera", 350, 350);
    image(loopingGifC, 10, height / 2 - loopingGifC.height / 2);
  } else if (sceneCounter == 1) {

    act2();
    text("Kieran Culkin", 250, 200);
    text("Mary Elizabeth Winstead", 300, 400);
    translate(100,200);
    image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
  } else if (sceneCounter == 2) {

    act3();
    fill(#FFFFFF);
    text("Brandon Routh", 600, 100);
    text("Jason Schwartzman", 200, 250);
    image(loopingGifB, width - 10 - loopingGifB.width, height - loopingGifB.height);
  } else if (sceneCounter == 3) {

    act1();
    text("Johnny Simmons", 400, 100);
    text("Mark Webber", 500, 300);
    image(loopingGifC, 10, height / 2 - loopingGifC.height / 2);
  } else if (sceneCounter == 4) {

    act2();
    text("Chris Evans", 200, 100);
    text("Anna Kendrick", 300, 250);
    text("Brie Larson", 400, 400);
    translate(100,200);
    image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
  } else if (sceneCounter == 5) {

    act3();
    fill(#FFFFFF);
    text("Alison Pill", 250, 200);
    text("Aubrey Plaza", 250, 350);
    text("Mae Whitman", 200, 500);
    image(loopingGifB, width - 10 - loopingGifB.width, height - loopingGifB.height);
  } else if (sceneCounter == 6) {

    act4();
    background(0);
    image(img, 10, 10);  // Load an image into the program
    fill(#ffffff);
    /*text("Scott Pilgrim", 200, 200);
    text("Vs", 350, 300);
    text("The World", 200, 400);
    */
    image(loopingGifB, width - 10 - loopingGifB.width, height - loopingGifB.height);
    translate(300,-150);
    image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
    translate(-100,300);
    image(loopingGifC, 10, height / 2 - loopingGifC.height / 2);
 
  }
}

void act1() {
  // Set background color, stroke and fill color
  background(0);
  loopingGifB.play();
  stroke(255);
  textFont(coolFont, 50);        

  fill(0, 0, 255);
  //rain
  blur(50);
  if ((millis()-current)/1000>reseed&&rain.size()<150) {
    rain.add(new Rain());
    float reseed = random(0, .2);
    current = millis();
  }
  for (int i=0; i<rain.size(); i++) {
    Rain rainT = (Rain) rain.get(i);
    rainT.calculate();
    rainT.draw();
    if (rainT.position.y>height)
    {

      for (int k = 0; k<random(5, 10); k++) {
        splash.add(new Splash(rainT.position.x, height));
      }

      rain.remove(i);
      float rand = random(0, 100);
      if (rand>10&&rain.size()<150)
        rain.add(new Rain());
    }
  }

  for (int i=0; i<splash.size(); i++) {
    Splash spl = (Splash) splash.get(i);
    spl.calculate();
    spl.draw();
    if (spl.position.y>height)
      splash.remove(i);
  }
  //sound
  stroke(255);
  fft.analyze();
  for (int i = 0; i < bands; i++) {
    // Smooth the FFT data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smooth_factor;

    // Draw the rects with a scale factor
    rect( i*r_width, height, r_width, -sum[i]*height*scale );
  }
}
//rain
void blur(float trans) { 
  noStroke();
  fill(0, trans);
  rect(0, 0, width, height);
}

void act2() {
  fill(0);
  textFont(coolFont, 50); 
  //lines
  for (int i = 0; i < (width * height); i ++) {
    set(i / height, i % height, 
      i * i / (f + 1));
  }
  f++;
}
void act3() {
  noStroke();
  fill(#FFFFFF);
  textFont(coolFont, 50); 
  background(0);
  rect(width, 350, 0, 0);

  // Draw the yellow circle
  fill(#FFF703);
  ellipse(pacX, height/2, 50, 50);

  // Draw a black wedge representing his mouth
  fill(0); // black
  arc(pacX, height/2, 50, 50, 
    abs(sin(pacX/width * 24 * PI)) * (-PI/5), 
    abs(sin(pacX/width * 24 * PI)) * (PI/5) );

  // Update pac man's location
  pacX = (pacX + 2);
  if (pacX > width + 25)
    pacX = -25;

  // Put some food on the screen for pacman
  strokeWeight(5); 
  stroke(#FFFFFF); // white 
  for (int i = 15; i <= width; i+= 15) {
    if (i > pacX + 3) 
      point(i, height/2);
  } 

  smooth();
  frameRate(50);
  strokeWeight(5); 
  fill(0, 20);
  //rect(0, 0, width, height);
  stroke(random(255), random(255), random(255));
  noFill();
  beginShape();
  //vertex(random(width), random(height));
  vertex(0, 0);
  //ellipse(0, 0, 5, 5);
  bezierVertex(random(width), random(height), random(width), random(height), random(width), random(height));
  endShape();
}
void act4() {
  background(#ffffff);
  stroke(#000000);
  textFont(coolFont, 100);
}
void mouseReleased() {
  //runs only when clicked

  background(0);
  sceneCounter = sceneCounter +1;
}
void initFonts() {
  coolFont = loadFont("AlphaTaurusCondensed-48.vlw");  
  textFont(coolFont, 120);
  textAlign(CENTER, CENTER);
}
//gifs spacebar pause
void keyPressed() { 
  if (key == ' ') {
    if (pause) {
      //loopingGifC.play();
     loopingGifB.play();
      //loopingGif.play();
      pause = false;
    } else {
      //loopingGif.pause();
      //loopingGifC.pause();
      loopingGifB.pause();
      pause = true;
    }
  }
}