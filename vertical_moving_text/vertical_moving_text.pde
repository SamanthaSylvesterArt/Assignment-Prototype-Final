String[] headlines = {
  "Golconde", "hello", "world"
  };

PFont f; 
float x;
float y;  
int index = 0;

void setup() {
  size(600,600);
  f = createFont("Arial",16,true);  
  y = height; 
}

void draw() {
  background(255);
  fill(0);
  textFont(f,16);        
  text(headlines[index],180,y); 

  
  y = y - 5;


  float w = textWidth(headlines[index]);
  if (y < -w) {
    y = width; 
    index = (index + 1) % headlines.length;
  }
}