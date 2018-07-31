//Main file that's going to run everything
//Use '150' for transparency so that the bubble isn't completely solid (ex: color(60, 180, 20, 150));

import processing.sound.*;

PFont myFont;
PImage img;
SoundFile file;

int clickCounter = 0;
int enterCounter = 0; //Keeps track of how many times user hits ENTER for the survey page
int surveyPoints = 0;
int userInput1, userInput2, userInput3, userInput4 = 0;
int totalPoints = 0;

Bubble other = new Bubble(200, color(60, 180, 20, 150), displayWidth/2, displayHeight/2); 
Bubble[] allBubbles = new Bubble[5]; 

BufferedReader reader;

String line = "hi";
String[] listOfFileNames = {"convo1.txt"};

boolean bubbleBumped = false;
boolean onSurveyPage = false;
boolean q1, q2, q3, q4 = false; //Are used to display the survey questions one by one

public enum Screen {
  START_SCREEN, 
    SURVEY_SCREEN, 
    INSTRUC_SCREEN, 
    GAMEPLAY_SCREEN, 
    CONVO_SCREEN
}

Screen screen = Screen.START_SCREEN;

void setup() {
  //file = new SoundFile(this, "Music.mp3");
  //file.play();

  fullScreen();
  background(0);
  smooth(8);
  noStroke();

  initializeBubbles();
  img = loadImage("bear.png");
}

void draw() {
  if (screen == Screen.START_SCREEN)
    startScreen();
  else if (screen == Screen.SURVEY_SCREEN) {
    onSurveyPage = true;
    surveyScreen();
  } else if (screen == Screen.INSTRUC_SCREEN) {
    onSurveyPage = false;
    instrucScreen();
  } else if (screen == Screen.GAMEPLAY_SCREEN)
    gamePlayScreen();
  else if (screen == Screen.CONVO_SCREEN) 
    conversationScreen();
}

void mouseClicked() {
  if (mouseX > (displayWidth / 2) - 100 && mouseX < (displayWidth / 2) + 100 && mouseY < (displayHeight / 2) + 145 && mouseY > (displayHeight / 2) + 85) {
    clickCounter++;
  }

  if (clickCounter == 0)
    screen = Screen.START_SCREEN;
  else if (clickCounter == 1)
    screen = Screen.SURVEY_SCREEN;
  else if (clickCounter == 2)
    screen = Screen.INSTRUC_SCREEN; 
  else if (clickCounter == 3)
    screen = Screen.GAMEPLAY_SCREEN;

  if (onSurveyPage == true) {
    if (mouseX > (displayWidth / 2) - 198 && mouseX < (displayWidth / 2) - 168 && mouseY > (displayHeight / 2) - 225 && mouseY < (displayHeight / 2) - 195) {
      if (userInput1 < 4 && userInput1 > -1)
        userInput1++;
      else
        userInput1 = 1;
    }

    if (mouseX > (displayWidth / 2) + 418 && mouseX < (displayWidth / 2) + 448 && mouseY > (displayHeight / 2) - 154 && mouseY < (displayHeight / 2) - 124) {
      if (userInput2 < 4 && userInput2 > -1)
        userInput2++;
      else
        userInput2 = 1;
    }

    if (mouseX > (displayWidth / 2) - 29 && mouseX < (displayWidth / 2) + 1 && mouseY > (displayHeight / 2) - 83 && mouseY < (displayHeight / 2) - 53) {
      if (userInput3 < 4 && userInput3 > -1)
        userInput3++;
      else
        userInput3 = 1;
    }

    if (mouseX > (displayWidth / 2) + 175 && mouseX < (displayWidth / 2) + 205 && mouseY > (displayHeight / 2) - 13 && mouseY < (displayHeight / 2) + 17) {
      if (userInput4 < 4 && userInput4 > -1)
        userInput4++;
      else
        userInput4 = 1;
    }
  }
}

void keyPressed() {
  if (onSurveyPage == true) {
    if (keyCode == ENTER) {
      enterCounter++;
    }
  }
}

//Checks if ONE input is either a 1, 2, 3, or 4 
int surveyPointCounter(int userInput) {
  int answer = 0;
  if (userInput == 1)
    answer -= 2;
  else if (userInput == 2)
    answer -= 1;
  else if (userInput == 3)
    answer += 1;
  else if (userInput == 4)
    answer += 2;
  return answer;
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
  textSize(18);
  text("Click on the blank to change the values. 1 - strongly disagree, 2 - somewhat disagree, 3 - somewhat agree, 4 - strongly agree.", displayWidth / 2, 130);

  textAlign(LEFT);
  textSize(30);

  if (enterCounter >= 1) {
    text("1. I enjoy solitude: " + userInput1, displayWidth / 6.5, 200);
    text("2. I feel drained after spending time with a large group of people: " + userInput2, displayWidth / 6.5, 270);
    text("3. I have a smaller social circle: " + userInput3, displayWidth / 6.5, 340);
    text("4. I like to work through problems on my own: " + userInput4, displayWidth / 6.5, 410);
  }

  if (userInput1 != 0 && userInput2 != 0 && userInput3 != 0 && userInput4 != 0) {
    buttonCreator("click here to continue");
  }
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
  
  totalPoints += surveyPointCounter(userInput1);
  totalPoints += surveyPointCounter(userInput2);
  totalPoints += surveyPointCounter(userInput3);
  totalPoints += surveyPointCounter(userInput4);
  
  if (totalPoints <= -5 && totalPoints >= -8) {
    //Bubble expands 2x 
  } else if (totalPoints <= -1 && totalPoints >= -4) {
    //Bubble expands 1x
  } else if (totalPoints == 0) {
    //Bubble does not expand, basically don't need this else if statement but included to avoid confusion
  } else if (totalPoints <= 4 && totalPoints >= 1) {
    //Bubble shrinks 1x
  } else if (totalPoints <= 8 && totalPoints >= 5) {
    //Bubble shrinks 2x
  }
  
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
  }

  for (int i = 0; i < allBubbles.length; i++) {
    bubbleBumped = false;
    if (allBubbles[i].getRadius() != 0) {
      bubbleBumped = allBubbles[i].checkCollision(b);

      if (bubbleBumped) {
        screen = Screen.CONVO_SCREEN;
        bubbleBumped = false;
      }
    }
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
  background(150, 130, 50);
  int num = int(random(0, 1)); 
  reader = createReader(listOfFileNames[num]);
  textSize(32);
  fill(0);
  text("HLAKSJFLKSADF", width/4, 40);
  text("alskjdflaskdf", width/4, 80);
  text("asdlkfjsadf", width/4, 120);

  text("im gonna die!!!!!!!", width/4, 160);
  /* try {
   while ((line = reader.readLine()) != null) {
   background(150, 130, 50);
   text(line, width/4, height/2);
   delay(800);
   }
   reader.close();
   } 
   catch (IOException e) {
   e.printStackTrace();
   } */

  if (keyPressed) { 
    if (key == ENTER)
      screen = Screen.GAMEPLAY_SCREEN;
  }
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
