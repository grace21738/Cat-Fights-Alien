import processing.video.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//GAMESTATE
final int GAME_START = 0;
final int GAME_RULE = 4;
final int GAME_RUN_1 = 1;
final int GAME_OVER = 2;
final int GAME_WIN = 3;
int gameState = GAME_START;
final int playerW = 25;
final int playerH = 25;
final int BLOCK = 30;


final int BUTTON_TOP = 605;
final int BUTTON_BOTTOM = 676;
final int BUTTON_LEFT = 655;
final int BUTTON_RIGHT = 855;

final int BUTTON2_TOP = 550;
final int BUTTON2_BOTTOM = 590;
final int BUTTON2_LEFT = 700;
final int BUTTON2_RIGHT = 800;

final int BUTTON3_TOP = 510;
final int BUTTON3_BOTTOM = 581;
final int BUTTON3_LEFT = 350;
final int BUTTON3_RIGHT = 570;

final int BUTTON4_TOP = 605;
final int BUTTON4_BOTTOM = 675;
final int BUTTON4_LEFT = 500;
final int BUTTON4_RIGHT = 800;



//Distance
int [] dx = { 0,0,1,-1 };
int [] dy = { 1,-1,0,0 };

//Key
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

Timer timer;

//hit
boolean rightHit = false;
boolean leftHit = false;
boolean upHit = false;
boolean downHit = false;

float wall_bug=-12;


//Image
PImage key_1,key_2,key_3,key_4,key_5;
PImage alien_1,alien_2,cat;
PImage heart;
PImage map_s,map_w;
PImage game_s ,game_rule ,game_win ,game_lose;
PImage gameStartButton_1 , gameStartButton_2;
PImage restartButton_1 , restartButton_2;
PImage start1,start2;
PImage back1,back2;
PImage img_2020;


//sound
Minim minim;
AudioPlayer song;
AudioPlayer wins;
AudioPlayer loses;
AudioPlayer hurt;
AudioPlayer get_key;
AudioPlayer time_hurry;
AudioPlayer ali_key;
AudioPlayer clock;
AudioPlayer get_item;
AudioPlayer door;
AudioPlayer get_back;

Movie movie;



//rect 
final int WALL_WIDTH = 30;

int recXNum = 30;
int recYNum = 20;
//wall -> 0 , key -> 2 , cat -> 3 , alien_1 -> 4, alien_2 -> 5
int[][] index = {
    { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 }, //1
    { 1,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 },
    { 1,0,1,1,0,0,0,0,1,0,1,1,1,1,1,1,0,1,1,0,1,0,1,1,1,0,1,1,0,1 },
    { 1,0,1,1,1,1,1,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,1,0,1 },
    { 1,0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,0,1,1,1,0,1,0,1,1,1,1,1,0,1 }, //5
    { 1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,0,1,0,0,0,0,0,1 },
    { 1,0,0,0,0,1,0,1,0,1,1,0,1,1,1,1,0,1,0,1,1,1,0,1,0,1,1,1,0,1 },
    { 1,1,1,1,1,1,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,0,0,0,1,1,1,0,1 },
    { 1,0,0,0,0,0,0,1,0,1,1,0,1,1,1,0,1,1,0,0,0,0,0,1,0,1,1,0,0,1 },
    { 1,0,1,1,1,1,0,1,0,0,0,0,1,1,1,0,1,1,1,0,1,1,0,0,0,0,1,0,1,1 },//10
    { 1,0,0,0,0,1,0,1,0,1,1,0,1,1,1,0,0,0,0,0,0,1,1,1,1,0,0,0,0,1 },
    { 1,0,1,1,0,1,0,1,0,0,0,0,0,1,0,0,1,1,1,1,0,1,0,0,0,0,1,1,0,1 },
    { 1,0,1,1,0,1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,0,0,0,1,0,1,1,1,0,1 },
    { 1,0,0,0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,1,1,1,0,1 },
    { 1,0,1,1,1,1,1,1,1,1,0,1,0,1,1,1,0,1,1,0,0,0,0,1,0,0,0,0,0,1 },//15
    { 1,0,1,0,0,0,0,0,0,0,0,1,0,1,1,1,0,1,1,0,1,1,0,1,1,1,0,1,0,1 },
    { 1,0,0,0,1,1,1,1,1,0,1,1,0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,0,0,1 },
    { 1,0,1,0,1,1,1,0,0,0,1,1,0,1,0,1,1,1,1,1,0,1,0,1,1,1,0,1,0,1 },
    { 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 },
    { 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 }//20
  };
  
//cat
Player player;

//key
Key[] mykey;
int keyNum = 0;
int[] itemKey;

//heart
int heartNum = 3;

//Enemy
Enemy[] enemies;
int newX,newY,speed;

//time
int time = 0;
int count =0;
int time_stop;
Time_Stop [] stop;

//relive
int hurt_frame; 
int key_time;

// line hit
boolean isHit( float ax, float ay, float aw, float ah, float bx, float by, float bw, float bh ){
   
  return  ax + aw > bx &&    // a right edge past b left
        ax < bx + bw &&    // a left edge past b right
        ay + ah > by &&    // a top edge past b bottom
        ay < by + bh;
 
}

void initGame(){
 
   //movie = new Movie(this,"op.mp4" );
  // movie.play();

   minim = new Minim(this);
   song = minim.loadFile("music/background.mp3");
   wins = minim.loadFile("music/wins.wav");
   loses = minim.loadFile("music/lose.wav");
   hurt = minim.loadFile("music/hurt.wav");
   get_key = minim.loadFile("music/get_key.wav");
   get_item = minim.loadFile("music/item.wav");
   time_hurry = minim.loadFile("music/hurry.wav");
   ali_key = minim.loadFile("music/mon_get_key.wav");
   get_back = minim.loadFile("music/get_back.wav");
   door = minim.loadFile("music/door.wav");
   
   song.play();
   song.loop();
  
  //wall
   index[0][1] = 1;
  
  player = new Player();
  player.setup();
  mykey = new Key[5];
  itemKey = new int[5];
  for( int i = 0 ; i < mykey.length ; i++  ) {
    mykey[i] = new Key(i);
    itemKey[i] = 0;
  }
  
  //heart
  heartNum = 3;
  
  //key
  keyNum = 0;
  
  //hurt
  hurt_frame = 0;
  
  //key_time
  key_time=0;
  
  //enemy
  enemies = new Enemy[6];
  
  for( int i=0 ; i<enemies.length ; i++ ){
    do{
      newX = floor(random(0,recXNum));
      newY = floor(random(0,recYNum));
      //println( blockX,blockY );
    }while( index[ newY ][ newX ]!=0 );
    //println(newY,newX);
    speed = 30;
    switch(i){
      case 0: case 1: case 2:  enemies[i] = new Attack( newX, newY,speed ); break;
      case 3:case 4:  enemies[i] = new Stealer(newX, newY,speed); break;
    }
  }
  //item
  stop = new Time_Stop[2];
  for( int j=0 ; j<2 ; j++ ){
    stop[j] = new Time_Stop();
  }
  
}


//WALLHit------------------------------------------
//chi hon
void wall_hit( int col, int row ){

  int a,b;
  for( int i=0 ; i<4 ; i++ ){
    a = col + dx[i];
    b = row + dy[i];
    if( b>=0 && a>=0 ){
      if( index[b][a]==1 ){
        
        if( dx[i]==-1 ) leftPressed = false;
        else if( dx[i]==1 ) rightPressed = false;
        else if( dy[i]==-1 ) upPressed = false;
        else if( dy[i]==1 ) downPressed = false;
      
      }
    }
  }
}

//lose heart


  

void setup(){
  size( 900,750 );
  //smooth();
  initGame();
  
  heart = loadImage( "img/cat.png" ); 
  alien_2 = loadImage("img/alien_2.png");
  map_s = loadImage("img/map_R.png");
  map_w = loadImage("img/map_W.png");
  game_s = loadImage("img/startBG.png");
  game_rule = loadImage("img/rule.png");
  game_win = loadImage("img/success.png"); //player fix
  game_lose = loadImage("img/fail.png");
  gameStartButton_1 = loadImage("img/gameStart1.png");
  gameStartButton_2 = loadImage("img/gameStart2.png");
  restartButton_1 = loadImage("img/restart1.png");
  restartButton_2= loadImage("img/restart2.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  back1 = loadImage("img/back1.png");
  back2 = loadImage("img/back2.png");
  img_2020 = loadImage("img/2020_.png");
  //alien_1 = loadImage("img/alien_1.png");
  
   //timer = new Timer(15);
   
}



void draw(){
 
  background(0);
  
  
  switch( gameState ){
    //Rule_1
    case GAME_START:
    
    //image(movie, 0, 0);
    
    image( game_s,0,0 );
    count --;
    if( mouseX > BUTTON_LEFT && mouseX < BUTTON_RIGHT
        && mouseY > BUTTON_TOP && mouseY < BUTTON_BOTTOM ){
          image( gameStartButton_2,655,605  );
          if( mousePressed && count<0){
            count = 20;
            gameState = GAME_RULE;
          }
        }
        else{
          
          image( gameStartButton_1,655,605 );
        }
   

    break;
    
    case GAME_RULE:
    
    count --;
    //println(count);
    image( game_rule,0,0 );
    if( mouseX > BUTTON2_LEFT && mouseX < BUTTON2_RIGHT
        && mouseY > BUTTON2_TOP && mouseY < BUTTON2_BOTTOM ){
          image( start2,700,550  );
          if( mousePressed && count<0){
            gameState = GAME_RUN_1;
          }
        }
        else{
          
          image( start1,700,550 );
        }
    
    break;
    
    case GAME_RUN_1:
    ellipseMode( CORNER );
    rectMode( CORNER );
    fill( 200,200,200 );
    //dots();
    //Wall & map
    for( int i=0 ; i<index.length ; i++ ){
      
      for( int j=0 ; j< index[i].length ; j++ ){
        if( index[i][j]==1 ){
          noStroke();
          fill( 200,200,200 );
          rect( j*WALL_WIDTH , i*WALL_WIDTH ,WALL_WIDTH ,WALL_WIDTH );
        }
          
      }
    }
    //WIN
    if( keyNum!=5 ){
      image( map_s,0,0 );
    }
    else{
      
      door.play();
      image( map_w,0,0 );
      index[0][1] = 10;
    }
    fill( 107, 179, 156 );
    rect( 230,625,225,72 );
    image( img_2020,245,620,200,80 );
   
   //Cat
   player.display();
   player.move();
   
   //key
   for( int i=0 ; i<mykey.length ; i++ ){
     mykey[i].display();
     mykey[i].checkCollision( player );
   }
   
   //heart position
   for( int i=0 ; i<heartNum ; i++ ){
     image( heart , 80+i*30 ,645 );
   }
   
   
   //enemy
   time ++;
   for( int i=0 ; i<5 ;i++ ){
     
     if( time%10==0 && time_stop==0 ){
       //println(i,time,time_stop);
       enemies[i].move();
       time_stop=0;
       time =0;
     }
     enemies[i].display();
     
     for( int j=0 ; j<5 ; j++ ){
        enemies[i].skill( mykey[j],player );
     }
     
     if( hurt_frame==0 ){
       enemies[i].checkCollision( player );
     }
     else{
       hurt_frame -= 1;
     }
     
     if( key_time!=0 ){
       key_time --;
     }
     
     if( time_stop!=0 ){
       time_stop --;
     }
     //println( keyNum );
   }
   
   //item
   for( int i=0 ; i<2 ; i++ ){
     stop[i].checkCollision( player );
     stop[i].display(  );
   }
   
//Game over----------------------------------
   if( heartNum==0 ){
     gameState = GAME_OVER;
      song.pause();
     //loses.trigger();
      loses.play();
   }
    
    
    break;
    
    case GAME_OVER:
    
     image( game_lose,0,0 );
     
     if( mouseX > BUTTON3_LEFT && mouseX < BUTTON3_RIGHT
        && mouseY > BUTTON3_TOP && mouseY < BUTTON3_BOTTOM ){
          
          image( restartButton_2,350,510  );
          if( mousePressed ){
            gameState = GAME_RUN_1;
            initGame();
          }
        }
        else{
          
          image( restartButton_1,350,510 );
        }
    
    break;
    
    case GAME_WIN:
    
     image( game_win,0,0 );
     
     if( mouseX > BUTTON4_LEFT && mouseX < BUTTON4_RIGHT
        && mouseY > BUTTON4_TOP && mouseY < BUTTON4_BOTTOM ){
          
          image( back2,500,605  );
          count = 10;
          if( mousePressed ){
            initGame();
            gameState = GAME_START;
          }
        }
        else{
          
          image( back1,500,605 );
        }
    
    break;
     
      
  }



}


void keyPressed(){

     switch( keyCode ){
       case UP:
         upPressed = true;
         break;
       case DOWN:
         downPressed = true;
         break;
       case LEFT:
         leftPressed = true;
         break;
       case RIGHT:
         rightPressed = true;
         break; 
     }
     
}



void keyReleased(){
  if( key == CODED ){
    switch ( keyCode ){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}

void movieEvent(Movie m) {
  m.read();
}
