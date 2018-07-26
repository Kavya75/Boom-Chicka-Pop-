//Main file that's going to run everything

boolean start;
boolean instruction;
PFont myFont;
int clickCounter = 0;

void setup() {
  size(600, 600);
  noStroke();
  background(0);
  smooth(8);
  start = true;
  
  //Bubble b = new Bubble(50, color(250, 0, 0));
  //b.display();
}

void draw() {
  //START PAGE 
  if (start == true) {
    myFont = createFont("Georgia", 60, true);
    textFont(myFont);
    textAlign(CENTER, CENTER);
    fill(255);
    
    text("S  O  N  D  E  R", 300, 200);
    
    textSize(18);
    text("the realization that everyone has a story", 300, 250);
    
    textSize(15);
    text("click anywhere to begin", 300, 440);
  }
  
  else if (instruction == true) {
    text("INSTRUCTIONSSS", 300, 300);
  }
}

void mouseClicked() {
  clickCounter++;
  if (clickCounter == 1) {
    start = false;
    instruction = true;
  }
}
