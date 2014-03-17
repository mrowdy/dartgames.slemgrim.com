import 'dart:html';

class FrameBasedLoop {

  bool _started = false;
  int _steps = 0;
  Element _container;

  FrameBasedLoop(this._container){
    _updateContainer();
  }

  void start(){
    _started = true;
    window.requestAnimationFrame(_step);
  }

  void pause(){
    _started = false;
    window.requestAnimationFrame(_step);
  }

  void stop(){
    _started = false;
    _steps = 0;
    _updateContainer();
  }

  void _step(num id){
    if(!_started){
      return;
    }
    _steps++;
    _updateContainer();
    window.requestAnimationFrame(_step);
  }

  void _updateContainer(){
    _container.innerHtml = _steps.toString();
  }
}