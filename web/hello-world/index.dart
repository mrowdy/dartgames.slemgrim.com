import 'dart:html';
import 'minenfeld.dart';

Element example;
void main(){
  example = querySelector('#example');
  
  Minenfeld minenfeld = new Minenfeld(example);

}