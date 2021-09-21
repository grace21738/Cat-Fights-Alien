class Time_Stop{
  
  PImage img;
  int w = WALL_WIDTH , h = WALL_WIDTH;
  int blockX ,blockY;
  int x ,y;
  boolean isAlive = true;
  
   Time_Stop(){
    img = loadImage( "img/Hourglass.png" );
    do{
      blockX = floor(random(0,recXNum));
      blockY = floor(random(0,recYNum));
      //println( blockX,blockY );
    }while( index[ blockY ][ blockX ]!=0 && index[ blockY ][ blockX ]!=2 );
    
    x = blockX * WALL_WIDTH;
    y = blockY * WALL_WIDTH;
   // Num = num;
    
  }
  
  
   void checkCollision( Player player ){
  
   if( isHit( player.x , player.y , player.w , player.h , x , y , w, h ) ){
      isAlive = false;
      get_item.rewind();
      get_item.play();
      time_stop = 1500;
      x = -1000;
      y = -1000;
   }
  }
  
  void display(){
    if( isAlive ){
       image( img,x,y );
    }
    else if( time_stop >0 ){
      
      time_hurry.rewind();
      time_hurry.play();
      if( time_stop<500 ){
      
        if( time_stop%20==0 ){ 
          image( img,530,650 );
        }
      
      }
      else{
        //song.play();
        image( img,530,650 );
      }
      
    }
  }
  

}
