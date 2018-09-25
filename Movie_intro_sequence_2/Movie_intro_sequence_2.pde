/**
 * Sketch By Samantha Sylvester, 3165592
 * September 2018
 * Resources:
 * Processing Sound Library, Example 5
 * 
 *
 */

import processing.sound.*;

//text
PFont coolFont;//declare font 
float x;
float y;  
int index = 0;
String[] headlines = {
  "Scott Pilgrim VS The World", 
  "Starring", 
  "Michael Cera",
  "Mary Elizabeth Winstead",
  "Kieran Culkin",
  };

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

// Declare the processing sound variables 
SoundFile sample;
FFT fft;
AudioDevice device;
int scale = 5;// Declare a scaling factor
int bands = 128;// Define how many FFT bands we want
float r_width;// declare a drawing variable for calculating rect width
float[] sum = new float[bands];// Create a smoothing vector


void setup() {
  size(1000, 800, P3D);
  frameRate(100); //gifs
  coolFont = loadFont("AlphaTaurus3D-30.vlw");
   y = height;
 
  //rain
  colorMode(HSB, 100);
  rain.add(new Rain());
  current = millis();
  
 device = new AudioDevice(this, 44000, bands); // If the Buffersize is larger than the FFT Size, the FFT will fail, so we set Buffersize equal to bands
 r_width = width/float(bands);// Calculate the width of the rects depending on how many bands we have
  sample = new SoundFile(this, "Threshold (8 Bit) - Brian LeBarton.mp3");// Load and play a soundfile and loop it. This has to be called before the FFT is created.
  sample.loop();
  fft = new FFT(this, bands);// Create and patch the FFT analyzer
  fft.input(sample);
}      

void draw() {
  // Set background color, stroke and fill color
  stroke(255);
  textFont(coolFont,50);        
  text(headlines[index],300,y); 

  //speed
  y = y - 3;

  float w = textWidth(headlines[index]);
  if (y < -w) {
    y = width; 
    index = (index + 1) % headlines.length;
  }
  fill(0, 0, 255);
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

       for (int k = 0 ; k<random(5,10) ; k++)
       {
       splash.add(new Splash(rainT.position.x,height));
       }

      rain.remove(i);
      float rand = random(0, 100);
      if (rand>10&&rain.size()<150)
        rain.add(new Rain());
    }
  }
  
  for (int i=0 ; i<splash.size() ; i++)
   {
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
  