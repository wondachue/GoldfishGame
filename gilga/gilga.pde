float ballWidth;
int lives;

int startCacti;
float cactiX;
float cactiY;
float cactiWidth;
float cactiDirection;

int startGhost;
float ghostWidth;
float ghostX;
float ghostY;
float ghostDirection;
boolean ghostHit;

int startmonster;
float monsterWidth;
float monsterX;
float monsterY;
float monsterDirection;
boolean monsterHit;

PImage img, img2;
PImage coral, coral2;
PImage monster, monster2;
PImage cacti;
PImage bg, score;
PImage water, water2;

int level;
int scoreNum;
/*
static public void main(String args[]) 
{
      PApplet.main("gilga");
}
*/
void setup()
{
    img = loadImage("gilga.png");
    img2 = loadImage("gilga2.png");
    score = loadImage("score.png");
    coral = loadImage("cacti1.png");
    coral2 = loadImage("cacti2.png");
    monster = loadImage("monster1.png");
    monster2 = loadImage("monster2.png");
    cacti = loadImage("castle.jpg");
    bg = loadImage("bgDesert.png");
    water = loadImage("water.png");
    water2 = loadImage("water2.png");
    size(450, 500, P3D);
    background(0);
    ballWidth = 50;
    startCacti = 0;
    startGhost = 0;
    startmonster = 0;
    lives = 5;
    scoreNum = 0;
    level = 1;

}

void draw()
{
  
    background(0);
  
    updateText();
    cacti();
    ghost();
    
    if(ballWidth > 10 && lives > 0)
    {
      drawFish();
    }
    else
    {
      lives = 0;
      gameOver();
    }
    if(scoreNum % 10 == 0)
    {
      level++;
      textSize(50);
      fill(250, 0, 0);
      //text("Level " + level, width/2 - 140, height/2);
    }
    if(level == 1)
    {
      if(ghostY >= height - 20)
      {
        checkGhost();
      }
    }
    if(level == 2)
    {
      if(monsterY >= height - 20)
      {
        checkMonster();
      }
    }   
  
    drawRoad();
    
}
void squirtWater()
{
    float distance = mouseX - width/2;
    float distance2 = width/2 - mouseX;
    float distanceY = mouseY - height/2;
    float distanceY2 = height/2 - mouseY;
    rectMode(CORNER);
    if(pmouseX < width/2)
    {
      //4th quad
      if(pmouseY < height/2)
      {
        image(water, mouseX - 50, mouseY - 50, distance2 + 50, distanceY2 + 200);
      }
      //2nd quad
      else
      {
        //image(water, mouseX, mouseY, distance2, distanceY);
      }
    }
    else
    {
      //3rd quad
      if(pmouseY < height/2)
      {
        image(water2, 50 + mouseX , mouseY - 50, -distance - 50, distanceY2 + 200);
      }
      //1st quad
      else
      {
        //image(water2, mouseX + 500, mouseY - 50, distance, distanceY);
      }
    }
}
void mouseDragged()
{

    rectMode(CORNER);
    if(pmouseY < 250)
      squirtWater();
    if(ballWidth > 10)
    {
      stroke(50, 50, 255);
      strokeWeight(4);
      //curve(width/2, height - 120 + mouseY/2, 0, width/2, height - 120, 0, mouseX, mouseY, 0, mouseX, mouseY + mouseY/2, 0);
      ballWidth -= .5;
    }
    if(mouseX <= cactiX + cactiWidth && mouseX >= cactiX - cactiWidth && mouseY >= cactiY - cactiWidth && mouseY <= cactiY + cactiWidth)
    {
      ballWidth += 1;
    }
    if(mouseX <= ghostX + ghostWidth && mouseX >= ghostX - ghostWidth && mouseY >= ghostY - ghostWidth && mouseY <= ghostY + ghostWidth)
    {
      startGhost = 0;
      scoreNum++;
    }

  
}
void mouseReleased()
{
    
}
void monster()
{
    //fill(20, 255, 20);
    if(frameCount % 200 == 0)
    {
      startmonster = 1;
      monsterWidth = 10;
    }
    if(startmonster >= 1)
    {
        if(startmonster == 1)
        {
            createmonster();
        }
        if(startmonster < 150 && startmonster != 0)
        {
            updateThemonster();
        }
        else
        {
            startmonster = 0;
        }
    }
}
void createmonster()
{
      monsterX = random(width - 50) + 50;
      monsterY = 0;
      if(monsterX < (width- 50)/2)
      {
        monsterDirection = 0;
      }
      else
      {
        monsterDirection = 1;
      }
}
void updateThemonster()
{
      monsterY += 5;
      startmonster++;
      monsterWidth++;
      if(monsterDirection == 1)
      {
        monsterDirection(-PI/12, 1);
      }
      else
      {
        monsterDirection(PI/12, 2);       
      }
}
void monsterDirection(float piDirection, int dir)
{
    monsterX--;
    pushMatrix();
    rotateY(piDirection);
    rotateX(-PI/12);
    rectMode(CENTER);
    if(dir == 2)
        image(monster, monsterX, monsterY, monsterWidth, monsterWidth);
    else
        image(monster2, monsterX, monsterY, monsterWidth, monsterWidth);
    //rect(monsterX, monsterY, monsterWidth, monsterWidth + 20);
    popMatrix();
}
void ghost()
{
    //fill(20, 255, 20);
    if(frameCount % 200 == 0)
    {
      startGhost = 1;
      ghostWidth = 10;
    }
    if(startGhost >= 1)
    {
        if(startGhost == 1)
        {
            createGhost();
        }
        if(startGhost < 150 && startGhost != 0)
        {
            updateTheGhost();
        }
        else
        {
            startGhost = 0;
        }
    }
}
void createGhost()
{
      ghostX = random(width - 50) + 50;
      ghostY = 0;
      if(ghostX < (width- 50)/2)
      {
        ghostDirection = 0;
      }
      else
      {
        ghostDirection = 1;
      }
}
void updateTheGhost()
{
      ghostY += 5;
      startGhost++;
      ghostWidth++;
      if(ghostDirection == 1)
      {
        ghostDirection(-PI/12, 1);
      }
      else
      {
        ghostDirection(PI/12, 2);       
      }
}
void ghostDirection(float piDirection, int dir)
{
    ghostX--;
    pushMatrix();
    rotateY(piDirection);
    rotateX(-PI/12);
    rectMode(CENTER);
    if(dir == 2)
        image(coral, ghostX, ghostY, ghostWidth, ghostWidth);
    else
        image(coral2, ghostX, ghostY, ghostWidth, ghostWidth);
    //rect(ghostX, ghostY, ghostWidth, ghostWidth + 20);
    popMatrix();
}
void cacti()
{
    //fill(255);
    if(frameCount % 1000 == 0)
    {
      startCacti = 1;
      cactiWidth = 10;
    }
    if(startCacti >= 1)
    {
      createCacti();
    }
    
}
void createCacti()
{
      if(startCacti == 1)
      {
          cactiX = random(width - 50) + 25;
          cactiY = 0;
          if(cactiX < (width- 50)/2)
          {
            cactiDirection = 0;
          }
          else
          {
            cactiDirection = 1;
          }
      }
      if(startCacti < 150 && startCacti != 0)
      {
          cactiY += 5;
          startCacti++;
          cactiWidth++;
          if(cactiDirection == 1)
          {
             cactiDirection(-PI/12);
          }
          else
          {
            cactiDirection(PI/12);
          }
      }
      else
      {
          startCacti = 0;
      }
}
  void cactiDirection(float piAmount)
  {
        cactiX++;
        pushMatrix();
        rotateY(piAmount);
        rotateX(-PI/12);
        rectMode(CENTER);
        image(cacti, cactiX, cactiY, cactiWidth, cactiWidth);
      
        //rect(cactiX, cactiY, cactiWidth, cactiWidth);
        popMatrix();
  }
  void drawFish()
  {
       noStroke();
        fill(50, 50, 255, 50);
        noStroke();
        directionalLight(126, 126, 126, 0, 0, -1);
        directionalLight(width/2, height/2, 126, 0, 0, -1);
        ambientLight(200, 200, 102, 50, 50, 0);
        pushMatrix();
        if(pmouseX < width/2)
          image(img, width/2 - 25, height/2 + 120, 50, 50);
        else
          image(img2, width/2 - 25, height/2 + 120, 50, 50);
        translate(width/2, height - 120, 0);
        sphere(ballWidth);
        popMatrix();
  }
  void updateText()
  {
      image(score, 5, 20, 150, 100);
      textSize(20);
      fill(250, 70, 150);
      if(lives > 0)
      {
        text("Lives: " + lives, 50, 85);
      }
      text("Score: " + scoreNum, 50, 100);
  }
  void gameOver()
  {
      textSize(50);
      fill(250, 0, 0);
      text("GAME OVER", width/2 - 140, height/2);
  }
  void checkGhost()
  {
      startGhost = 0;
      ghostY = 0;
      lives--;
  }
  void checkMonster()
  {
      startmonster = 0;
      ghostY = 0;
      lives--;
  }
  void drawRoad()
  {
      fill(250, 250, 20);
      pushMatrix();
      translate(-800, -300, -250);
      rectMode(CENTER);
      image(bg, 0, 0, 1400, 1000);
      
      popMatrix();
  }

