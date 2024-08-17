import 'dart:math';
import 'package:flutter/material.dart';

class SKColor {
  static Color stringToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('FF');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color randomColor() {
    var random = Random();
    int r = random.nextInt(255);
    int g = random.nextInt(255);
    int b = random.nextInt(255);
    return Color.fromRGBO(r, g, b, 1.0);
  }

  //
  static const Color ffffffff = Color(0xffffffff);
  //
  static const Color ff296eff = Color(0xff296eff);
  //
  static const Color ff6d7278 = Color(0xff6d7278);
  //
  static const Color clear = Colors.transparent;
  //
  static const Color fff5f5f5 = Color(0xfff5f5f5);
  //
  static const Color ff000000 = Color(0xff000000);
  //
  static const Color ff666666 = Color(0xff666666);
  //
  static const Color f33000000 = Color(0x33000000);
  //
  static const Color ffff6127 = Color(0xffff6127);
  //
  static const Color f1a000000 = Color(0x1a000000);
  //
  static const Color ff999999 = Color(0xff999999);
  //
  static const Color ff6194ff = Color(0xff6194ff);
  //
  static const Color ff97b8ff = Color(0xff97b8ff);
  //
  static const Color ffff5d29 = Color(0xffff5d29);
  //
  static const Color a0ff6127 = Color(0xa0ff6127);
}
