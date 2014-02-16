library minenfeld;

import 'dart:html';
import 'dart:math';

part 'field.dart';

class Minenfeld{
  
  int _rows = 10;
  int _cols = 10;
  int _mines = 10;
  
  int _width = 500;
  int _height = 500;
  
  double fieldWidth;
  double fieldHeight;
  
  List<Field> fields = new List<Field>();
  
  Element _container;
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  
  Minenfeld(this._container){
    _setupCanvas();
    _setupFields();
    _handleInputs();
    _render();
  }
  
  Map<String, String> _colors = {
    'background': '#395D33',
    'closed': '#4DBD33',
    'open': '#734523',
    'numbers': '#ffffff',
    'flag': '#ffffff',
    'mine': '#ff0000'
  };
  
  void _setupCanvas(){
    _canvas = new CanvasElement();
    _canvas..width = _width
           ..height = _height;
    
    fieldWidth = _width / _cols;
    fieldHeight = _height / _cols;
    
    _ctx = _canvas.getContext('2d');
    _container.append(_canvas);
  }
  
  void _update(){
    _render();
    if(_isFinished()){
      print('finished');
    }
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
        field.isMine = true;
      }
      fields.add(field);
    }
    
    fields.forEach((Field field){
      List<Field> surrounding = _getSurroundingFields(field);
      if(!field.isMine){
        surrounding.forEach((Field field2){
          if(field2.isMine){
            field.surroundingMines++;
          }
        });
      }
    });
  }
  
  void _render(){
    _ctx..fillStyle = _colors['background']
        ..fillRect(0, 0, _width, _height);
    
    fields.forEach((field) => _renderField(field));
  }
  
  void _renderField(Field field){
    String color = _colors['closed'];
    if(field.isOpen) {
      color = _colors['open'];
    }
    
    _ctx..fillStyle = color
        ..fillRect(field.position.x * fieldWidth + 1, field.position.y * fieldHeight + 1, fieldWidth - 2, fieldHeight - 2);
    
    if(field.isOpen && !field.isMine && field.surroundingMines > 0){
      _ctx..font = "14pt Calibri"
          ..fillStyle = _colors['numbers']
          ..fillText(field.surroundingMines.toString(), field.position.x * fieldWidth + 5, field.position.y * fieldHeight + fieldHeight - 5); 
      
    }
    
    if(field.isFlagged && !field.isOpen){
      _drawCircle(field, _colors['flag']);
    } else if(field.isMine && field.isOpen){
      _drawCircle(field, _colors['mine']);
    }

  }
  
  void _drawCircle(Field field, String color){
    _ctx..fillStyle = color
        ..beginPath()
        ..arc(field.position.x * fieldWidth + fieldWidth / 2, field.position.y * fieldHeight +  fieldHeight / 2, 10, 0,  2 * PI, false)
        ..fill()
        ..closePath();
  }
  
  void _handleInputs(){
    _canvas.onMouseUp.listen((MouseEvent event){
      int index = _positionToIndex(event.offset.x, event.offset.y);
      
      if(event.ctrlKey){
        _flagField(index);
      } else {
        _openField(index);
      }
    });
    
    _canvas.onContextMenu.listen((MouseEvent event){
      event.preventDefault();
      int index = _positionToIndex(event.offset.x, event.offset.y);
    });
  }
  
  int _positionToIndex(x, y){
    x = (x / _width * _cols).floor();
    y = (y / _height * _rows).floor();
    return x + (y * _cols);
  }
  
  void _openField(int index){
    Field field = fields[index];
    if(field.isOpen || field.isFlagged ){
      return;
    }
    field.isOpen = true;
    if(field.isMine == true){
      fields.forEach((field){ field.isOpen = true; });
      _gameOver();
    } else if(field.surroundingMines == 0){
      _getSurroundingFields(field).forEach((Field surr){
        if(!surr.isMine && !surr.isOpen && surr != field){
          _openField(surr.index);
        }
      });
    }
    _update();
  }
  
  void _flagField(int index){
    Field field = fields[index];
    if(field.isOpen){
      return;
    }
    field.isFlagged = !field.isFlagged;
    _update();
  }
 
  void _gameOver(){
    print('game over');
  }
  
  List<int> _generateMines(int count){
    List<int> mineIndices = new List<int>();
    Random rand = new Random();
    while(mineIndices.length < count){
      int index = rand.nextInt(_rows * _cols);
      if(!mineIndices.contains(index)){
        mineIndices.add(index);
      }
    }
    
    return mineIndices;
  }
  
  bool _isFinished(){
    bool allOpen = true;
    bool allFlagged = true;
    fields.forEach((Field field){
      // All mines flagged?
      if(field.isMine && !field.isFlagged){
        allFlagged = false;
      }
      
      // All fields which are not mines opened
      if(!field.isMine && !field.isOpen){
        allOpen = false;
      }
      
    });
    
    return allOpen || allFlagged;
  }
  
  List<Field> _getSurroundingFields(Field start){
    List<Field> surrounding = new List<Field>();
    
    fields.forEach((Field field){
      if(field.position.x >= start.position.x  - 1 
         && field.position.x <= start.position.x + 1
         && field.position.y >= start.position.y - 1
         && field.position.y <= start.position.y + 1
         && field != start
      ){
        surrounding.add(field);
      }
    });
    
    return surrounding;
  }
  
}