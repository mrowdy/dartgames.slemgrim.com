library swipe;

import 'dart:html';

class Swipe {
  Element element;
  int width;
  bool started = false;
  bool scrolling = false;
  Point start;
  Point delta;
  int startTime;
  
  Swipe(this.element){
    setup();
  }
  
  void setup(){
    element.onMouseDown.listen((MouseEvent event){ 
      startDrag(new Point(event.offset.x, event.offset.y));
    });
    
    element.onMouseMove.listen((MouseEvent event){
      if(scrolling){
        return;
      }
      move(new Point(event.offset.x, event.offset.y));
    });
    
    element.onMouseUp.listen((MouseEvent event){ 
      stop(new Point(event.offset.x, event.offset.y));
    });
  }
  
  void startDrag(Point start){
    this.start = start;
    this.delta = new Point(0, 0);
    startTime = getTime();
    started = true;
  }
  
  void move(Point pos){
    if(started){
      scrolling = false;
      delta = pos - start;
      
      if(delta.y.abs() > delta.x.abs()){
        scrolling = true;
        return;
      }
    }
  }
  
  void stop(Point pos){
    if(started){
      
      if(isSwipe()){
        print('swipe');
      }
      
      started = false;
      start = new Point(0, 0);
      delta = new Point(0, 0);
    }
  }
  
  bool isSwipe(){
    int currentTime = getTime();
    if(currentTime - startTime < 250 && delta.x.abs() > 20){
      return true;
    }
    return false;
  }
  
  int getTime() {
    return new DateTime.now().millisecondsSinceEpoch;
  }
  
}