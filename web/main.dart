import 'dart:html';

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
}

void toggleMenu(MouseEvent evt){
  if(columns == null){
    return;
  }
  columns.classes.toggle('show');
}