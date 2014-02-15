library minenfeld;

import 'dart:html';

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
    for(int i = 0; i < fieldCount; i++){
      
      Point position = new Point(
          i % _cols,
          (i / _cols).floor()
      );
      
      Field field = new Field(i, position);
      fields.add(field);
    }
  }
  
  void _render(){
    _ctx..fillStyle = '#cccccc'
        ..fillRect(0, 0, _width, _height);
    
    fields.forEach((field) => _renderField(field));
  }
  
  void _renderField(Field field){
    double fieldWidth = _width / _cols;
    double fieldHeight = _height / _cols;
    
    _ctx..fillStyle = '#00ff00'
        ..fillRect(field.position.x * fieldWidth + 1, field.position.y * fieldWidth + 1, fieldWidth - 2, fieldHeight - 2);
  }
  
}