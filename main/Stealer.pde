class Stealer extends Enemy {
  
  PImage img,img1;
  int w = WALL_WIDTH , h = WALL_WIDTH;
  float speed;
  int stealNum=-1;
  boolean hold_key = false;
  
  Stealer( int blockX, int blockY , int speed ){
    
    super( blockX,blockY,speed ); 
    img = loadImage("img/alien_2.png");
    img1 = loadImage("img/alien_2a_c.png");
 
  }
  
 
  void display(){
    //println("bbb");
    //println( y,x );
    //println("aaa"+x,y);
    if( hold_key ){
      image( img,x,y );
    }
    else{
      image( img1,x,y );
    }
  }
  
  void skill(  Key mykey , Player player ){
    
    if( ! hold_key && ! mykey.isSteal ){
      if( blockX == mykey.blockX && blockY == mykey.blockY ){
        
        ali_key.rewind();
        ali_key.play();
        hold_key = true;
        stealNum = mykey.Num;
        mykey.isSteal = true;
      }
    }
    
    if( isHit( player.x , player.y , player.w , player.h , x , y , w, h ) ){
      //x = -1000;
      //y = -1000;
      if( !hold_key && hurt_frame==0 && key_time==0 ){
        hurt.rewind();
        hurt.play();
        hurt_frame = 150;
        heartNum --;
      }
      else{
        if( stealNum == mykey.Num ){
          hold_key=false; 
          mykey.isSteal = false;
          get_back.rewind();
          get_back.play();
          stealNum=-1;
          key_time = 150;
        }
        
      }
   }
   
    
  }

}
