import 'dart:convert';
import 'package:flutter/cupertino.dart';

extension SkStringExt on String {
  // base64 图片转Image
  Image base64Str2Image({BoxFit? contentMode}) {
    final byteImage = const Base64Decoder().convert(this);
    return Image.memory(
      byteImage,
      fit: contentMode ?? BoxFit.cover,
    );
  }
}
