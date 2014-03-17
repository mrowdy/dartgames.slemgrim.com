import 'dart:html';
import 'frame-based-loop.dart';
import 'time-based-loop.dart';

main(){
  frameBasedLoop();
  timeBasedLoop();
}

void frameBasedLoop(){
  Element frameBased = querySelector('#frame-based');
  Element gameElement = frameBased.querySelector('.game');
  ButtonElement startButton = frameBased.querySelector('.start');
  ButtonElement pauseButton = frameBased.querySelector('.pause');
  ButtonElement stopButton = frameBased.querySelector('.stop');

  FrameBasedLoop game = new FrameBasedLoop(gameElement);

  startButton.onClick.listen((_) => game.start());
  pauseButton.onClick.listen((_) => game.pause());
  stopButton.onClick.listen((_) => game.stop());
}

void timeBasedLoop(){
  Element frameBased = querySelector('#time-based');
  Element gameElement = frameBased.querySelector('.game');
  ButtonElement startButton = frameBased.querySelector('.start');
  ButtonElement pauseButton = frameBased.querySelector('.pause');
  ButtonElement stopButton = frameBased.querySelector('.stop');

  TimeBasedLoop game = new TimeBasedLoop(gameElement);

  startButton.onClick.listen((_) => game.start());
  pauseButton.onClick.listen((_) => game.pause());
  stopButton.onClick.listen((_) => game.stop());
}