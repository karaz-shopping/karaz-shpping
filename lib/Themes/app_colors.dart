import 'package:flutter/material.dart';

class AppColors {
  // * Convert Color from Hex to type Flutter 0xFFdddddd
  static Color _colorFromHex(String hexColor) {
    final hexCode = hexColor.replaceAll('#', '');
    return Color(int.parse('FF$hexCode', radix: 16));
  }

  static final Color somo = _colorFromHex('#FFB0B0');
  static final Color somo2 = _colorFromHex('#FFBFBF');
  static final Color somo5 = _colorFromHex('#ffdfdf');
  static final Color somo3 = _colorFromHex('#ffcbcb');
  static final Color somo4 = _colorFromHex('#ffd2d2');
  static final Color watermelon = _colorFromHex('#FE7171');
  static final Color darkHerb = _colorFromHex('#335D2D');
  static final Color lightHerb = _colorFromHex('#7EA04D');

  static final Color rose1 = _colorFromHex('#FFAFAF');
  static final Color nudie1 = _colorFromHex('#FBFFE2');
  static final Color nudie2 = _colorFromHex('#FFEBCC');
  static final Color rose2 = _colorFromHex('#FF9999');

  static final Color purple3 = _colorFromHex('#4C0033');
  static final Color purple2 = _colorFromHex('#790252');
  static final Color purple1 = _colorFromHex('#AF0171');
  static final Color pink = _colorFromHex('#E80F88');

  static final Color green = _colorFromHex('#B3FFAE');
  static final Color lightBrown = _colorFromHex('#F8FFDB');
  static final Color rose4 = _colorFromHex('#FF6464');
  static final Color rose3 = _colorFromHex('#FF7D7D');

  static final Color greenYellow2 = _colorFromHex('#E1FFB1');
  static final Color greenYellow3 = _colorFromHex('#C7F2A4');
  static final Color greenYellow4 = _colorFromHex('#B6E388');
  static final Color greenYellow1 = _colorFromHex('#FCFFB2');

  static final Color blueGrey4 = _colorFromHex('#2F8F9D');
  static final Color blueGrey3 = _colorFromHex('#3BACB6');
  static final Color blueGrey2 = _colorFromHex('#82DBD8');
  static final Color blueGrey1 = _colorFromHex('#B3E8E5');

  static final Color blueGreen1 = _colorFromHex('#DEF5E5');
  static final Color blueGreen2 = _colorFromHex('#BCEAD5');
  static final Color blueGreen3 = _colorFromHex('#9ED5C5');
  static final Color blueGreen4 = _colorFromHex('#8EC3B0');

  static final List<Color> blueGreyList = [
    blueGrey1,
    blueGrey2,
    blueGrey3,
    blueGrey4,
  ];
  static final List<Color> blueGreenList = [
    blueGreen1,
    blueGreen2,
    blueGreen3,
    blueGreen4,
  ];
  static final List<Color> mixList = [
    blueGreen1,
    blueGreen2,
    blueGreen3,
    blueGreen4,
    blueGrey1,
    blueGrey2,
    blueGrey3,
    blueGrey4,
  ];
}
