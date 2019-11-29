//Dec 18, 2018
//A Potion Café game where the user mixes colours to form a specific colour.

//Global variable declaration
int patron=0;                     
int bubbleY=0;                    
int bubbleX=0;                    
PFont instructionWords;           
PFont menuChoices;               
PFont patronWords;                
String state;           
int titleX=0;                     
int patronX=0;                    
int level=0;                      
int score=0;                      
int colour=0;                     
int red=0;                        
int blue=0;                      
int green=0;                    
int correctRed=0;              
int correctBlue=0;               
int correctGreen=0;              
String colourType;                
int minute;                       
int second;                       
int time;                         

/*Global Variable Dictionary
 Name              |Type    |Purpose
 -------------------------------------------
 patron            |int     |Decides which patron shows up
 bubbleY           |int     |Animates the bubbles moving on the Y axis
 bubbleX           |int     |Animates the bubbles moving on the X axis
 instructionWords  |PFont   |Used for instructions throughout program
 menuChoices       |PFont   |Used for the text in mainMenu() and in scores
 patronWords       |PFont   |Used for the words spoken by the patron
 state             |String  |Used to change the states in the program
 titleX            |int     |Animates the title along the X axis
 patronX           |int     |Animates the patron along the X axis
 level             |int     |Holds level number
 score             |int     |Holds the score
 colour            |int     |Corresponds to a colour in a list
 red               |int     |Holds the value of red entered by the user
 green             |int     |Holds the value of green entered by the user
 blue              |int     |Holds the value of blue entered by the user
 correctRed        |int     |Correct amount of red in potion
 correctGreen      |int     |Correct amount of green in potion
 correctBlue       |int     |Correct amount of blue in potion
 colourType        |String  |The potion bottle or colour the user is currently editing
 minute            |int     |Holds the number of minutes since the game began
 seconds           |int     |Holds the number of seconds on the timer
 time              |int     |Holds the total time(in seconds) since beginning of game
 */

void setup()
{
  state="splashScreen";                                                  //Sets state to splashScreen, allows the beginning animation to be played                                                        //Initialises the variable
  frameRate(16);                                                         //Sets frameRate
  instructionWords=loadFont("NSimSun-20.vlw");                           
  patronWords=loadFont("MalgunGothic-Semilight-18.vlw");                 
  menuChoices=loadFont("OCRAExtended-33.vlw");
  level=1;                                                               //Sets default level to beginner
  colourType="red";                                                      //Sets default potion bottle/colour
  size(800, 500);
}

//Title of the game
void title()
{
  PFont title;                                                           //Font variable used for the title
  title=loadFont("TimesNewRomanPS-ItalicMT-53.vlw");
  textFont(title);
  fill(255);
  text("Potion Café", -200+titleX, 230);                                 //Writes title

  if (titleX>450) {                                                      //If structure that stops the animation of the title at a certain point
    titleX+=0;
  } else {
    titleX+=7;
  }

  //Prompt to continue
  textFont(instructionWords);
  text("Press any key to continue", 270, 300);
}

void draw() {
  background(0);                                  //Sets the background colour

  if (state.equals("splashScreen")) {             //If structure that changes methods depending on the state
    title();
    splashScreen();
  } else if (state.equals("mainMenu")) {
    mainMenu();
  } else if (state.equals("play")) {
    display();
  } else if (state.equals("evaluation")) {
    evaluation();
  } else if (state.equals("instructions")) {
    instructions();
  } else if (state.equals("levelSelection")) {
    levelSelection();
  } else if (state.equals("scores")) {
    scores();
  } else if (state.equals("evaluation")) {
    evaluation();
  } else if (state.equals("goodbye")) {
    goodbye();
  }
}

void splashScreen()
{
  if (bubbleY>630) {                                             //if structure that repeats the animations of the bubbles
    bubbleY=-20;
  } else if (bubbleX>1120) {
    bubbleX=-10;
  }
  noStroke();
  for (int gradient = 80; gradient > 1; gradient--) {            //Bubble gradient referenced from processing forums(circle gradient). Username: janjacobsv. URL: https://forum.processing.org/one/topic/circle-gradient.html
    fill(255, 195, 195, gradient);
    ellipse(100, 490-bubbleY, 80-gradient, 75-gradient);

    fill(#F0B9FF, gradient);
    ellipse(250, 510-bubbleY, 90-gradient, 95-gradient);

    fill(#B0AEFA, gradient);
    ellipse(540, 505-bubbleY, 90-gradient, 85-gradient);

    fill(#AED8FA, gradient);
    ellipse(670, 560-bubbleY, 85-gradient, 85-gradient);

    fill(255, 195, 195, gradient);
    ellipse(750, 580-bubbleY, 100-gradient, 95-gradient);

    fill(#C1F3FF, gradient);
    ellipse(400, 470-bubbleY, 70-gradient, 70-gradient);

    //Horizontal bubbles
    fill(#C1FFF7, gradient);
    ellipse(-200+bubbleX, 180, 70-gradient, 70-gradient);

    fill(#BCBAF0, gradient);
    ellipse(-250+bubbleX, 340, 90-gradient, 85-gradient);

    //Stationary bubbles
    fill(#D7FAB8, gradient);
    ellipse(200, 90, 80-gradient, 75-gradient);

    fill(#EEFAB8, gradient);
    ellipse(220, 190, 80-gradient, 75-gradient);

    fill(#FAE4B8, gradient);
    ellipse(350, 390, 80-gradient, 75-gradient);

    fill(#BCB8FA, gradient);
    ellipse(470, 490, 80-gradient, 75-gradient);

    fill(#FAB6F3, gradient);
    ellipse(530, 90, 100-gradient, 95-gradient);

    fill(#FAE4B8, gradient);
    ellipse(640, 260, 90-gradient, 85-gradient);

    fill(#B6FAEE, gradient);
    ellipse(120, 350, 85-gradient, 85-gradient);
  }
  bubbleY+=4;                                                    //Adds value to the variable, which creates the animation
  bubbleX+=7;                                                    //Adds value to the variable, which creates the animation
}

void keyReleased() {
  //Changes states(methods)
  if (state.equals("splashScreen")||state.equals("instructions")||state.equals("scores")) {
    state="mainMenu";
  } else if (state.equals("mainMenu")) {                      //changes states depending on key input
    if (key=='1') {
      state="play";                                           //resets game variables
      score=0;
      colourType="red";
      time=0;
      second=0;
      minute=0;
    } else if (key=='2') {
      state="instructions";
    } else if (key=='3') {
      state="levelSelection";
    } else if (key=='4') {
      state="scores";
    } else if (key=='5') {
      state="goodbye";
    }
  } else if (state.equals("levelSelection")) {                   //if structure changing the level
    if (key=='2') {
      level=2;
      state="mainMenu";                                          //goes back to menu
    } else if (key=='1') {
      level=1;
      state="mainMenu";
    }
  }
  //Colour controls(type of colour)
  else if (state.equals("play")) {
    if (keyCode==RIGHT) {                                          //changes to colour immediately right of the current one
      if (colourType.equals("red")) {
        colourType="green";
      } else if (colourType.equals("green")) {
        colourType="blue";
      }
    } else if (keyCode==LEFT) {                                    //changes to colour immediately left of the current one
      if (colourType.equals("green")) {
        colourType="red";
      } else if (colourType.equals("blue")) {
        colourType="green";
      }
      //Colour controls(quantity of colour)
    } else if (keyCode==UP) {                                      //increases quantity of colour
      if (level==1) {
        if (colourType.equals("red")&&red<250) {
          red+=50;
        } else if (colourType.equals("green")&&green<250) {
          green+=50;
        } else if (colourType.equals("blue")&&blue<250) {
          blue+=50;
        }
      } else if (level==2) {
        if (colourType.equals("red")&&red<250) {
          red+=10;
        } else if (colourType.equals("green")&&green<250) {
          green+=10;
        } else if (colourType.equals("blue")&&blue<250) {
          blue+=10;
        }
      }
    } else if (keyCode==DOWN) {                                     //decreases quantity of colour
      if (level==1) {
        if (colourType.equals("red")&&red>0) {
          red-=50;
        } else if (colourType.equals("green")&&green>0) {
          green-=50;
        } else if (colourType.equals("blue")&&blue>0) {
          blue-=50;
        }
      } else if (level==2) {
        if (colourType.equals("red")&&red>0) {
          red-=10;
        } else if (colourType.equals("green")&&green>0) {
          green-=10;
        } else if (colourType.equals("blue")&&blue>0) {
          blue-=10;
        }
      }
    }
  }
}

void mainMenu()
{
  patron=int(random(1, 4));                                  //randomly chooses the patron everytime
  colour=int(random(1, 5));                                  //randomly choosing the colour everytime
  time=0;
  patronX=-400;                                              //makes the patron animation start outside of screen(easier to implement)
  red=0;
  green=0;
  blue=0;
  noStroke();
  fill(10);
  rect(0, 0, 800, 500);
  //bubbles(stationary)
  for (int gradient1 = 80; gradient1 > 1; gradient1--) {      //bubble gradient code refernced fom processing forums
    fill(#B6FAEE, gradient1);
    ellipse(120, 350, 85-gradient1, 85-gradient1);

    fill(#E8B388, gradient1);
    ellipse(680, 350, 75-gradient1, 75-gradient1);

    fill(#FC8AED, gradient1);
    ellipse(120, 180, 115-gradient1, 115-gradient1);

    fill(#71B0ED, gradient1);
    ellipse(620, 130, 125-gradient1, 125-gradient1);

    fill(#9EED71, gradient1);
    ellipse(500, 420, 115-gradient1, 115-gradient1);
  }
  textFont(menuChoices);
  //title
  fill(255);
  textSize(48);
  text("Main Menu", 280, 100);
  
  //choices
  textSize(33);
  text("1. Play\n2. Instructions\n3. Level Selection\n4. Scores\n5. Exit", 200, 200);
  
  //instructions
  textFont(instructionWords);
  textSize(20);
  text("Press the 1, 2, 3, 4, or 5\nkeys, depending on your\nchoice", 170, 400);
}
void instructions()
{
  fill(0);
  rect(0, 0, 800, 500);
  //bubbles(stationary)
  for (int gradient2 = 80; gradient2 > 1; gradient2--) {
    fill(#C473ED, gradient2);
    ellipse(670, 80, 145-gradient2, 145-gradient2);

    fill(#F58A43, gradient2);
    ellipse(140, 100, 95-gradient2, 95-gradient2);
  }

  fill(255);
  textSize(48);
  textFont(menuChoices);
  //title
  text("Instructions", 270, 100);

  //text
  textFont(instructionWords);
  textSize(18);
  text("A character will show up on screen, and request a colour\n\nYou shall have to mix that colour out of red, blue, and green.\n\nUse your lEFT & RIGHT arrow keys to change between colours.\n\nUse your UP & DOWN arrow keys to change quantities of each.\n\nRemember, your game is timed!\n\nOnce done, click SEND button at the top of the screen.\n\nA score will be given out of 100, depending on accuracy and speed.", 100, 160);
  //prompt
  textFont(instructionWords);
  textSize(16);
  text("Press any key to go back to menu", 240, 450);
}

void levelSelection()
{
  fill(0);
  rect(0, 0, 800, 500);
  //bubbles(stationary)
  for (int gradient3 = 80; gradient3 > 1; gradient3--) {          //bubble gradient code referenced fom processing forums
    fill(#C473ED, gradient3);
    ellipse(700, 420, 135-gradient3, 135-gradient3);

    fill(#F08CA0, gradient3);
    ellipse(500, 420, 105-gradient3, 105-gradient3);

    fill(#8CA9F0, gradient3);
    ellipse(610, 310, 75-gradient3, 75-gradient3);

    fill(#9EED71, gradient3);
    ellipse(620, 120, 125-gradient3, 125-gradient3);
  }
  //title
  fill(255);
  textFont(menuChoices);
  text("Level Selection", 150, 100);
  textFont(instructionWords);

  //selections
  text("1. Press 1 for the beginner level. Here all\n   colour values are multiples of 50\n\n2. Press 2 for the advanced level, colour\n   values are multiples of 10", 100, 230);
}

//Game method
void display()
{
  if (frameCount%16==0&&second<60) {       
    second++;
  } else if (second==60) {                      //Adds minute if second is 60
    second=0;
    minute++;
  }
  time=minute*60+second;                       //calculation for time

  String potionName=" ";                       //Variable holds the name of the current potion

  //Cafe background
  PImage tableChairs;                          //A PNG image for the background tables and chairs - http://www.sclance.com/pngs/cafe-table-png/view-page-1.htm
  PImage counter;                              //Marble image used for the counter - https://www.amazon.ca/d-c-fix-Decorative-Self-Adhesive-Marble-346-0306/dp/B00504QXM0

  strokeWeight(1);
  fill(#B1EDE5);
  rect(0, 0, 800, 500);
  
  //Windows
  stroke(0);
  fill(255);
  rect(0, 0, 200, 120);                        //first window
  fill(#93BDFF);                               //window panes(top)
  rect(-140, 10, 160, 45);
  rect(30, 10, 160, 45);
  rect(-140, 65, 160, 45);                     //window panes(bottom)
  rect(30, 65, 160, 45);
  fill(255);
  rect(400, 0, 350, 120);                      //second window
  fill(#93BDFF);                               //window panes(top)
  rect(410, 10, 160, 45);
  rect(580, 10, 160, 45);
  rect(410, 65, 160, 45);                      //window panes(bottom)
  rect(580, 65, 160, 45);

  //Tables and chairs
  tableChairs=loadImage("ISP_table_chairs.png");
  image(tableChairs, -30, 100, 300, 280);
  image(tableChairs, 150, 40, 250, 210);
  image(tableChairs, 400, 40, 250, 210);
  image(tableChairs, 600, 100, 300, 280);

  if (patronX<-150) {                                     //if structure stopping the patron animation
    patronX+=10;
  } else {
    patronX+=0;
  }
  if (patron==1) {                                        //if structure that changes the patron depending on a random variable
    //Wizard patron
    fill(255);
    stroke(0);
    //Arms
    beginShape();                                                                        //left arm
    vertex(327+patronX, 278);
    bezierVertex(302+patronX, 256, 305+patronX, 256, 323+patronX, 262);                  //left arm
    endShape();
    beginShape();                                                                        //right arm
    vertex(472+patronX, 278);
    bezierVertex(495+patronX, 256, 495+patronX, 256, 475+patronX, 262);
    endShape();
    //Legs
    triangle(360+patronX, 312, 355+patronX, 330, 375+patronX, 320);                      //left leg
    triangle(440+patronX, 312, 445+patronX, 330, 425+patronX, 320);                      //right leg
    //Body: main
    ellipse(400+patronX, 250, 155, 150);
    //Face: eyes
    bezier(360+patronX, 250, 365+patronX, 244, 370+patronX, 244, 375+patronX, 250);      //left eye
    bezier(420+patronX, 250, 425+patronX, 244, 430+patronX, 244, 435+patronX, 250);      //right eye
    //Face: mouth
    bezier(380+patronX, 255, 380+patronX, 270, 388+patronX, 270, 400+patronX, 260);      //left curve
    bezier(400+patronX, 260, 410+patronX, 270, 420+patronX, 270, 418+patronX, 255);      //right curve
    //Wand: stick
    line(489+patronX, 238, 485+patronX, 270);
    //Wand: glowing magic topper
    noStroke();
    fill(27, 10, 126, 50);
    ellipse(490+patronX, 230, 20, 20);
    fill(27, 10, 126, 100);
    ellipse(490+patronX, 230, 18, 18);
    fill(27, 10, 126, 130);
    ellipse(490+patronX, 230, 15, 15);
    //Bowtie: straps
    beginShape();                                                                        //left strap
    vertex(327+patronX, 280);
    bezierVertex(385+patronX, 300, 430+patronX, 300, 474+patronX, 280);
    bezierVertex(430+patronX, 290, 385+patronX, 290, 326+patronX, 280);
    endShape();
    //Bowtie: bow
    stroke(0);
    fill(#9B7CF5);
    triangle(400+patronX, 290, 380+patronX, 300, 380+patronX, 280);                     //left side
    triangle(400+patronX, 290, 420+patronX, 300, 420+patronX, 280);                     //right side
    fill(#2E1871);
    ellipse(400+patronX, 290, 8, 7);//middle knot
    //Hat: brim
    fill(#191679);
    beginShape();
    vertex(327+patronX, 220);
    bezierVertex(290+patronX, 245, 470+patronX, 180, 430+patronX, 180);
    endShape();
    //Hat: main
    beginShape();
    vertex(327+patronX, 220);
    vertex(430+patronX, 180);
    vertex(360+patronX, 130);
    vertex(340+patronX, 130);
    vertex(310+patronX, 170);
    vertex(335+patronX, 160);
    endShape();
    line(327+patronX, 220, 337+patronX, 145);
    //Hat: pattern
    fill(#EDF258);
    ellipse(370+patronX, 150, 10, 10);
    ellipse(350+patronX, 180, 28, 28);
    ellipse(382+patronX, 185, 15, 15);
    ellipse(350+patronX, 150, 7, 7);
    ellipse(400+patronX, 175, 7, 7);
  } else if (patron==2) {
    //Harry Potter patron
    stroke(0);
    //Legs
    fill(50);
    triangle(360+patronX, 312, 355+patronX, 330, 375+patronX, 320);                    //left leg
    triangle(440+patronX, 312, 445+patronX, 330, 425+patronX, 320);                    //right leg
    //Body: main
    fill(#F5DABE);
    ellipse(400+patronX, 250, 155, 150);
    //Face: eyes
    bezier(360+patronX, 250, 365+patronX, 244, 370+patronX, 244, 375+patronX, 250);    //left eye
    bezier(420+patronX, 250, 425+patronX, 244, 430+patronX, 244, 435+patronX, 250);    //right eye
    //Face: mouth
    bezier(380+patronX, 255, 380+patronX, 270, 388+patronX, 270, 400+patronX, 260);    //left curve
    bezier(400+patronX, 260, 410+patronX, 270, 420+patronX, 270, 418+patronX, 255);    //right curve
    //Glasses
    fill(255, 255, 255, 80);
    ellipse(366+patronX, 248, 30, 30);                                                 //left lens
    ellipse(430+patronX, 248, 30, 30);                                                 //right lens
    line(382+patronX, 248, 415+patronX, 248);                                          //glasses bridge
    //Arms
    fill(#F5DABE);
    arc(370+patronX, 285, 15, 10, radians(210), radians(510));                         //(my left) arm
    arc(430+patronX, 285, 15, 10, radians(30), radians(330));                          //(my right) arm
    //Hair
    fill(0);
    beginShape();
    vertex(320+patronX, 245);
    bezierVertex(320+patronX, 148, 470+patronX, 148, 480+patronX, 240);                //biggest curve
    bezierVertex(465+patronX, 240, 455+patronX, 235, 450+patronX, 230);
    bezierVertex(455+patronX, 240, 460+patronX, 242, 460+patronX, 244);
    bezierVertex(445+patronX, 244, 438+patronX, 240, 433+patronX, 235);
    bezierVertex(434+patronX, 237, 435+patronX, 239, 436+patronX, 240);
    bezierVertex(420+patronX, 235, 400+patronX, 225, 380+patronX, 210);
    bezierVertex(360+patronX, 230, 350+patronX, 235, 340+patronX, 240);
    bezierVertex(341+patronX, 238, 342+patronX, 237, 343+patronX, 235);
    endShape(CLOSE);
    beginShape();                                                                      //hair that sticks up
    vertex(398+patronX, 170);
    vertex(390+patronX, 150);
    vertex(415+patronX, 145);
    vertex(395+patronX, 153);
    endShape(CLOSE);
    //Scar
    line(380+patronX, 218, 377+patronX, 230);
    line(377+patronX, 230, 384+patronX, 228);
    line(384+patronX, 228, 382+patronX, 238);
    //Uniform
    beginShape();
    fill(0);
    vertex(336+patronX, 293);
    bezierVertex(370+patronX, 335, 431+patronX, 335, 464+patronX, 293);
    endShape();
    //tie
    fill(#FF3C15);
    quad(400+patronX, 290, 395+patronX, 310, 400+patronX, 315, 405+patronX, 310); 
    fill(#FCD44C);
    triangle(395+patronX, 285, 405+patronX, 285, 400+patronX, 295);                      //top knot
  } else if (patron==3) {
    //Necromancer patron
    stroke(0);
    //Cloak
    fill(#120936);
    beginShape();
    vertex(300+patronX, 340);
    bezierVertex(310+patronX, 320, 340+patronX, 280, 320+patronX, 250);
    bezierVertex(300+patronX, 230, 340+patronX, 200, 330+patronX, 190);
    bezierVertex(340+patronX, 170, 390+patronX, 130, 460+patronX, 180);
    bezierVertex(480+patronX, 195, 480+patronX, 240, 485+patronX, 250);
    bezierVertex(480+patronX, 280, 475+patronX, 300, 480+patronX, 350);
    bezierVertex(420+patronX, 370, 370+patronX, 340, 300+patronX, 340);
    endShape();
    //hood opening
    fill(#C0E3D3);
    beginShape();
    vertex(340+patronX, 250);
    bezierVertex(370+patronX, 270, 420+patronX, 270, 460+patronX, 250);
    bezierVertex(440+patronX, 170, 350+patronX, 170, 340+patronX, 250);
    endShape();
    //Face: eyes
    bezier(360+patronX, 230, 365+patronX, 224, 370+patronX, 224, 375+patronX, 230);      //left eye
    bezier(420+patronX, 230, 425+patronX, 224, 430+patronX, 224, 435+patronX, 230);      //right eye
    //Face: mouth
    bezier(380+patronX, 235, 380+patronX, 250, 388+patronX, 250, 400+patronX, 240);      //left curve
    bezier(400+patronX, 240, 410+patronX, 250, 420+patronX, 250, 418+patronX, 235);      //right curve
    //Arms
    stroke(255);
    fill(#120936);
    arc(370+patronX, 285, 15, 10, radians(210), radians(510));                           //(my left) arm
    arc(430+patronX, 285, 15, 10, radians(30), radians(330));                            //(my right) arm
    //Skull ornament
    fill(255);                                                                           //main portion
    rect(394+patronX, 290, 12, 16);
    ellipse(400+patronX, 290, 20, 20);
    stroke(0);                                                                           //skull eyes
    strokeWeight(3);
    point(405+patronX, 291);                                                             //right eye
    point(395+patronX, 291);                                                             //left eye
    strokeWeight(2);
    line(397+patronX, 300, 397+patronX, 310);                                            //skull teeth
    line(403+patronX, 300, 403+patronX, 310);
    //Skull clip(on head);
    fill(255);                                                                           //main portion
    strokeWeight(1);
    stroke(255);
    rect(355+patronX, 195, 10, 14);
    ellipse(360+patronX, 196, 17, 17);
    stroke(0);                                                                           //skull eyes
    strokeWeight(3);
    point(364+patronX, 195);
    point(356+patronX, 195);
    strokeWeight(1);                                                                     //skull teeth
    line(357+patronX, 203, 357+patronX, 210);
    line(362+patronX, 203, 362+patronX, 210);
  }

  //Counter
  counter=loadImage("ISP_counter.jpg");                              //counter image from: https://www.amazon.ca/d-c-fix-Decorative-Self-Adhesive-Marble-346-0306/dp/B00504QXM0
  image(counter, 0, 300, 800, 500);
  line(0, 300, 800, 300);

  //Potion bottles
  //red bottle(round)
  noStroke();
  fill(#FF0000);
  arc(115, 410, 90, 90, radians(350), radians(550), CHORD);
  fill(#FA8181, 120);
  rect(100, 320, 30, 55);
  fill(#FA8181, 120);
  ellipse(115, 410, 90, 90);

  //green bottle(triangular)
  noStroke();
  fill(#0EAD0C);
  beginShape();
  vertex(505, 360);
  vertex(535, 360);
  vertex(535, 400);
  vertex(570, 450);
  vertex(470, 450);
  vertex(505, 400);
  endShape(CLOSE);

  fill(#0EAD0C, 120);
  beginShape();
  vertex(505, 330);
  vertex(535, 330);
  vertex(535, 400);
  vertex(570, 450);
  vertex(470, 450);
  vertex(505, 400);
  endShape(CLOSE);

  //blue bottle(triangular)
  fill(#0829FA);
  beginShape();
  vertex(585, 360);
  vertex(615, 360);
  vertex(615, 400);
  vertex(650, 450);
  vertex(550, 450);
  vertex(585, 400);
  endShape(CLOSE);

  fill(#0829FA, 120);
  beginShape();
  vertex(585, 330);
  vertex(615, 330);
  vertex(615, 400);
  vertex(650, 450);
  vertex(550, 450);
  vertex(585, 400);
  endShape(CLOSE);

  //Cauldron
  stroke(255);
  fill(0);
  bezier(235, 330, 205, 480, 422, 480, 390, 330);
  fill(red, green, blue);
  ellipse(312, 330, 153, 50);   //Top (where the colour shows)

  //Colour codes
  if (level==1) {
    if (colour==1) {
      correctRed=150;                                            //Weather potion
      correctGreen=150;
      correctBlue=200;
      potionName="Weather Potion";
    } else if (colour==2) {  
      correctRed=250;                                            //Rose elixir
      correctGreen=150;
      correctBlue=200;
      potionName="Rose Elixir";
    } else if (colour==3) {
      correctRed=100;                                            //Tropical brew
      correctGreen=250;
      correctBlue=50;
      potionName="Tropical Brew";
    } else if (colour==4) {
      correctRed=50;                                             //Lake Draught
      correctGreen=150;
      correctBlue=200;
      potionName="Lake Draught";
    }
  } else if (level==2) {
    if (colour==1) {
      correctRed=200;                                            //Dream potion
      correctGreen=90;
      correctBlue=240;
      potionName="Dream Potion";
    } else if (colour==2) {
      correctRed=240;                                            //Sandstorm potion
      correctGreen=190;
      correctBlue=80;
      potionName="Sandstorm Potion";
    } else if (colour==3) {
      correctRed=0;                                              //Midnight elixir
      correctGreen=10;
      correctBlue=120;
      potionName="Midnight Elixir";
    } else if (colour==4) {
      correctRed=60;                                             //Storm Extract
      correctGreen=60;
      correctBlue=60;
      potionName="Storm Extract";
    }
  }

  //Speech bubble
  fill(255);
  stroke(0);
  ellipse(630+patronX, 240, 270, 90);
  fill(0);
  textFont(patronWords);
  text("I would like a "+potionName+" ", 510+patronX, 240);    //patron's request
  fill(correctRed, correctGreen, correctBlue);                 //patron's colour
  rect(600+patronX, 245, 40, 20);

  //Colour labels
  if (colourType.equals("red")) {                              //red label
    fill(255, 0, 0);
    textSize(20);
    text("RED", 100, 480);
  } else if (colourType.equals("green")) {                     //green label
    fill(0, 255, 0);
    textSize(20);
    text("GREEN", 490, 480);
  } else if (colourType.equals("blue")) {                      //blue label
    fill(0, 0, 255);
    textSize(20);
    text("BLUE", 580, 480);
  }

  //Quantity labels
  fill(255, 0, 0);                          //red label
  textSize(20);
  text(red, 170, 410);
  fill(0, 255, 0);                          //green label
  textSize(20);
  text(green, 460, 410);
  fill(0, 0, 255);                          //blue label
  textSize(20);
  text(blue, 630, 410);

  //SEND button
  fill(#140867);
  rect(700, 0, 50, 25);
  fill(255);
  textFont(instructionWords);
  text("SEND", 705, 20);

  //Timer
  fill(#140867);
  rect(750, 0, 50, 25);
  fill(255);
  if (second<10) {
    text(minute+":0"+ second, 757, 20);          //puts a 0 if the number of seconds is a single digit
  } else if (second>=10) {
    text(minute+":"+ second, 757, 20);           //removes 0 if the number of seconds is a double digit
  }
}

void mouseReleased() {
  if (state.equals("play")) {                                                             //goes to evaluation() if SEND button is pressed
    if (mouseX>700&&mouseX<750&&mouseY>0&&mouseY<25) {
      state="evaluation";
      if (red==correctRed&&green==correctGreen&&blue==correctBlue) {                      //if structure for perfect accuracy
        score+=50;
      }
      //Patron evaluation: level 1(accuracy)
      if (level==1) {                                                //if structures for determining the accuracy of the potion colour
        if ((red<=(correctRed-50)||red>=(correctRed+50))&&(green<=(correctGreen-50)||green>=(correctGreen+50))&&(blue<=(correctBlue-50)||blue>=(correctBlue+50))) {
          score+=0;
        } else if ((red<=(correctRed-50)||red>=(correctRed+50))&&(green<=(correctGreen-50))||green>=(correctGreen+50)) {
          score+=10;
        } else if ((red<=(correctRed-50)||red>=(correctRed+50))&&(blue<=(correctBlue-50)||blue>=(correctBlue+50))) {
          score+=10;
        } else if ((blue<=(correctBlue-50)||blue>=(correctBlue+50))&&green<=(correctGreen-50)||green>=(correctGreen+50)) {
          score+=10;
        } else if ((red<=(correctRed-50)||red>=(correctRed+50))||(green<=(correctGreen-50)||green>=(correctGreen+50))||(blue<=(correctBlue-50)||blue>=(correctBlue+50))) {
          score+=30;
        }
      }
      //Patron evaluation: level 2(accuracy)
      else if (level==2) {
        if ((red<=(correctRed-30)||red>=(correctRed+30))&&(green<=(correctGreen-30)||green>=(correctGreen+30))&&(blue<=(correctBlue-30)||blue>=(correctBlue+30))) {
          score+=0;
        } else if ((red<=(correctRed-30)||red>=(correctRed+30))&&(green<=(correctGreen-30))||green>=(correctGreen+30)) {
          score+=10;
        } else if ((red<=(correctRed-30)||red>=(correctRed+30))&&(blue<=(correctBlue-30)||blue>=(correctBlue+30))) {
          score+=10;
        } else if ((blue<=(correctBlue-30)||blue>=(correctBlue+30))&&green<=(correctGreen-30)||green>=(correctGreen+30)) {
          score+=10;
        } else if ((red<=(correctRed-30)||red>=(correctRed+30))||(green<=(correctGreen-30)||green>=(correctGreen+30))||(blue<=(correctBlue-30)||blue>=(correctBlue+30))) {
          score+=30;
        }
      }

      //Patron evaluation: time
      if (level==1) {                                                  //if structures changing score depending on speed
        if (time<=20) {
          score+=50;
        } else if (time>=20&&time<=50) {
          score+=35;
        } else if (time>=51&&time<=70) {
          score+=10;
        } else if (time>=71) {
          score+=0;
        }
      } else if (level==2) {
        if (time<=15) {
          score+=50;
        } else if (time>=16&&time<=40) {
          score+=35;
        } else if (time>=41&&time<=60) {
          score+=10;
        } else if (time>=61) {
          score+=0;
        }
      }
    }
  } else if (state.equals("evaluation")) {                                 //gos back to menu if mouse is pressed
    state="mainMenu";
  } else if (state.equals("goodbye")) {
    if (mouseX>=200&&mouseX<=290&&mouseY>=380&&mouseY<=430) {              //goes to menu if BACK button is pressed
      state="mainMenu";
    } else if (mouseX>=510&&mouseX<=600&&mouseY>=380&&mouseY<=430) {       //exits program if EXIT button is pressed
      exit();                                                              s
    }
  }
}
void evaluation() {
  fill(0);
  rect(0, 0, 800, 500);

  //Stationary bubbles
  for (int gradient4 = 80; gradient4 > 1; gradient4--) { 
    fill(#77CAF5, gradient4);
    ellipse(0, 0, 180-gradient4, 185-gradient4);

    fill(#D490ED, gradient4);
    ellipse(800, 0, 280-gradient4, 275-gradient4);

    fill(#77F5D4, gradient4);
    ellipse(800, 500, 190-gradient4, 185-gradient4);
  }

  //Evaluation words
  textFont(patronWords);
  textSize(25);
  fill(255);

  if (red==correctRed&&green==correctGreen&&blue==correctBlue) {                      //if structure for perfect accuracy score
    text("Wow, you got everything correct! 50 points for the accuracy!", 100, 160);
  }
  //patron evaluation: level 1(accuracy)
  if (level==1) {                                                                     //if structures for determining the accuracy of the potion colour
    if ((red<=(correctRed-50)||red>=(correctRed+50))&&(green<=(correctGreen-50)||green>=(correctGreen+50))&&(blue<=(correctBlue-50)||blue>=(correctBlue+50))) {
      text("This completely off. You get no points for accuracy.", 100, 160);
    } else if ((red<=(correctRed-50)||red>=(correctRed+50))&&(green<=(correctGreen-50))||green>=(correctGreen+50)) {
      text("Well, since this is not very accurate to what I asked for,\nyour accuracy is only at 10 points.", 100, 160);
    } else if ((red<=(correctRed-50)||red>=(correctRed+50))&&(blue<=(correctBlue-50)||blue>=(correctBlue+50))) {
      text("Well, since this is not very accurate to what I asked for,\nyour accuracy is only at 10 points.", 100, 160);
    } else if ((blue<=(correctBlue-50)||blue>=(correctBlue+50))&&green<=(correctGreen-50)||green>=(correctGreen+50)) {
      text("Well, since this is not very accurate to what I asked for,\nyour accuracy is only at 10 points.", 100, 160);
    } else if ((red<=(correctRed-50)||red>=(correctRed+50))||(green<=(correctGreen-50)||green>=(correctGreen+50))||(blue<=(correctBlue-50)||blue>=(correctBlue+50))) {
      text("Huh, this doesn't look exactly like the potion I asked for.\nThat's 30 points for accuracy.", 100, 160);
    }
  }
  //patron evaluation: level 2(accuracy)
  else if (level==2) {
    if ((red<=(correctRed-30)||red>=(correctRed+30))&&(green<=(correctGreen-30)||green>=(correctGreen+30))&&(blue<=(correctBlue-30)||blue>=(correctBlue+30))) {
      text("This completely off. You get no points for accuracy.", 100, 160);
    } else if ((red<=(correctRed-30)||red>=(correctRed+30))&&(green<=(correctGreen-30))||green>=(correctGreen+30)) {
      text("Well, since this is not very accurate to what I asked for,\nyour accuracy is only at 10 points.", 100, 160);
    } else if ((red<=(correctRed-30)||red>=(correctRed+30))&&(blue<=(correctBlue-30)||blue>=(correctBlue+30))) {
      text("Well, since this is not very accurate to what I asked for,\nyour accuracy is only at 10 points.", 100, 160);
    } else if ((blue<=(correctBlue-30)||blue>=(correctBlue+30))&&green<=(correctGreen-30)||green>=(correctGreen+30)) {
      text("Well, since this is not very accurate to what I asked for,\nyour accuracy is only at 10 points.", 100, 160);
    } else if ((red<=(correctRed-30)||red>=(correctRed+30))||(green<=(correctGreen-30)||green>=(correctGreen+30))||(blue<=(correctBlue-30)||blue>=(correctBlue+30))) {
      text("Huh, this doesn't look exactly like the potion I asked for.\nThat's 30 points for accuracy.", 100, 160);
    }
  }

  //Patron evaluation: time
  if (level==1) {                                                                                            //if structures for determining the speed of the game
    if (time<=20&&time>0) {
      text("WOOO, that was super fast! Full 50 points for speed!", 100, 260);
    } else if (time>=20&&time<=50) {
      text("You were fairly fast, so, 35 points for speed.", 100, 260);
    } else if (time>=51&&time<=70) {
      text("Meh, kinda slow. Here's 10 points.", 100, 260);
    } else if (time>=71) {
      text("You took a really long time, sorry, no points in terms of speed.", 100, 260);
      ;
    }
  } else if (level==2) {
    if (time<=15) {
      text("WOOO, that was super fast! Full 50 points for speed!", 100, 260);
    } else if (time>=16&&time<=40) {
      text("You were fairly fast, so, 35 points for speed.", 100, 260);
    } else if (time>=41&&time<=60) {
      text("Meh, kinda slow. Here's 10 points.", 100, 260);
    } else if (time>=61) {
      text("You took a really long time, sorry, no points in terms of speed.", 100, 260);
    }
  }
  //Final score
  text("Your total score is : "+score,100,330);

  //Prompt text
  textFont(instructionWords);
  text("Press anywhere on the screen to continue", 200, 400);
}

void scores() {
  fill(0);
  rect(0, 0, 800, 500);
  //bubbles(stationary)
  for (int gradient5 = 80; gradient5 > 1; gradient5--) {    //bubble gradient from processing forums
    fill(#D7FAB8, gradient5);
    ellipse(240, 90, 80-gradient5, 75-gradient5);

    fill(#EEFAB8, gradient5);
    ellipse(120, 190, 80-gradient5, 75-gradient5);

    fill(#FAE4B8, gradient5);
    ellipse(140, 350, 120-gradient5, 115-gradient5);

    fill(#BCB8FA, gradient5);
    ellipse(620, 330, 130-gradient5, 125-gradient5);

    fill(#FAB6F3, gradient5);
    ellipse(580, 90, 100-gradient5, 95-gradient5);
  }
  //Score
  fill(255);
  textFont(menuChoices);
  textSize(48);
  text("SCORE: "+score, 200, 250);

  //Prompt text
  textFont(instructionWords);
  text("Press any key to go back to menu", 230, 400);
}
void goodbye() {
  //Background
  fill(0);
  noStroke();
  rect(0, 0, 800, 500);

  //Stationary bubbles
  for (int gradient6 = 80; gradient6 > 1; gradient6--) {    //bubble gradient from processing forums
    fill(#FA2157, gradient6);
    ellipse(0, 0, 230-gradient6, 225-gradient6);

    fill(#32FA41, gradient6);
    ellipse(800, 0, 230-gradient6, 225-gradient6);
  }

  //Credits and program information
  fill(255);
  textSize(33);
  text("Thank you for playing Potion Café!", 130, 140);
  textSize(25);
  text("Program Name: Potion Café\nFinal Completion Date: 1/18/19\nGame Type: Colour Mixing", 200, 200);

  //Buttons
  strokeWeight(3);              //BACK button
  stroke(#32FA41);
  rect(200, 380, 90, 50);
  fill(0);
  text("BACK", 220, 410);
  fill(255);

  stroke(#FA2157);              //EXIT button
  rect(510, 380, 90, 50);
  fill(0);
  text("EXIT", 530, 410);
}
