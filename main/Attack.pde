class Attack extends Enemy {
  
  PImage img;
  int w = WALL_WIDTH , h = WALL_WIDTH;
  float speed;
  float dist=0;

  
  
  Attack( int blockX, int blockY , int speed ){
    
    super( blockX,blockY,speed ); 
    img = loadImage("img/alien_1.png");
  }
  
  void checkCollision( Player player ){
  
   if( isHit( player.x , player.y , player.w , player.h , x , y , w, h ) ){
      //x = -1000;
      //y = -1000;
      //chase = true;
      hurt_frame = 200;
      hurt.rewind();
      hurt.play();
      heartNum --;
   }
  }
  
  void display(){
   
    image( img,x,y );
  }
  
  void chasing( Player player ){
    
    if( sqrt(sq( blockX-player.col )+sq( blockY-player.row ))<10 ){
      chase=true;
    }
    
    if( chase ){
      
      canNum = 0;
      for( int i=0 ; i<4 ; i++ ){
        
        int a = blockX + dx[i];
        int b = blockY + dy[i];
        
        if( index[ b ][ a ]==0 || index[ b ][ a ]==2  ){
          //0->down , 1-> up , 2->right , 3->left
           if( dx[i]==-1 ) {
             canMove[canNum] = 3;
             note[canNum] = 2;
             canNum ++;
             
           }
          else if( dx[i]==1 ){
           
             canMove[canNum] = 2;
             note[canNum] = 3;
             canNum ++;
            
          }
          else if( dy[i]==-1 ){
           
               canMove[canNum] = 1;
               note[canNum] = 0;
               canNum ++;
          }
          else if( dy[i]==1 ) {
            
               canMove[canNum] = 0;
               note[canNum] = 1;
               canNum ++;
             
          }
        
        }
      
      }//can move 
      
      if( canMove[rand]==0 ){
        
      }
      
      
    
    }//chase
    
  }
  
 
}
