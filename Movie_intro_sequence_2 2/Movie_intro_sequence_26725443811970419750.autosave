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

//rain
int rainNum = 100;
ArrayList rain = new ArrayList();
ArrayList splash = new ArrayList();
float current;
float reseed = random(0, .2);

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

  //rain
  colorMode(HSB, 100);
  rain.add(new Rain());
  current = millis();

  // create the GifAnimation object for playback
  /*loopingGif = new Gif(this, "knives.gif");
   loopingGif.loop();
   loopingGifB = new Gif(this, "ramona2.gif");
   loopingGifB.loop();
   */
  loopingGifC = new Gif(this, "scott.gif");
  loopingGifC.loop();


  // If the Buffersize is larger than the FFT Size, the FFT will fail, so we set Buffersize equal to bands
  device = new AudioDevice(this, 44000, bands);

  // Calculate the width of the rects depending on how many bands we have
  r_width = width/float(bands);

  // Load and play a soundfile and loop it. This has to be called before the FFT is created.
  sample = new SoundFile(this, "The Mowglis - Im Good Lyric Video.mp3");
  sample.loop();

  // Create and patch the FFT analyzer
  fft = new FFT(this, bands);
  fft.input(sample);
}      

void draw() {
  // Set background color, noStroke and fill color
  fill(0, 0, 255);
  noStroke();
  
  //rain
  blur(50);

  if ((millis()-current)/1000>reseed&&rain.size()<150)
  {
    rain.add(new Rain());
    float reseed = random(0, .2);
    current = millis();
  }

  for (int i=0; i<rain.size(); i++)
  {
    Rain rainT = (Rain) rain.get(i);
    rainT.calculate();
    rainT.draw();
    if (rainT.position.y>height)
    {

      /* for (int k = 0 ; k<random(5,10) ; k++)
       {
       splash.add(new Splash(rainT.position.x,height));
       }*/

      rain.remove(i);
      float rand = random(0, 100);
      if (rand>10&&rain.size()<150)
        rain.add(new Rain());
    }
  }
  /*
  for (int i=0 ; i<splash.size() ; i++)
   {
   Splash spl = (Splash) splash.get(i);
   spl.calculate();
   spl.draw();
   if (spl.position.y>height)
   splash.remove(i);
   }
   */

  //animations
  image(loopingGifC, 10, height / 2 - loopingGifC.height / 2);
  //image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
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
//rain
void blur(float trans) { 
  noStroke();
  fill(0, trans);
  rect(0, 0, width, height);
}

//gifs spacebar pause
void keyPressed() { 
  if (key == ' ') {
    if (pause) {
      loopingGifC.play();
     // loopingGifB.play();
      //loopingGif.play();
      pause = false;
    } else {
      //loopingGif.pause();
      loopingGifC.pause();
      //loopingGifB.pause();
      pause = true;
    }
  }
}