class Player{

  float x, y;
  int w =WALL_WIDTH , h = WALL_WIDTH;
  PImage img;
  int col, row;
  float Speed = 30 ;
  final float PLAYER_INIT_X = WALL_WIDTH;
  final float PLAYER_INIT_Y = WALL_WIDTH;

  int health = 3;
  final int PLAYER_MAX_HEALTH = 5;
  boolean way=true; //way right->true ,left ->false
  
  int moveDirection = 0;
  int moveTimer = 0;
  int moveDuration = 15;
  
  void setup(){
     img = loadImage("img/cat.png");
     x = PLAYER_INIT_X;
     y = PLAYER_INIT_Y;
  }
  
  void display(){
    
    
    if( hurt_frame%3==0 ){
      pushMatrix();
        translate(x, y);
        if ( way ) {
          scale(1, 1);
          image(img, 0, 0, w, h); 
        } 
        else {
          scale(-1, 1);
          image(img, -w, 0, w, h); 
        }
      popMatrix();
    }
    
    //image( img,x,y );
  }
  
  void move(){
    
    if( gameState==1 ){
      /*
      if(moveTimer == 0){


        if( leftPressed ){

          // Check left boundary
            moveDirection = LEFT;
            moveTimer = moveDuration;

        }else if( rightPressed ){

          groundhogDisplay = groundhogRight;

          // Check right boundary
          if(col < SOIL_COL_COUNT - 1){

            if(row >= 0 && soils[col + 1][row].health > 0){
              soils[col + 1][row].health --;
            }else{
              moveDirection = RIGHT;
              moveTimer = moveDuration;
            }

          }

        }else if( downPressed ){

          groundhogDisplay = groundhogDown;

          // Check bottom boundary
          if(row < SOIL_ROW_COUNT - 1){

            soils[col][row + 1].health --;

          }
        }
      }

    }else{
      // Draw image before moving to prevent offset
      switch(moveDirection){
        case LEFT:  groundhogDisplay = groundhogLeft;  break;
        case RIGHT:  groundhogDisplay = groundhogRight;  break;
        case DOWN:  groundhogDisplay = groundhogDown;  break;
      }
    }
      
      
      
      */
      col = (int) x/30;
      row = (int) y/30;
      wall_hit( col,row );
   //game win------------------------------------
      if( keyNum==5 && col==1 && row==0 ){
        song.pause();
        wins.play();
        gameState = GAME_WIN;
      }
      
      
      //New location
      if( upPressed && !upHit ){
        y -= Speed;
        upPressed = false;
      }
      if( downPressed && !downHit ){
        y += Speed; 
        downPressed = false;
      }
      if( leftPressed && !leftHit ){
        x -= Speed;
        way = false;
        leftPressed = false;
      }
      if( rightPressed && !rightHit ){
        x += Speed; 
        way = true;
        rightPressed = false;
      }
    }
    
  }

}
