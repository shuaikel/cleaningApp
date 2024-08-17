import 'package:flutter/foundation.dart';

class SkLogUtils {
// 只在调试模式下输出日志
  static void logMessage(String message) {
    // ignore: unnecessary_null_comparison
    assert(message != null);
    debugPrint('[日志]: $message');
  }
}
