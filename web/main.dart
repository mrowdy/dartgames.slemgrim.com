import 'dart:html';
import 'package:Swipe/swipe.dart';

Swipe swipe;
Element swipeContainer;
Element menuBtn;
Element backBtn;

void main(){
  initSwipe();
} 

void initSwipe(){
  swipeContainer = querySelector('.swipe');
  menuBtn = querySelector('.header .menu');
  backBtn = querySelector('.header .back');
  if(swipeContainer == null){
    return;
  }
  
  swipe = new Swipe(swipeContainer);
  
  if(backBtn != null){
    backBtn.onClick.listen((_){
      swipe.prev();
      backBtn.classes.add('hide');
      menuBtn.classes.remove('hide');
    });
  }
  
  if(menuBtn != null){
    menuBtn.onClick.listen((_){
      swipe.next();
      menuBtn.classes.add('hide');
      backBtn.classes.remove('hide');
    });
  }
}