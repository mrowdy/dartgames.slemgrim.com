import 'dart:html';
import 'swipe.dart';

Element menuBtn;
Element columns;
Swipe swipe;

void main(){
  initMenu();
} 

void initMenu(){
  menuBtn = querySelector('.menu');
  columns = querySelector('.columns');
  if(menuBtn == null){
    return;
  }
  menuBtn.onClick.listen(toggleMenu);
  swipe = new Swipe(columns);
}

void toggleMenu(MouseEvent evt){
  if(columns == null){
    return;
  }
  columns.classes.toggle('show');
}