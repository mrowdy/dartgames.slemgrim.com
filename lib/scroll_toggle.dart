library scroll_toggle;

import 'dart:html';
import 'dart:async';

class ScrollToggle {
  
  int _scroll = 0;
  int _height;
  bool _isOverHeight = false;
  
  StreamController<bool> _onToggle = new StreamController<bool>();
  
  ScrollToggle(this._height){
    window.onScroll.listen(_handleScroll);
  }
  
  void _handleScroll(Event event){
    _scroll = window.scrollY;
    if(_scroll > _height && _isOverHeight == false){
      _isOverHeight = true;
      _onToggle.add(true);
    } 
    else if(_scroll <= _height && _isOverHeight == true) {
      _isOverHeight = false;
      _onToggle.add(false);
    }
  }
  
  Stream<bool> get onToggle => _onToggle.stream;
}