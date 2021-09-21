class Timer {
  int leftFrames;
  
  Timer (float initSeconds) {
    leftFrames = floor(initSeconds * 60);
  }
  
  void update () {
    if(leftFrames > 0) leftFrames --;
  }
  
  void displayUI(){
    textSize(56);
    textAlign(LEFT, TOP);
    String timeString = nf(floor(leftFrames/60), 2);
    fill(0, 120);
    text(timeString, 13, 3);
    fill((leftFrames > 600) ? #ffcc00 : #ff6600);
    text(timeString, 10, 0);
  }
  
  boolean isTimeUp () { return leftFrames == 0; }
}
