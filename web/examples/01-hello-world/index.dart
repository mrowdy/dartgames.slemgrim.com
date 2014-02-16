import 'dart:html';
import 'game/minefield.dart';


void main(){
  Element example = querySelector('#container');
  Element reset = querySelector('.reset');
  Element gameMessage = querySelector('.game-message');
  
  Minefield minefield = new Minefield(example);
  
  reset.onClick.listen((_){
    gameMessage.classes.remove('show');
    minefield.setup();
  });
  
  minefield.onWin.listen((_){
    gameMessage.classes.add('show');
    gameMessage.innerHtml = 'Win!';
  });
  
  minefield.onGameOver.listen((_){
    gameMessage.classes.add('show');
    gameMessage.innerHtml = 'Boom!';
  });

}