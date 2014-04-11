class Play
{
  PImage water, water2;
  PImage score = loadImage("score.png");
  public float ballWidth;
  public int lives;
  public boolean gameOver;
  public int scoreNum;
  PImage img = loadImage("gilga.png");
  PImage img2 = loadImage("gilga2.png");
  PImage cacti = loadImage("cacti1.png");
  PImage cacti2 = loadImage("cacti2.png");
  PImage monster = loadImage("monster1.png");
  PImage monster2 = loadImage("monster2.png");
  PImage castle = loadImage("castle.png");
  
  Boolean isOn;
  
  float monsterWidth;
  float monsterX;
  float monsterY;
  float monsterDirection;
  boolean monsterHit;  
  
  int startmonster;
  int level;
  String type;
  int tracker;
  int frame;
  void restart()
  {
    frame = 0;
    tracker = 1;
    gameOver = false;
    ballWidth = 50;
    lives = 5;
    scoreNum = 1;
    water = loadImage("water.png");
    water2 = loadImage("water2.png");
    isOn = false;
    level = 1;
    restartMonster();
  }
  void startGame()
  {

      checkLevel();
      updateText();
      if(isOn)
        monster(); 
      else
        restartMonster();
      if(gameOver)
         gameOver();
  }
  void restartMonster()
  {
    isOn = true;    
    startmonster = 0;
  }
  void monster()
  {
    if(monsterY >= height - 20 && type != "castle")
    {
       checkmonster();
    }
    //fill(20, 255, 20);
    if(frameCount % 100 == 0)
    {
      startmonster = 1;
      monsterWidth = 20;
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
      if(tracker == 2)
        tracker = 1;
      else
        tracker++;
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
      monsterY += 5 + level*1.5;
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
  void checkmonster()
  {
      isOn = false;
      startmonster = 0;
      monsterX = 0;
      if(type == "snake" || type == "cacti")
        lives--;
      createmonster();
      
  }
  void monsterDirection(float piDirection, int dir)
  {
    monsterX--;
    pushMatrix();
    rotateY(piDirection);
    rotateX(-PI/12);
    rectMode(CENTER);
    if(dir == 2)
    {
        if(type == "cacti")
          image(cacti, monsterX, monsterY, monsterWidth, monsterWidth +10);
        else if(type == "snake")
          image(monster, monsterX, monsterY, monsterWidth, monsterWidth + 10);
        else
          image(castle, monsterX, monsterY, monsterWidth, monsterWidth + 10);

    }
    else
    {
        if(type == "cacti")
          image(cacti2, monsterX, monsterY, monsterWidth, monsterWidth + 10);
        else if(type == "snake")
          image(monster2, monsterX, monsterY, monsterWidth, monsterWidth + 10);
        else 
          image(castle, monsterX, monsterY, monsterWidth, monsterWidth + 10);

    }
    //rect(monsterX, monsterY, monsterWidth, monsterWidth + 20);
    popMatrix();
  }
  
  
  
  void checkLevel()
  {
    if(ballWidth < 12 || lives <= 0 || ballWidth > 80)
    {
      gameOver = true;
    }
    level = (int)Math.floor(scoreNum / 10);
    if(scoreNum % 10 == 0)
    {
      level++;
    }
    if(level <= 3)
      type = "cacti";
    if(level > 3)
       type = "snake";
    if(tracker == 2)
        type = "castle";
        
  }
  void updateText()
  {
      image(score, 5, 20, 150, 100);
      textSize(20);
      fill(250, 70, 150);
      if(play.lives > 0)
      {
        text("Lives: " + lives, 50, 85);
      }
      text("Score: " + scoreNum, 50, 100);
  }
  void gameOver()
  {
      textSize(50);
      fill(250, 0, 0);
      if(ballWidth < 80)
        text("GAME OVER", width/2 - 140, height/2);
      else
      {
         fill(200, 200, 0);
         text("YOU WIN!!!", width/2 - 120, height/2);
      }
        
  }
  void drawFish()
  {
    pushMatrix();
    if(pmouseX < width/2)
      image(img, width/2 - 25, height/2 + 120, 50, 50);
    else
      image(img2, width/2 - 25, height/2 + 120, 50, 50);
    translate(width/2, height - 120, 0);
    sphere(play.ballWidth);
    popMatrix();
  }
  void squirtWater()
  {
    float distance = mouseX - width/2;
    float distance2 = width/2 - mouseX;
    float distanceY = mouseY - height/2;
    float distanceY2 = height/2 - mouseY;
    rectMode(CORNER);
    if(pmouseX <= width/2)
    {
      image(water, mouseX - 50, mouseY - 50, distance2 + 50, distanceY2 + 200);
    }
    else if(pmouseY < height/2)
    {
       image(water2, 50 + mouseX , mouseY - 50, -distance - 50, distanceY2 + 200);
    }
    if(mouseX <= monsterX + monsterWidth + 10 && mouseX >= monsterX - monsterWidth -10 && mouseY >= monsterY - monsterWidth - 10 && mouseY <= monsterY + monsterWidth + 10)
    {
      if(type == "cacti" || type == "snake")
      {
        isOn = false;
        startmonster = 0;
      }
      else
      {
        ballWidth += 1;
        scoreNum++;
      }
    }
    
  }
  void mouseDraggedOnPlay()
  {
    if(pmouseY < 250)
      squirtWater();
    if(ballWidth > 10)
      ballWidth -= .5;
  }
  void mouseReleased()
  {
    
  }
}
