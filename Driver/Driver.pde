//Main file that's going to run everything

boolean start = true;
PFont myFont;

void setup() {
  size(600, 600);
  noStroke();
  background(0);
  frameRate(0.5); //This slows down the frame rate so that the text in 'START SCREEN' is less blocky
  Bubble b = new Bubble(50, color(250, 0, 0));
  b.display();
}

void draw() {
  
  //START SCREEN
  if (start == true) {
    myFont = createFont("Georgia", 60, true);
    textFont(myFont);
    textAlign(CENTER, CENTER);
    fill(255);
    text("S O N D E R", 300, 200);
    textSize(20);
    text("the realization that everyone has a story", 300, 250);
  }
}
