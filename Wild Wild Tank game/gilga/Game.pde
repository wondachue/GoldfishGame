class Game
{
  PImage bg;
  Play play;
  void Game()
  {
  }
  void restart()
  {
    play = new Play();
    play.restart();
    bg = loadImage("bgDesert.png");
    hint(DISABLE_DEPTH_TEST);
  }
  void startGame()
  {
    background(0);
    drawRoad();
    drawFish();
  }
  void drawFish()
  {
    noStroke();
    fill(0, 50, 255, 50);
    directionalLight(126, 126, 126, 0, 0, -1);
    directionalLight(width/2, height/2, 126, 0, 0, -1);
    ambientLight(200, 200, 102, 50, 50, 0);
    play.drawFish();
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
}
