class Enemy{
  
   int x,y;
   float speed;
   int blockX,blockY;
   int w,h;
   int [] dx = { 0,0,1,-1 };
   int [] dy = { 1,-1,0,0 };
   int [] canMove;
   int [] note;
   int canNum , rand , noteNum;
   int count;
   
   boolean chase=false;
   
   Enemy( int x,int y , float speed ){
     //println(x,y);
     blockX = x;
     blockY = y;
     this.x = x*WALL_WIDTH;
     this.y = y*WALL_WIDTH;
     this.speed = speed;
     canNum = 0;
     canMove = new int [4];//can move && the last move
     note = new int [4];
     
   }
   
  void move(){
  //choose one way
    if( !chase ){
     
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
      
    }
      //random
      do{
        //println("aaaa");
        rand = floor( random( 0,canNum ) );
        if( canNum==1 && canMove[rand]==noteNum ){
          rand = 0;
          break;
        }
      }while( canMove[rand]==noteNum );
     
      switch( canMove[rand] ){
         
        case 0:
          
            y += speed;
            blockY ++;
            noteNum = note[rand];
          
        break;
        
        case 1:
          
            y -= speed;
            blockY --;
            noteNum = note[rand];
          
        break;
        
        case 2:
          
            x += speed;
            blockX ++;
            noteNum = note[rand];
          
        break;
        
        case 3:
          
            x -= speed;
            blockX --;
            noteNum = note[rand];
        
        break;
      }
    }
    
    
  }
  
  void display(){
  }
  
   void checkCollision(  Player player   ){
     
   }
   
   void skill( Key mykey , Player player ){
    
  }
   
  
   
   
  
}
