/**
 * Processing Sound Library, Example 5
 * 
 * This sketch shows how to use the FFT class to analyze a stream  
 * of sound. Change the variable bands to get more or less 
 * spectral bands to work with. The smooth_factor variable determines 
 * how much the signal will be smoothed on a scale form 0-1.
 */
import gifAnimation.*;
import processing.sound.*;
import processing.opengl.*;

//text
PFont coolFont;//declare font

//gifs
PImage[] animation;
Gif loopingGif;
//Gif loopingGifB;
//Gif loopingGifC;
boolean pause = false;

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;

// Declare a scaling factor
int scale = 5;

// Define how many FFT bands we want
int bands = 128;

// declare a drawing variable for calculating rect width
float r_width;

// Create a smoothing vector
float[] sum = new float[bands];

// Create a smoothing factor
float smooth_factor = 0.2;
PImage img;
float offset = 0;
float easing = 0.05;

void setup() {
  size(1000, 800, P3D);
  frameRate(100); //gifs
  coolFont = loadFont("AlphaTaurus3D-30.vlw");
  img = loadImage("spvsw.jpg");  // Load an image into the program

  

  // create the GifAnimation object for playback
  loopingGif = new Gif(this, "knives.gif");
  loopingGif.loop();
  /*
  loopingGifB = new Gif(this, "ramona2.gif");
   loopingGifB.loop();
   loopingGifC = new Gif(this, "scott.gif");
  loopingGifC.loop();
   */
  
  // If the Buffersize is larger than the FFT Size, the FFT will fail, so we set Buffersize equal to bands
  device = new AudioDevice(this, 44000, bands);

  // Calculate the width of the rects depending on how many bands we have
  r_width = width/float(bands);

  // Load and play a soundfile and loop it. This has to be called before the FFT is created.
  sample = new SoundFile(this, "Sex Bob-Omb - Garbage Truck");
  //sample.loop();

  // Create and patch the FFT analyzer
  fft = new FFT(this, bands);
  fft.input(sample);
}      

void draw() {
  // Set background color, noStroke and fill color
  fill(0, 0, 255);
  noStroke();

  //animations
  image(loopingGif, 10, height / 2 - loopingGif.height / 2);
  //image(loopingGifC, 10, height / 2 - loopingGifC.height / 2);
   //image(loopingGifB, width - 10 - animation[0].width, height / 2 - loopingGifB.height / 2);

//sound
  fft.analyze();
  for (int i = 0; i < bands; i++) {
    // Smooth the FFT data by smoothing factor
    sum[i] += (fft.spectrum[i] - sum[i]) * smooth_factor;

    // Draw the rects with a scale factor
    rect( i*r_width, height, r_width, -sum[i]*height*scale );
  }
  
  //image
  image(img, 400, 0);  // Display at full opacity
  scale(img.height*2, img.width*2 );
  
  //text
  
}

//gifs spacebar pause
void keyPressed() { 
  if (key == ' ') {
    if (pause) {
      loopingGif.play();
      //loopingGifC.play();
     // loopingGifB.play();
      
      pause = false;
    } else {
      loopingGif.pause();
     //loopingGifC.pause();
     //loopingGifB.pause();
      pause = true;
    }
  }
}