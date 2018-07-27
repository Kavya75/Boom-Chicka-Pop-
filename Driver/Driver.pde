//Main file that's going to run everything
//Use '150' for transparency so that the bubble isn't completely solid (ex: color(60, 180, 20, 150));

PFont myFont;
int clickCounter = 0;
Bubble other = new Bubble(200, color(60, 180, 20, 150), displayWidth/2, displayHeight/2); 


void setup() {
  fullScreen();
  background(0);
  smooth(8);

  noStroke();
}

void draw() {
  if (clickCounter == 0) {
    startScreen();
  } else if (clickCounter == 1) {
    surveyScreen();
  } else if (clickCounter == 2) {
    instrucScreen(); 
  } else if (clickCounter >= 3) {
    gamePlayScreen();
  }
}

void mouseClicked() {
  clickCounter++; //Counts the total number of clicks
}

//Runs the initial screen 
void startScreen() {
  background(0);
  myFont = createFont("Georgia", 100, true);
  textFont(myFont);
  textAlign(CENTER);
  fill(255);

  text("S  O  N  D  E  R", displayWidth / 2, displayHeight / 2);

  textSize(18);
  text("the realization that everyone has a story", displayWidth / 2, (displayHeight / 2) + 45);
  textSize(15);
  text("click anywhere to begin", displayWidth / 2, (displayHeight / 2) + 120);
}

//Runs the screen with the survey questions that determines
// if the user's bubble shrinks or expands initially
void surveyScreen() {
  background(0);
  textAlign(CENTER);
  
  textSize(50);
  text("QUESTIONS", displayWidth / 2, 90);
  
  textSize(20);
  text("QUESTION 1:", displayWidth / 2, 160);
  text("QUESTION 2:", displayWidth / 2, 190);
  text("QUESTION 3:", displayWidth / 2, 220);
  text("QUESTION 4:", displayWidth / 2, 250);
  text("click anywhere to continue", displayWidth / 2, 300);
}

//Runs the instructions screen
void instrucScreen() {
  background(0);
  textAlign(CENTER);
  textSize(50);
  text("INSTRUCTIONS", displayWidth / 2, 90);
  
  textAlign(LEFT);
  textSize(30);
  text("1. Move your bubble around using the mouse.", displayWidth / 7, 160);
  text("2. When you bump in a bubble, a conversation will take place between you", displayWidth / 7, 210);
  text("and the person in their bubble.", displayWidth / 7, 260);
  text("3. After you talk to the person in the bubble, your bubble will either shrink or expand.", displayWidth / 7, 310);
  text("4. The goal is to get as many bubbles as possible and pop your bubble.", displayWidth / 7, 360);
  textSize(25);
  textAlign(CENTER);
  text("Click anywhere to start", displayWidth / 2, 450);
}

//Runs the gameplay screen
void gamePlayScreen() {
  background(255);
  fill(255);
  Bubble b = new Bubble(200, color(181, 235, 255, 150), displayWidth / 2, displayHeight / 2);
  b.set(mouseX, mouseY);
  b.display();
  
  other.checkXEdges(displayWidth);
  other.checkYEdges(displayHeight);
  other.setX(other.getX() + other.getXDir()); 
  other.setY(other.getY() + other.getYDir());
  other.set(other.getX(), other.getY());
  other.display();
 
}
