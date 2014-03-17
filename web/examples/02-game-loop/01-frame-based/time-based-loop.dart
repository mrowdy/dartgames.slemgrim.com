import 'dart:html';
import 'dart:async';

class TimeBasedLoop {

  bool _started = false;
  int _steps = 0;
  Element _container;
  Duration interval = new Duration(milliseconds: 16);

  TimeBasedLoop(this._container){
    _updateContainer();
  }

  void start(){
    _started = true;
    new Future.delayed(interval, _step);
  }

  void pause(){
    _started = false;
    new Future.delayed(interval, _step);
  }

  void stop(){
    _started = false;
    _steps = 0;
    _updateContainer();
  }

  void _step(){
    if(!_started){
      return;
    }
    _steps++;
    _updateContainer();
    new Future.delayed(interval, _step);
  }

  void _updateContainer(){
    _container.innerHtml = _steps.toString();
  }
}