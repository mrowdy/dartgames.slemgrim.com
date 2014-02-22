import 'dart:html';

import '../lib/parallax.dart';
import '../lib/scroll_toggle.dart';

Element menuBtn;
Element columns;


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
  
  Element headerEl = querySelector('.header');
  Element title = headerEl.querySelector('.title');
  Parallax header = new Parallax(headerEl, 2.0, 0, true);
  Element heroEl = querySelector('.hero');
  Parallax hero = new Parallax(heroEl, 2.0, 60);
  
  ScrollToggle scroll = new ScrollToggle(200);
  scroll.onToggle.listen((status){
    if(status == true){
      title.classes.add('show');
    } else {
      title.classes.remove('show');
    }
  });
}

void toggleMenu(MouseEvent evt){
  if(columns == null){
    return;
  }
  columns.classes.toggle('show');
}