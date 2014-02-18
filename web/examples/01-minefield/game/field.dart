part of minenfeld;

class Field{

  final int index;
  final Point position;
  bool isOpen = false;
  bool isMine = false;
  bool isFlagged = false;
  int surroundingMines = 0;
  
  Field(this.index, this.position);
   
}