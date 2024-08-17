import 'package:lewenstory/Base/Service/sk_screen_utils.dart';

extension IntExt on int {
  double get pt {
    double screenW = SKScreenUtils.getInstance().screenWidth;
    return screenW * toDouble() / 375.0;
  }
}

extension DoubleExt on double {
  //
  double get pt {
    double screenW = SKScreenUtils.getInstance().screenWidth;
    return screenW * this / 375.0;
  }

  // 格式化金额，保留两位小数
  String formatMoney() {
    return toStringAsFixed(2);
  }
}

extension StringExt on String {
  double get toDouble {
    return double.parse(this);
  }

  int get toInt {
    return int.parse(this);
  }
}

// extension CustomList<T> on List<T>{
//  int get doubleLength => length * 2;
//  List<T> operator -() => reversed.toList();
//  List<List<T>> split(int at) => <List<T>>[sublist(0, at), sublist(at)];
//  List<T> reverseList() => List<T>(length)..setAll(0, reversed);
//  bool equals(List<Object> other) => listEquals(this, other);
//  bool listEquals(List self, List other){
//    if(self.length != other.length) return false;
//      for(int i = 0; i < self.length; i++){
//        if(self[i] != other[i]) return false;
//      }
//    return true;
//  }
// }
