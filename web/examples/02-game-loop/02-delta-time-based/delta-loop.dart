import 'dart:html';

class DeltaLoop {

  bool _started = false;
  double _steps = 0.0;
  Element _container;

  Stopwatch _stopwatch;
  double _gameTime = 0.0;

  DeltaLoop(this._container){
    _stopwatch = new Stopwatch();
    _updateContainer(0.0);
  }

  void start(){
    _started = true;
    _stopwatch.start();
    window.requestAnimationFrame(_step);
  }

  void pause(){
    _started = false;
    window.requestAnimationFrame(_step);
  }

  void stop(){
    _started = false;
    _steps = 0.0;
    _updateContainer(0.0);
  }

  void _step(num id){
    if(!_started){
      return;
    }

    double currentTime = _stopwatch.elapsedMilliseconds / 100;
    double delta = currentTime - _gameTime;
    _gameTime = currentTime;

    _steps+= 1 * delta;

    _updateContainer(delta);
    window.requestAnimationFrame(_step);
  }

  void _updateContainer(double delta){
    _container.innerHtml = _steps.round().toString();
  }
}