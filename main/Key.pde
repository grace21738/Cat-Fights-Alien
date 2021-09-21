class Key {
  
  PImage img;
  int w = WALL_WIDTH ,h = WALL_WIDTH;
  int blockX,blockY,Num;
  float tmpX,tmpY;
  float x,y;
  boolean isAlive = true;
  boolean isSteal = false;
  
  Key( int num ){
    img = loadImage( "img/key_"+str(num)+".png" );
    do{
      blockX = floor(random(0,recXNum));
      blockY = floor(random(0,recYNum));
      //println( blockX,blockY );
    }while( index[ blockY ][ blockX ]!=0 );
    index[ blockY ][ blockX ] = 2;
    x = blockX * WALL_WIDTH;
    y = blockY * WALL_WIDTH;
     tmpX = x;
     tmpY = y;
    Num = num;
    
  }
  
  void checkCollision( Player player ){
  
    if( isHit( player.x , player.y , player.w , player.h , x , y , w, h ) && !isSteal ){
      isAlive = false;
      x = -1000;
      y = -1000;
      blockX =0;
      blockY =0;
      itemKey[Num] = keyNum;
      get_key.rewind();
      get_key.play();
      keyNum ++;
    }
    
  }
  /*
  void stealing( Stealer stealer ){
    
    if( stealer.hold_key ){
      blockX = stealer.blockX;
      blockY = stealer.blockY;
      x = blockX * WALL_WIDTH;
      y = blockY * WALL_WIDTH;
      isSteal = true;
    }
    
  }*/
  
  void display(){
   
    if( isAlive ){
      if( !isSteal ){
        x = tmpX;
        y =  tmpY;
        image( img,x,y,30,30 );
        
      }
      else{
        x= -1000;
        y = -1000;
        //println("aaaa");
      }
      
    }
    tint( 150 );
    image( img,650+40*Num,645,30,30 );
    tint( 255 );
    
    if( !isAlive && !isSteal ){
      //println("aaa");
      tint( 255 );
      image( img,650+40*Num,645,30,30 );
    }
    
  }
   
}
