library parallax;

import 'dart:html';

class Parallax {
  
  Element _container;
  int _scroll = 0;
  int _offset;
  double multiplicator;
  bool fixed;
  
  Parallax(this._container, [this.multiplicator = 2.0, this._offset = 0, this.fixed = false]){
    window.onScroll.listen(_handleScroll);
  }
  
  void _handleScroll(Event event){
    _scroll = window.scrollY ~/ multiplicator;
    if(fixed){
      _scroll += window.scrollY;
    }
    _container.style.backgroundPosition = '50% -${_scroll + _offset}px';
  }
  
}