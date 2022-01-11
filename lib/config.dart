import 'package:flutter/material.dart';

class Config {
  static Color backgroundColor = const Color.fromRGBO(255, 255, 255, 1);
  static Color tilesColor = const Color.fromRGBO(230, 230, 230, 1);
  static Color textcolor = const Color.fromRGBO(50, 50, 50, 1);
  static Color shadowcolor = const Color.fromRGBO(200, 200, 200, 1);
  static changeColor(dtheme) {
    dtheme = !dtheme;
    if (dtheme) {
      backgroundColor = const Color.fromRGBO(0, 0, 0, 1);
      tilesColor = const Color.fromRGBO(40, 40, 40, 1);
      textcolor = const Color.fromRGBO(255, 255, 255, 1);
      shadowcolor = const Color.fromRGBO(200, 200, 200, 0);
    } else {
      backgroundColor = const Color.fromRGBO(255, 255, 255, 1);
      tilesColor = const Color.fromRGBO(230, 230, 230, 1);
      textcolor = const Color.fromRGBO(50, 50, 50, 1);
      shadowcolor = const Color.fromRGBO(200, 200, 200, 1);
    }
  }
}
