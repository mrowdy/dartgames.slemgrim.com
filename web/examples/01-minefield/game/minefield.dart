library minefield;

import 'dart:html';
import 'dart:math';
import 'dart:async';

part 'field.dart';

/**
 * Minefield is a clone of the well known Minesweeper game
 */
class Minefield{
  
  int _width;  // Width of canvas
  int _height; // Height of canvas
  
  int _rows; // Numer of rows 
  int _cols; // Number of columns
  int _mines; // Number of mines
  
  double _fieldWidth;
  double _fieldHeight;
  
  bool _stopped = true; // game is over
  List<Field> _fields;
  
  Element _container;
  CanvasElement _canvas;
  CanvasRenderingContext2D _ctx;
  
  StreamController _onWin = new StreamController();
  StreamController _onGameOver = new StreamController();
  
  Stream get onWin => _onWin.stream;
  Stream get onGameOver => _onGameOver.stream;
  
  Map<String, String> _colors = {
    'background': '#395D33',
    'closed': '#4DBD33',
    'open': '#734523',
    'numbers': '#ffffff',
    'flag': '#ffffff',
    'mine': '#ff0000'
  };
  
  /**
   * Creates a new minefield instance into [_container] with [_width]px * [_height]px.
   * The game will have [_cols] columns and [_rows] rows with [_mines] mines.
   * 
   */
  Minefield(this._container, [this._width = 320, this._height = 320, this._rows = 10, this._cols = 10, this._mines = 10]){
    _setupCanvas();
    setup();
  }
  
  /**
   * Create a canvas element, set width and height and append to container.
   * Update container width to canvas width
   */
  void _setupCanvas(){
    _canvas = new CanvasElement();
    _canvas..width = _width
           ..height = _height;
    
    _fieldWidth = _width / _cols;
    _fieldHeight = _height / _rows;
   
    
    _ctx = _canvas.getContext('2d');
    _container.style.width = '${_width}px';
    _container.append(_canvas);
  }
  
  /**
   * Initialize a new game
   */
  void setup(){
    _setupFields();
    _handleInputs();
    _render();
    _stopped = false;
  }
  
  /**
   * Update the game state
   */
  void _update(){
    
    // Dont check for finished if the game is over
    if(!_stopped){
      _isFinished();
    }
    _render();
  }
  
  /**
   * Create fields and mines
   */
  void _setupFields(){
    _fields = new List<Field>();
    int fieldCount = _rows * _cols;
    
    //Generate random list of mines
    List<int> mineIndices = _generateMines(_mines);
    
    for(int i = 0; i < fieldCount; i++){
      
      // Create two dimensional position based on list index
      Point position = new Point(
          i % _cols,
          (i / _cols).floor()
      );
      
      Field field = new Field(i, position);
      if(mineIndices.contains(i)){
        field.isMine = true;
      }
      _fields.add(field);
    }
    
    //get surrounding mines of field
    _fields.forEach((Field field){
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
  
  /**
   * Handle mouse inputs
   */
  void _handleInputs(){
    _canvas.onMouseUp.listen((MouseEvent event){
      int index = _positionToIndex(event.offset.x, event.offset.y);
      
      //dont accept inputs if the game is over
      if(_stopped){
        return;
      }
      
      if(event.button == 2){
        _flagField(index);
      } else {
        _openField(index);
      }
    });
      
    //prevent context menu on rightclick
    _canvas.onContextMenu.listen((MouseEvent event){
      event.preventDefault();
    });
  }
  
  /**
   * convert two dimensional position to field index
   * Returns index of field
   */
  int _positionToIndex(x, y){
    x = (x / _width * _cols).floor();
    y = (y / _height * _rows).floor();
    return x + (y * _cols);
  }
  
  /**
   * Try to open the field.
   * You can't open a field which is already opened or is flagged.
   * Game is over when you click a mine.
   * If no mines surrond this field, all surrounding fields are opened.
   * Updates game state.
   */
  void _openField(int index){
    Field field = _fields[index];
    if(field.isOpen || field.isFlagged ){
      return;
    }
    field.isOpen = true;
    if(field.isMine == true){
      _fields.forEach((field){ field.isOpen = true; });
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
  
  /**
   * Flag or unflag a field.
   * You can't flag an opened field
   * Updates game state.
   */
  void _flagField(int index){
    Field field = _fields[index];
    if(field.isOpen){
      return;
    }
    field.isFlagged = !field.isFlagged;
    _update();
  }
 
  /**
   * Stops game and notifies listener
   */
  void _gameOver(){
    _stopped = true;
    _onGameOver.add(true);
  }
  
  /**
   * Generate [count] mines with a random position
   * Returns list of mine indexes
   */
  List<int> _generateMines(int count){
    if(count >= _rows * _cols){
      count =  _rows * _cols;
    }
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
  
  /**
   * Checks if the game is finised:
   * if every field is opened without hitting a mine
   * or if every mine is flagged.
   */
  void _isFinished(){
    bool allOpen = true;
    bool allFlagged = true;
    int flagged = 0;
    _fields.forEach((Field field){
      // All mines flagged?
      if(field.isMine && !field.isFlagged){
        allFlagged = false;
      }
      
      // Count flagged fields
      if(field.isFlagged){
        flagged++;
      }
      
      // All fields which are not mines opened
      if(!field.isMine && !field.isOpen){
        allOpen = false;
      }
    });
    
    // to much fields flagged?
    if(flagged > _mines){
      allFlagged = false;
    }
    
    if(allOpen || allFlagged){
      _stopped = true;
      _onWin.add(true);
    }
  }
  
  /**
   * Returns list of [Field] sourrunding [start].
   */
  List<Field> _getSurroundingFields(Field start){
    List<Field> surrounding = new List<Field>();
    
    _fields.forEach((Field field){
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

  /**
   * Draw the game on the canvas
   */
  void _render(){
    _ctx..fillStyle = _colors['background']
        ..fillRect(0, 0, _width, _height);
    
    _fields.forEach((field) => _renderField(field));
  }
  
  /**
   * Draw a single [field]
   */
  void _renderField(Field field){
    String color = _colors['closed'];
    
    if(field.isOpen) {
      color = _colors['open'];
    }
    
    _ctx..fillStyle = color
        ..fillRect(field.position.x * _fieldWidth + 1, field.position.y * _fieldHeight + 1, _fieldWidth - 2, _fieldHeight - 2);
    
    if(field.isOpen && !field.isMine && field.surroundingMines > 0){
      _ctx..font = "14pt Calibri"
          ..fillStyle = _colors['numbers']
          ..fillText(field.surroundingMines.toString(), field.position.x * _fieldWidth + 5, field.position.y * _fieldHeight + _fieldHeight - 5); 
      
    }
    
    if(field.isFlagged && !field.isOpen){
      _drawCircle(field, _colors['flag']);
    } else if(field.isMine && field.isOpen){
      _drawCircle(field, _colors['mine']);
    }

  }
  
  /**
   * Draw a circle into [field] width a given [color]
   */
  void _drawCircle(Field field, String color){
    _ctx..fillStyle = color
        ..beginPath()
        ..arc(field.position.x * _fieldWidth + _fieldWidth / 2, field.position.y * _fieldHeight +  _fieldHeight / 2, 10, 0,  2 * PI, false)
        ..fill()
        ..closePath();
  }
}