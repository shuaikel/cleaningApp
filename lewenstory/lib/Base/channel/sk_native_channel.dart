import 'package:flutter/services.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';

// flutter 调用ios方法名称枚举
enum SKFlutterIosChannelPluginMethodName {
  // 导入本地相册
  cloud_import_local_album('cloud_import_local_album');

  final String name;
  const SKFlutterIosChannelPluginMethodName(this.name);
}

class SkNativeChannelUtils {
  // 单例模式
  static final SkNativeChannelUtils _instance = SkNativeChannelUtils._init();

  /// 工厂构造函数 返回实例对象
  factory SkNativeChannelUtils() => _instance;

  SkNativeChannelUtils._init();

  // 通道名需要和原生注册通道名保持一致
  static const String channelName = "com.sk.cleaner.flutter_ios_channel";
  // 申明一个平台通道
  static const platform = MethodChannel(channelName);

  // 调用原生方法
  Future<Map?> callNativeMethod(
      SKFlutterIosChannelPluginMethodName methodRaw) async {
    try {
      final result = await platform.invokeMethod(methodRaw.name);
      Map json = result as Map;
      // SkLogUtils.logMessage('原生回调: ${json}');q
      return json;
    } on PlatformException catch (e) {
      SkLogUtils.logMessage('原生回调错误: ${e.message}');
    }
    return null;
  }
}
