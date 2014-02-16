part of minenfeld;

class Field{
  
  final int index;
  bool isOpen = false;
  int surroundingMines = 0;
  bool isMine = false;
  bool isFlagged = false;
  Point position;
  
  Field(this.index, this.position);
  
  
}