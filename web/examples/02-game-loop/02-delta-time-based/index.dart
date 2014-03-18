import 'dart:html';
import 'delta-loop.dart';

main(){
  deltaLoop();
}

void deltaLoop(){
  Element frameBased = querySelector('#frame-based');
  Element gameElement = frameBased.querySelector('.game');
  ButtonElement startButton = frameBased.querySelector('.start');
  ButtonElement pauseButton = frameBased.querySelector('.pause');
  ButtonElement stopButton = frameBased.querySelector('.stop');

  DeltaLoop game = new DeltaLoop(gameElement);

  startButton.onClick.listen((_) => game.start());
  pauseButton.onClick.listen((_) => game.pause());
  stopButton.onClick.listen((_) => game.stop());
}