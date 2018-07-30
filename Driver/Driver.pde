//Main file that's going to run everything
//Use '150' for transparency so that the bubble isn't completely solid (ex: color(60, 180, 20, 150));

import processing.sound.*;
PFont myFont;
PImage img;
SoundFile file;
int clickCounter = 0;
Bubble other = new Bubble(200, color(60, 180, 20, 150), displayWidth/2, displayHeight/2); 
Bubble[] allBubbles = new Bubble[5]; 
BufferedReader reader;
String line = "hi";
String[] listOfFileNames = {"convo1.txt"};
boolean bubbleBumped = false;

void setup() {
  //file = new SoundFile(this, "Music.mp3");
  //file.play();

  fullScreen();
  background(0);
  smooth(8);
  initializeBubbles();
  noStroke();

  img = loadImage("bear.png");
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
  if (mouseX > (displayWidth / 2) - 100 && mouseX < (displayWidth / 2) + 100 && mouseY < (displayHeight / 2) + 145 && mouseY > (displayHeight / 2) + 85) {
    clickCounter++;
  }
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
  
  buttonCreator("click here to begin");
}

//Runs the screen with the survey questions that determines
// if the user's bubble shrinks or expands initially
void surveyScreen() {
  background(0);
  fill(255);
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
  
  buttonCreator("click here to continue");
}

//Runs the instructions screen
void instrucScreen() {
  background(0);
  fill(255);
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
  
  buttonCreator("click here to begin");
}

//Runs the gameplay screen
void gamePlayScreen() {
  background(255);
  Bubble b = new Bubble(150, color(181, 235, 255, 150), displayWidth / 2, displayHeight / 2);
  b.set(mouseX, mouseY);
  b.display();


  for (int i = 0; i < allBubbles.length; i++) { 
    allBubbles[i].checkXEdges(displayWidth); 
    allBubbles[i].checkYEdges(displayHeight);
    allBubbles[i].setX(allBubbles[i].getX() + allBubbles[i].getXDir()); 
    allBubbles[i].setY(allBubbles[i].getY() + allBubbles[i].getYDir()); 
    allBubbles[i].set(allBubbles[i].getX(), allBubbles[i].getY()); 
    allBubbles[i].display();
    bubbleBumped = allBubbles[i].checkCollision(b);
  }
}


void initializeBubbles() { 
  for (int i = 0; i < allBubbles.length; i++) {
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

void conversationScreen() { 
  // noLoop();
  println(" C      O         N ");
  int num = int(random(0, 1)); 
  reader = createReader(listOfFileNames[num]);
  background(150, 130, 50);
  textSize(32);
  fill(0);

  try {
    while ((line = reader.readLine()) != null) {
      background(150, 130, 50);
      text(line, width/4, height/2);
      delay(800);
    }
    reader.close();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  bubbleBumped = false;
  // loop();
}

//Creates the button box and changes the color of the box and label when the mouse is over it
void buttonCreator(String buttonLabel) {
  textAlign(CENTER);
  if (mouseX > (displayWidth / 2) - 100 && mouseX < (displayWidth / 2) + 100 && mouseY < (displayHeight / 2) + 145 && mouseY > (displayHeight / 2) + 85) {
    fill(255);
    stroke(255);
    rect((displayWidth / 2) - 100, (displayHeight / 2) + 85, 200, 60);
    fill(0);
    textSize(15);
    text(buttonLabel, displayWidth / 2, (displayHeight / 2) + 120);
  }
    textSize(15);
    text(buttonLabel, displayWidth / 2, (displayHeight / 2) + 120);
    noFill();
    stroke(255);
    rect((displayWidth / 2) - 100, (displayHeight / 2) + 85, 200, 60);
}
