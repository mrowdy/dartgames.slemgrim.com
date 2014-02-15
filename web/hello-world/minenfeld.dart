library minenfeld;

import 'dart:html';
import 'dart:math';

part 'field.dart';

class Minenfeld{
  
  int _rows = 10;
  int _cols = 10;
  int _mines = 10;
  
  int _width = 300;
  int _height = 300;
  
  List<Field> fields = new List<Field>();
  
  Element _container;
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  
  Minenfeld(this._container, [this._rows = 10, this._cols = 10, this._mines = 10]){
    _setupCanvas();
    _setupFields();
    _handleInputs();
    _render();
  }
  
  void _setupCanvas(){
    _canvas = new CanvasElement();
    _canvas..width = _width
           ..height = _height;
    
    _ctx = _canvas.getContext('2d');
    _container.append(_canvas);
  }
  
  void _setupFields(){
    int fieldCount = _rows * _cols;
    List<int> mineIndices = _generateMines(_mines);
    
    for(int i = 0; i < fieldCount; i++){
      
      Point position = new Point(
          i % _cols,
          (i / _cols).floor()
      );
      
      Field field = new Field(i, position);
      if(mineIndices.contains(i)){
        field.hasMine = true;
      }
      fields.add(field);
    }
    
    fields[4].hasMine = true;
  }
  
  void _render(){
    _ctx..fillStyle = '#cccccc'
        ..fillRect(0, 0, _width, _height);
    
    fields.forEach((field) => _renderField(field));
  }
  
  void _renderField(Field field){
    double fieldWidth = _width / _cols;
    double fieldHeight = _height / _cols;
    
    String color = '#00ff00';
    if(field.isOpen) {
      if(field.hasMine){
        color = '#ff0000';
      } else {
        color= '#0000ff';
      }
    }
    _ctx..fillStyle = color
        ..fillRect(field.position.x * fieldWidth + 1, field.position.y * fieldWidth + 1, fieldWidth - 2, fieldHeight - 2);
  }
  
  void _handleInputs(){
    _canvas.onMouseUp.listen((MouseEvent event){
      int index = _positionToIndex(event.offset.x, event.offset.y);
      _openField(index);
    });
  }
  
  int _positionToIndex(x, y){
    x = (x / _width * _cols).floor();
    y = (y / _height * _rows).floor();
    return x + (y * _cols);
  }
  
  void _openField(int index){
    Field field = fields[index];
    field.isOpen = true;
    if(field.hasMine == true){
      fields.forEach((field){ field.isOpen = true; });
      _gameOver();
    }
    _render();
  }
 
  void _gameOver(){
    print('game over');
  }
  
  List<int> _generateMines(int count){
    List<int> mineIndices = new List<int>();
    Random rand = new Random();
    while(mineIndices.length < count){
      mineIndices.add(rand.nextInt(_rows * _cols));
    }
    
    return mineIndices;
  }
  
}