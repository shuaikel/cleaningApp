import 'dart:convert';

import 'package:flutter/material.dart';

class JsMessageData {
  const JsMessageData(this.type, this.params, this.callback);
  // 事件类型，一般这个是方法的名称
  final String type;
  // 参数
  final Map<String, dynamic> params;
  // 回调函数名，如果网页需要返回结果就需要传递这个函数
  final String callback;
  // fromJson, 输入是string
  factory JsMessageData.fromJson(String jsonStr) {
    final json = jsonDecode(jsonStr);
    return JsMessageData(
      json["type"],
      json["params"] ?? {},
      json["callback"] ?? "",
    );
  }
}

class Factory<T> {
 
  const Factory(this.constructor) : assert(constructor != null);
  
  final ValueGetter<T> constructor;

  Type get type => T;

  @override
  String toString() {
    return 'Factory(type: $type)';
  }
}
