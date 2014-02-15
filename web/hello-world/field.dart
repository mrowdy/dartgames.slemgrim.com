part of minenfeld;

class Field{
  
  final int index;
  bool isOpen = false;
  bool isClicked = false;
  bool hasMine = false;
  Point position;
  
  Field(this.index, this.position);
}