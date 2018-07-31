//Main file that's going to run everything
import processing.sound.*;

PFont myFont;
PImage img;
SoundFile file;

int clickCounter = 0; //Keeps track of the number of clicks
int enterCounter = 0; //Keeps track of how many times user hits ENTER for the survey page
int totalPoints = 0; //Keeps track of the total number of survey points
int userInput1, userInput2, userInput3, userInput4 = 0; 

Bubble mainBub = new Bubble(150, color(181, 235, 255, 150), displayWidth / 2, displayHeight / 2); 
Bubble[] allBubbles = new Bubble[5]; 

BufferedReader reader;

//String line = "hi";
String[] listOfFileNames = {"convo1.txt"};

boolean isDone = false; //used in line 62 for totaling up the survey points only ONCE
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
  file = new SoundFile(this, "windmill.mp3");
  file.play();

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
  } else if (screen == Screen.GAMEPLAY_SCREEN) {
    gamePlayScreen();

    //Totals up the points from the survey
    while (isDone == false) {
      totalPoints += surveyPointCounter(userInput1);
      totalPoints += surveyPointCounter(userInput2);
      totalPoints += surveyPointCounter(userInput3);
      totalPoints += surveyPointCounter(userInput4);
      isDone = true;
    }

    //Draws the shrinking or expanding bubble
    if (mainBub.getRadius() <= 500 && mainBub.getRadius() >= 50) {
      if (totalPoints <= -5 && totalPoints >= -8) {
        mainBub.setRadius(mainBub.getRadius() + 0.5);
      } else if (totalPoints <= -1 && totalPoints >= -4) {
        mainBub.setRadius(mainBub.getRadius() + 0.25);
      } else if (totalPoints <= 4 && totalPoints >= 1) {
        mainBub.setRadius(mainBub.getRadius() - 0.25);
      } else if (totalPoints <= 8 && totalPoints >= 5) {
        mainBub.setRadius(mainBub.getRadius() - 0.5);
      }
    }
  } else if (screen == Screen.CONVO_SCREEN) 
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
    if (mouseX > (displayWidth / 2) + 110 && mouseX < (displayWidth / 2) + 140 && mouseY > (displayHeight / 2) - 204 && mouseY < (displayHeight / 2) - 174) {
      if (userInput1 < 4 && userInput1 > -1)
        userInput1++;
      else
        userInput1 = 1;
    }

    if (mouseX > (displayWidth / 2) + 418 && mouseX < (displayWidth / 2) + 448 && mouseY > (displayHeight / 2) - 144 && mouseY < (displayHeight / 2) - 114) {
      if (userInput2 < 4 && userInput2 > -1)
        userInput2++;
      else
        userInput2 = 1;
    }

    if (mouseX > (displayWidth / 2) + 195 && mouseX < (displayWidth / 2) + 225 && mouseY > (displayHeight / 2) - 84 && mouseY < (displayHeight / 2) - 54) {
      if (userInput3 < 4 && userInput3 > -1)
        userInput3++;
      else
        userInput3 = 1;
    }

    if (mouseX > (displayWidth / 2) + 297 && mouseX < (displayWidth / 2) + 327 && mouseY > (displayHeight / 2) - 24 && mouseY < (displayHeight / 2) + 14) {
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

//Runs the screen with the survey questions 
void surveyScreen() {
  background(0);
  fill(255);
  textAlign(CENTER);

  textSize(50);
  text("SURVEY", displayWidth / 2, (displayHeight / 2) - 310);
  textSize(18);
  text("Hit enter to continue. Click on the blank to change the values. 1 - strongly disagree, 2 - somewhat disagree, 3 - somewhat agree, 4 - strongly agree.", displayWidth / 2, (displayHeight / 2) - 265);

  textAlign(CENTER);
  textSize(30);

  if (enterCounter >= 1) {
    text("1. I enjoy solitude: " + userInput1, displayWidth / 2, (displayHeight / 2) - 180 );
    text("2. I feel drained after spending time with a large group of people: " + userInput2, displayWidth / 2, (displayHeight / 2) - 120);
    text("3. I have a smaller social circle: " + userInput3, displayWidth / 2, (displayHeight / 2) - 60); 
    text("4. I like to work through problems on my own: " + userInput4, displayWidth / 2, (displayHeight / 2));
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
  text("INSTRUCTIONS", displayWidth / 2, (displayHeight / 2) - 310);
  textSize(30);
  text("1. Move your bubble around using the mouse.", displayWidth / 2, (displayHeight / 2) - 240);
  text("2. When you bump in a bubble, a conversation will take place between you", displayWidth / 2, (displayHeight / 2) - 180);
  text("and the person in their bubble.", displayWidth / 2, (displayHeight / 2) - 120);
  text("3. After you talk to the person, your bubble will either shrink or expand.", displayWidth / 2, (displayHeight / 2) - 60);
  text("4. The goal is to get as many bubbles as possible and pop your bubble.", displayWidth / 2, (displayHeight / 2));

  buttonCreator("click here to begin");
}

//Runs the gameplay screen
void gamePlayScreen() {
  background(255);
  noStroke();
  mainBub.set(mouseX, mouseY);
  mainBub.display();

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
      bubbleBumped = allBubbles[i].checkCollision(mainBub);

      if (bubbleBumped) {
        Bubble collideBubble = allBubbles[i];
        float collideBubbleRadius = collideBubble.getRadius();

        screen = Screen.CONVO_SCREEN;
        
        if (mainBub.getRadius() <= 500 && mainBub.getRadius() >= 50) {
          
          mainBub.setRadius(mainBub.getRadius() + (collideBubbleRadius / 2));
          collideBubble.setRadius(0);
        }
        
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
  String[] lines = loadStrings("convo1.txt");
  for(int i = 0; i < lines.length; i++) 
    text(lines[i], width/3, height/3 + (i*35)); 

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
