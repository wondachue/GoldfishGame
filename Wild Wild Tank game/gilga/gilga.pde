PImage titleScreen;
boolean startGame;
Game newGame;
Play play;
import ddf.minim.*;

Minim minim;
AudioPlayer player, sample;
void setup()
{
    minim = new Minim(this);

    frameRate(20);
    startGame = false; 
    newGame = new Game();
    play = new Play();
    size(450, 500, P3D);
    titleScreen = loadImage("title.png");
    player = minim.loadFile("song.mp3");

}
void draw()
{
  //play
  player.play();
  //loop
 // player.loop();
  if(startGame)
  {
      newGame.startGame();
      play.startGame();
  }
  else
  {
      rectMode(CORNER);
      image(titleScreen, 0, 0, width*1.285, height*1.09);
  }
}
void mousePressed()
{
  if(startGame == false)
  {
       newGame.restart();
       play.restart();
       startGame = true;
  }
  if(play.gameOver)
  {
       startGame = false;
  }
}
void mouseDragged()
{
  if(startGame)
    play.mouseDraggedOnPlay();
}
