//Main file that's going to run everything

PFont myFont;
int clickCounter = 0;

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
  } else if (clickCounter == 3) {
    gamePlayScreen();
  }
}

void mouseClicked() {
  clickCounter++; //Counts the total number of clicks
}

//Runs the initial screen 
void startScreen() {
  myFont = createFont("Georgia", 60, true);
  textFont(myFont);
  textAlign(CENTER);
  fill(255);

  text("S  O  N  D  E  R", displayWidth / 2, 200);

  textSize(18);
  text("the realization that everyone has a story", displayWidth / 2, 255);

  textSize(15);
  text("click anywhere to begin", displayWidth / 2, 440);
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
  
  textSize(30);
  text("INSTRUCTION #1 blah blah blah", displayWidth / 2, 160);
}

//Runs the gameplay screen
void gamePlayScreen() {
  background(0);
  fill(255);
  Bubble b = new Bubble(200, color(181, 235, 255, 180), displayWidth / 2, displayHeight / 2);
  b.display();
}
