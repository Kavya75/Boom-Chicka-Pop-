//Main file that's going to run everything
import processing.sound.*;
import ddf.minim.*;

PFont myFont;
PImage img;
PImage backgroundImg;
PImage surveyImg;
PImage instrImg;
PImage convoImg;
SoundFile file;
AudioPlayer pop;
Minim minim;
PImage[] pics = new PImage[2];
int randomImage;

int clickCounter = 0; //Keeps track of the number of clicks
int enterCounterSurvey = 0; //Keeps track of how many times user hits ENTER for the survey page
int enterCounterInstruc = 0; //Keeos track of how many times user hits ENTER for the instructions page
int totalPoints = 0; //Keeps track of the total number of survey points
int userInput1, userInput2, userInput3, userInput4 = 0; 
int lineCounter = 0;

//initialize main bubble
Bubble mainBub = new Bubble(50, color(181, 235, 255, 150), displayWidth / 2, displayHeight / 2); 
Bubble[] allBubbles = new Bubble[5]; 

BufferedReader reader;

//String[] listOfFileNames = {"divorce", "depression"};
String[] listOfFileNames = {"parental"};
int randomFileName = -1;
String[][] stopLines = new String[listOfFileNames.length][5];


boolean isDone = false; //Used in line 62 for totaling up the survey points only ONCE
boolean isButton = false; //True if there is a button present on page, false if there is not
boolean bubbleBumped = false;
boolean onSurveyPage = false;
boolean onInstrucPage = false;
boolean convBGDisplayed = false; //Used to check if the conversation page background is drawn - Ensures that background is drawn once
boolean q1, q2, q3, q4 = false; //Used to display the survey questions one by one
boolean allLinesRead = false; //Moves from page to page
boolean noBubblesLeft = false;
boolean screenSwitch = false;
boolean option1 = false;
boolean option2 = false;
boolean mouseIn = false;
int buttonHit = 0;

int verticalSpaceMultiplier = 0; 
int startingHeight = displayHeight/8;
int fileCounter = 1;
boolean allFilesRead = false; //Moves from file to file
int stopFileNumber = -1; 

Bubble activeBubble;

public enum Screen {
  START_SCREEN, 
    SURVEY_SCREEN, 
    INSTRUC_SCREEN, 
    GAMEPLAY_SCREEN, 
    CONVO_SCREEN,
    FINAL_SCREEN
}

Screen screen = Screen.START_SCREEN;


void setup() {
  randomImage = int(random(0, pics.length));
  String[] imageNames = {"basketballBoy.png", "blackboi1.png", "blondeBeanie.png", 
    "blondeGirlPigTails.png", "blueberry.png", "caramelBoy.png", "coffeeGirl.png", "cookieBoi.png", 
    "DJboi.png", "farmerBoy.png", "greyBoy.png", "jabami.png", "Keshawn.png", "Mexicano.png", 
    "momNerd.png", "mushroom.png", "perryboi.png", "Rob.png", "taffyBoy.png"};

  for (int i = 0; i < pics.length; i++) 
    pics[i] = loadImage(imageNames[i]);


  String[] musicNames = {"Feelin' Good.mp3", "aspen-starlight.mp3", "breeze.mp3", "colors.mp3", 
    "colors.mp3", "dawn-light.mp3", "farewell.mp3", "here.mp3", "looking-up.mp3", 
    "oak.mp3", "ocean-of-sky.mp3", "skylark.mp3", "windmill.mp3"};
  int rando = int(random(0, musicNames.length)); 
  file = new SoundFile(this, musicNames[rando]);
  file.play();
  minim = new Minim(this);
  pop = minim.loadFile("Sonder Bubble Pop.mp3", 2048);
  fullScreen();

  smooth(8);
  noStroke();
  initializeBubbles();
  img = loadImage("bear.png");

  backgroundImg = loadImage("SonderBackground.png");
  backgroundImg.resize(displayWidth, displayHeight);

  surveyImg = loadImage("SurveyBackground.png");
  surveyImg.resize(displayWidth, displayHeight);

  instrImg = loadImage ("InstrBackground.png");
  instrImg.resize(displayWidth, displayHeight);

  convoImg = loadImage("ConvoBackground.png");
  convoImg.resize(displayWidth, displayHeight);
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
    allLinesRead = false;
    lineCounter = 0; 
    convBGDisplayed = false;

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
    if (mainBub.getRadius() <= 250 && mainBub.getRadius() >= 50 && noBubblesLeft == false) {
      if (totalPoints <= -5 && totalPoints >= -8) {
        mainBub.setRadius(mainBub.getRadius() + 0.1);
      } else if (totalPoints <= -1 && totalPoints >= -4) {
        mainBub.setRadius(mainBub.getRadius() + 0.05);
      } else if (totalPoints <= 4 && totalPoints >= 1) {
        mainBub.setRadius(mainBub.getRadius() - 0.05);
      } else if (totalPoints <= 8 && totalPoints >= 5) {
        mainBub.setRadius(mainBub.getRadius() - 0.1);
      }
    }

  } else if (screen == Screen.CONVO_SCREEN && convBGDisplayed == false) {
    delay(50);
    conversationScreen();
    convBGDisplayed = true;
  } else if (convBGDisplayed == true) {
    textScreen(); 
  } else if (screen == Screen.FINAL_SCREEN) {
    delay(200);
    finalScreen();
  }
}

boolean bubblesLeft(Bubble[] allBubbles) {
  for (int i = 0; i < allBubbles.length; i++) {
    if (allBubbles[i].getRadius() != 0) {
      return false;
    }
  }

  return true;
} 

void mouseClicked() {
  if (clickCounter != -1 && isButton == true && mouseX > (displayWidth / 2) - 100 && mouseX < (displayWidth / 2) + 100 && mouseY < (displayHeight / 2) + 145 && mouseY > (displayHeight / 2) + 85) {
    clickCounter++;
  }

  if (screen == Screen.CONVO_SCREEN && isButton) {

    if ((mouseX > displayWidth/2 - ("oneoneone".length()*16)/2 && 
      mouseX < displayWidth/2 + ("oneoneone".length()*16)/2) && 
      (mouseY >  startingHeight + (verticalSpaceMultiplier*40) + 50 -  32/2 
      && mouseY <  startingHeight + (verticalSpaceMultiplier*40) + 50 + 32/2)) {
      buttonHit = 1;
      background(175, 71, 71);
      lineCounter = 0;
      verticalSpaceMultiplier = 0;
      fileCounter = 5;
      allFilesRead = true;
    } else if ((mouseX > displayWidth/2 - ("twotwotwo".length()*16)/2 && 
      mouseX < displayWidth/2 + ("twotwotwo".length()*16)/2) && 
      (mouseY >  startingHeight + (verticalSpaceMultiplier*40) + 80 -  32/2 
      && mouseY <  startingHeight + (verticalSpaceMultiplier*40) + 80 + 32/2)) {
      buttonHit = 2;

      background(98, 104, 182);
      lineCounter = 0;
      verticalSpaceMultiplier = 0;
      if (fileCounter < findStopFile())
        fileCounter++;
      else
        allFilesRead = true;
    }
  }


  if (clickCounter == 0)
    screen = Screen.START_SCREEN;
  else if (clickCounter == 1)
    screen = Screen.SURVEY_SCREEN;
  else if (clickCounter == 2)
    screen = Screen.INSTRUC_SCREEN; 
  else if (clickCounter == 3) {
    screen = Screen.GAMEPLAY_SCREEN;
    clickCounter = -1;
  }

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
    if (key == ENTER || key == RETURN) {
      enterCounterSurvey++;
    }
  }

  if (onInstrucPage == true) {
    if (key == ENTER || key == RETURN) {
      enterCounterInstruc++;
    }
  }
  if ((key == ENTER || key == RETURN) && allFilesRead) { 
    screen = Screen.GAMEPLAY_SCREEN;
    screenSwitch = true;
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
  background(backgroundImg);
  myFont = createFont("Georgia", 100, true);
  textFont(myFont);
  textAlign(CENTER);
  fill(255);
  text("S  O  N  D  E  R", displayWidth / 2, displayHeight / 2);
  textSize(18);
  text("the realization that everyone has a story", displayWidth / 2, (displayHeight / 2) + 45);

  isButton = true;
  buttonCreator("click here to begin");
}

//Runs the screen with the survey questions 
void surveyScreen() {
  background(surveyImg);
  fill(255);
  textAlign(CENTER);
  isButton = false;

  textSize(50);
  text("SURVEY", displayWidth / 2, (displayHeight / 2) - 310);
  textSize(18);
  text("Click on the zero to change the values. Hit 'ENTER' to display the questions.", displayWidth / 2, (displayHeight / 2) - 275);
  text("KEY: 1 - strongly disagree, 2 - somewhat disagree, 3 - somewhat agree, 4 - strongly agree", displayWidth / 2, (displayHeight / 2) - 250);

  textAlign(CENTER);
  textSize(30);

  if (enterCounterSurvey >= 1) {
    text("1. I enjoy solitude: " + userInput1, displayWidth / 2, (displayHeight / 2) - 180 );
    text("2. I feel drained after spending time with a large group of people: " + userInput2, displayWidth / 2, (displayHeight / 2) - 120);
    text("3. I have a smaller social circle: " + userInput3, displayWidth / 2, (displayHeight / 2) - 60); 
    text("4. I like to work through problems on my own: " + userInput4, displayWidth / 2, (displayHeight / 2));
  }

  if (userInput1 != 0 && userInput2 != 0 && userInput3 != 0 && userInput4 != 0) {
    isButton = true;
    buttonCreator("click here to continue");
  }
}

//Runs the instructions screen
void instrucScreen() {
  onInstrucPage = true;
  background(instrImg);
  fill(255);
  textAlign(CENTER);
  isButton = false;
  textSize(50);
  text("INSTRUCTIONS", displayWidth / 2, (displayHeight / 2) - 310);
  textSize(20);
  text("Hit enter to display the instructions.", displayWidth/2, (displayHeight / 2) - 270);

  textSize(30);
  if (enterCounterInstruc >= 1) {
    text("1. Use the mouse to move your bubble around.", displayWidth / 2, (displayHeight / 2) - 210);
  }

  if (enterCounterInstruc >= 2) {
    text("2. When you bump in a bubble, a conversation will occur.", displayWidth / 2, (displayHeight / 2) - 130);
  }

  if (enterCounterInstruc >= 3) {
    text("3. Afterwards, your bubble will either shrink or expand.", displayWidth / 2, (displayHeight / 2) - 50);
  }

  if (enterCounterInstruc >= 4) {
    text("4. The goal is to get as many bubbles as possible and pop your bubble.", displayWidth / 2, (displayHeight / 2) + 30);
  }

  if (enterCounterInstruc >= 4) {
    isButton = true;
    buttonCreator("click here to begin");
  }
}

//Runs the gameplay screen
void gamePlayScreen() {
  verticalSpaceMultiplier = 0;
  buttonHit = 0;
  allFilesRead = false;
  fileCounter = 1;
  isButton = false;
  mouseIn = false;
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

  if (bubblesLeft(allBubbles) == true) {
    noBubblesLeft = true;
    
    screen = Screen.GAMEPLAY_SCREEN;
    
    pop = minim.loadFile("Sonder Bubble Pop.mp3", 2048);
    pop.play();
    mainBub.setRadius(0);
    
    screen = Screen.FINAL_SCREEN;
  }

  for (int i = 0; i < allBubbles.length; i++) {
    bubbleBumped = false;
    if (allBubbles[i].getRadius() != 0) {
      bubbleBumped = allBubbles[i].checkCollision(mainBub);

      if (bubbleBumped && noBubblesLeft == false) {
        pop = minim.loadFile("Sonder Bubble Pop.mp3", 2048);
        pop.play();

        Bubble collideBubble = allBubbles[i];
        if (mainBub.getRadius() <= 300 && mainBub.getRadius() >= 50) {
          mainBub.setRadius(mainBub.getRadius() + random(20, 30));
        }

        delay(100);
        screen = Screen.CONVO_SCREEN;
        collideBubble.setRadius(0);
        bubbleBumped = false;
        randomFileName = int(random(0, listOfFileNames.length));
      }
    }
  }
}

void finalScreen() {
  background(0);
  text("Thank you for playing", displayWidth / 2, (displayHeight / 2) - 120);
}


void initializeBubbles() { 
  for (int i = 0; i < allBubbles.length; i++) {
    int randomRadius = int(random(40, 50));
    int randomRedValue = int(random(10, 250)); 
    int randomBlueValue = int(random(10, 250)); 
    int randomGreenValue = int(random(10, 250)); 
    int randomXStart = int(random(10, displayWidth)); 
    int randomYStart = int(random(10, displayHeight)); 
    float randomXDir = int(random(-4, -1)); 
    float randomYDir = int(random(1, 4)); 
    allBubbles[i] = new Bubble(randomRadius, color(randomRedValue, 
      randomGreenValue, randomBlueValue, 150), randomXStart, randomYStart, 
      randomXDir, randomYDir, pics.length);
  }
}

//Sets the conversation background to a solid color and
//  checks if user clicks or hits ENTER. If yes, will return to gamePlayScreen
void conversationScreen() { 
  background(convoImg);
  image(pics[activeBubble.randImg], displayWidth/20, startingHeight * 5, 230, 280);
  if (keyPressed) {
    if (key == ENTER && allFilesRead) { 
      screen = Screen.GAMEPLAY_SCREEN;
      screenSwitch = true;
    }
  }
}

//Displays the text from the text file line by line
void textScreen() {
  textAlign(CENTER); 
  String fileN = listOfFileNames[randomFileName] + fileCounter + ".txt";
  String[] lines = loadStrings(fileN);

  if (lineCounter < lines.length-2) {
    isButton = false;
    textSize(28);
    fill(0);
    if (startingHeight + (verticalSpaceMultiplier*40) + 80 > displayHeight) {
      verticalSpaceMultiplier = 0;
      background(255);
    }
    text(lines[lineCounter], displayWidth/2, startingHeight + (verticalSpaceMultiplier*40)+40);
    if (buttonHit == 1)
      lineCounter += 2;
    verticalSpaceMultiplier++;
    lineCounter++;    
    buttonHit = 0;
    //  delay(1000);
  } else if (lineCounter >= lines.length-2 && lineCounter < lines.length && fileCounter != findStopFile() && fileCounter != 5) {

    isButton = true;
    noBoxButtonCreator(lines[lineCounter], displayWidth/2, startingHeight + (verticalSpaceMultiplier*40) + 50, lines[lineCounter].length()*16, 32);
    noBoxButtonCreator(lines[lineCounter+1], displayWidth/2, startingHeight + (verticalSpaceMultiplier*40) + 80, lines[lineCounter].length()*16, 32);
    lineCounter = lines.length;
    //   delay(1000);
  } else if (lineCounter >= lines.length-2 && lineCounter < lines.length && (fileCounter == findStopFile() || fileCounter == 5)) {
    text(lines[lineCounter], displayWidth/2, startingHeight + (verticalSpaceMultiplier*40)+40);
    lineCounter++;
    verticalSpaceMultiplier++;
    delay(1000);
  }
  if (lineCounter == lines.length || fileCounter == 5) {
    println("i hope this is true");
    allLinesRead = true;
  }

  if ((fileCounter == findStopFile() || fileCounter == 5) && allLinesRead) {
    allFilesRead = true;
    println("aslkjdfasdf");
  } else
    allFilesRead = false;
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


void noBoxButtonCreator(String buttonLabel, int buttonX, int buttonY, int buttonLength, int buttonHeight) {
  textAlign(CENTER);
  if (mouseX > buttonX - buttonLength/2 && mouseX < buttonX + buttonLength/2
    && mouseY < buttonY + buttonHeight/2 && mouseY > buttonY-buttonHeight/2) {
    fill(10, 200, 80);
    stroke(10, 200, 80);
    textSize(32);
    text(buttonLabel, buttonX, buttonY);
    mouseIn = true;
  } else {
    textSize(32);
    fill(80, 5, 100);
    stroke(80, 5, 100);
    text(buttonLabel, buttonX, buttonY);
    mouseIn = false;
  }
}

void mouseInBounds(int xPt, int yPt, int xDistance, int yDistance, int whichButton) { 
  stroke(0);
  if ((mouseX > xPt - xDistance/2 && mouseX < xPt + xDistance/2) && 
    (mouseY > yPt -  yDistance/2 && mouseY < yPt + yDistance/2)) {
    mouseIn = true;
    if (yPt == startingHeight + (verticalSpaceMultiplier*40) + 50)
      buttonHit = 1;
    if (yPt == startingHeight + (verticalSpaceMultiplier*40) + 80) 
      buttonHit = 2;
  } else {
    mouseIn = false;
    buttonHit = 0;
  }
}

int findStopFile() { 
  switch (randomFileName) {
  case 0: 
    stopFileNumber = 3; 
    break;
  case 1: 
    stopFileNumber = 3;  
    break;
  case 2: 
    stopFileNumber = 3;
  default: 
    stopFileNumber = 1;
    break;
  }
  return stopFileNumber;
}
