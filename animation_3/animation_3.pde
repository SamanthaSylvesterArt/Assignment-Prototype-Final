
// The x-location of pac-man
float pacX = -50;

PFont coolFont; 
float y;  




void setup() {
  background(0);
  size(1000 ,800);
  smooth();
  frameRate(50);
  coolFont = loadFont("AlphaTaurusCondensed-30.vlw");  
  y = height;
  
}

void draw() {
  background(0);
  noStroke();
  fill(0, 20);
  rect(0, 0, width, height);
  stroke(random(255),random(255),random(255));
  noFill();
  beginShape();
  //vertex(random(width), random(height));
 vertex(0, 0);
 ellipse(0, 0, 5, 5);
 bezierVertex(random(width), random(height), random(width), random(height), random(width), random(height));

  endShape();
  
  fill(255);
  textFont(coolFont,50);        
  
// Move pac-man left-to right, and let
// him tunnel around from the right
// back to the beginning
stroke(0); // black
  fill(0);
  rect(0, 350, width, 100);
  
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
  stroke(255); // white 
  for (int i = 15; i <= width; i+= 15) {
    if (i > pacX + 3) 
    point(i, height/2);
  } 

}