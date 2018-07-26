//Main file that's going to run everything

boolean start = true;
PFont myFont;

void setup() {
  size(600, 600);
  noStroke();
  background(0);
  Bubble b = new Bubble(50, color(250, 0, 0));
  b.display();
}

void draw() {
  
  if (start == true) {
    myFont = createFont("Georgia", 32, true);
    textFont(myFont);
    textAlign(CENTER, CENTER);
    fill(255);
    text("S O N D E R", 300, 300);
  }
}
