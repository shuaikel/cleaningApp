import 'dart:convert';

import 'package:lewenstory/Base/StorageUtils/sk_storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkSharePreferences {
  // 单例模式
  static final SkSharePreferences _instance = SkSharePreferences._init();

  /// 工厂构造函数 返回实例对象
  factory SkSharePreferences() => _instance;

  /// SharedPreferences对象
  static late SharedPreferences _storage;
  // 初始化函数
  SkSharePreferences._init() {
    _initStorage();
  }

  // 之所以这个没有写在 _init中，是因为SharedPreferences.getInstance是一个异步的方法 需要用await接收它的值
  _initStorage() async {
    try {
      _storage = await SharedPreferences.getInstance();
    } catch (e) {
      _storage = await SharedPreferences.getInstance();
    }
  }

  // 添加存储
  updateStorage(SkSharePreferencesKey key, dynamic value) async {
    await _initStorage();
    String type;
    // 监测value的类型 如果是Map和List,则转换成JSON，以字符串进行存储
    if (value is Map || value is List) {
      type = 'String';
      value = const JsonEncoder().convert(value);
    }
    // 否则 获取value的类型的字符串形式
    else {
      type = value.runtimeType.toString();
    }
    // 根据value不同的类型 用不同的方法进行存储
    switch (type) {
      case 'String':
        SkSharePreferences._storage.setString(key.value, value);
        break;
      case 'int':
        SkSharePreferences._storage.setInt(key.value, value);
        break;
      case 'double':
        SkSharePreferences._storage.setDouble(key.value, value);
        break;
      case 'bool':
        SkSharePreferences._storage.setBool(key.value, value);
        break;
    }
  }

  /// 获取存储 注意：返回的是一个Future对象 要么用await接收 要么在.then中接收
  Future<dynamic> getStorage(SkSharePreferencesKey key) async {
    await _initStorage();
    // 获取key对应的value
    dynamic value = SkSharePreferences._storage.get(key.value);
    // 判断value是不是一个json的字符串 是 则解码
    if (_isJson(value)) {
      return const JsonDecoder().convert(value);
    } else {
      // 不是 则直接返回
      return value;
    }
  }

  /// 是否包含某个key
  Future<bool> hasKey(SkSharePreferencesKey key) async {
    await _initStorage();
    return SkSharePreferences._storage.containsKey(key.value);
  }

  /// 删除key指向的存储 如果key存在则删除并返回true，否则返回false
  Future<bool> removeStorage(SkSharePreferencesKey key) async {
    await _initStorage();
    if (await hasKey(key)) {
      await SkSharePreferences._storage.remove(key.value);
      return true;
    } else {
      return false;
    }
    // return  _storage.remove(key);
  }

  /// 清空存储 并总是返回true
  Future<bool> clear() async {
    await _initStorage();
    SkSharePreferences._storage.clear();
    return true;
  }

  /// 获取所有的key 类型为Set<String>
  Future<Set<String>> getKeys() async {
    await _initStorage();
    return SkSharePreferences._storage.getKeys();
  }

  // 判断是否是JSON字符串
  _isJson(dynamic value) {
    try {
      // 如果value是一个json的字符串 则不会报错 返回true
      const JsonDecoder().convert(value);
      return true;
    } catch (e) {
      // 如果value不是json的字符串 则报错 进入catch 返回false
      return false;
    }
  }
}
