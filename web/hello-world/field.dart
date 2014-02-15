part of minenfeld;

class Field{
  
  final int index;
  bool isOpen = false;
  int surroundingMines = 0;
  bool hasMine = false;
  Point position;
  
  Field(this.index, this.position);
  
  
}