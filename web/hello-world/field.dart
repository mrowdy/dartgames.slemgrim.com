part of minenfeld;

class Field{
  
  final int index;
  bool isClicked = false;
  bool hasMine = false;
  Point position;
  
  Field(this.index, this.position);
}