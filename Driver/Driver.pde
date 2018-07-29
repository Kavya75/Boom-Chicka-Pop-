//Main file that's going to run everything
//Use '150' for transparency so that the bubble isn't completely solid (ex: color(60, 180, 20, 150));
import processing.sound.*;
SoundFile file;
PFont myFont;
int clickCounter = 0;
Bubble other = new Bubble(200, color(60, 180, 20, 150), displayWidth/2, displayHeight/2); 
Bubble[] allBubbles = new Bubble[5]; 

void setup() {
  file = new SoundFile(this, "Music.mp3");
  file.play();
  
  fullScreen();
  background(0);
  smooth(8);
  initializeBubbles();
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
  text("SURVEY", displayWidth / 2, 90);
  textSize(20);
  text("Press 1 for strongly disagree, 2 for somewhat disagree, 3 for somewhat agree, 4 for strongly agree", displayWidth / 2, 130);
  
  textAlign(LEFT);
  textSize(30);
  text("1. I prefer working through problems on my own.", displayWidth / 4.25, 200);
  text("2. I am very talkative.", displayWidth / 4.25, 270);
  text("3. I enjoy spending time alone.", displayWidth / 4.25, 340);
  text("4. I feel energized after spending time with others.", displayWidth / 4.25, 410);
  textSize(25);
  textAlign(CENTER);
  text("click anywhere to continue", displayWidth / 2, 510);
}

//Runs the instructions screen
void instrucScreen() {
  background(0);
  textAlign(CENTER);
  textSize(50);
  text("INSTRUCTIONS", displayWidth / 2, 90);
  
  textAlign(LEFT);
  textSize(30);
  text("1. Move your bubble around using the mouse.", displayWidth / 8, 160);
  text("2. When you bump in a bubble, a conversation will take place between you", displayWidth / 8, 210);
  text("and the person in their bubble.", displayWidth / 8, 260);
  text("3. After you talk to the person, your bubble will either shrink or expand.", displayWidth / 8, 310);
  text("4. The goal is to get as many bubbles as possible and pop your bubble.", displayWidth / 8, 360);
  textSize(25);
  textAlign(CENTER);
  text("click anywhere to start", displayWidth / 2, 450);
}

//Runs the gameplay screen
void gamePlayScreen() {
  background(255);
  fill(255);
  Bubble b = new Bubble(150, color(181, 235, 255, 150), displayWidth / 2, displayHeight / 2);
  b.set(mouseX, mouseY);
  b.display();
  
   
  for(int i = 0; i < allBubbles.length; i++) { 
    allBubbles[i].checkXEdges(displayWidth); 
    allBubbles[i].checkYEdges(displayHeight);
    allBubbles[i].setX(allBubbles[i].getX() + allBubbles[i].getXDir()); 
    allBubbles[i].setY(allBubbles[i].getY() + allBubbles[i].getYDir()); 
    allBubbles[i].set(allBubbles[i].getX(), allBubbles[i].getY()); 
    allBubbles[i].display();
    allBubbles[i].checkCollision(b);

  }
  
  
 
}

void initializeBubbles() { 
  for(int i = 0; i < allBubbles.length; i++) {
   int randomRadius = int(random(50, 100));
   int randomRedValue = int(random(10, 250)); 
   int randomBlueValue = int(random(10, 250)); 
   int randomGreenValue = int(random(10, 250)); 
   int randomXStart = int(random(10, displayWidth)); 
   int randomYStart = int(random(10, displayHeight)); 
   int randomXDir = int(random(1, 7)); 
   int randomYDir = int(random(1, 7)); 
   allBubbles[i] = new Bubble(randomRadius, color(randomRedValue, 
      randomGreenValue, randomBlueValue, 150), randomXStart, randomYStart,
      randomXDir, randomYDir);
  }
}
