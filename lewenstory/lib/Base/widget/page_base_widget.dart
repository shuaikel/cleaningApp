import 'package:flutter/material.dart';

abstract class PageBaseWidget extends StatefulWidget {
  final int currentIndex;
  final dynamic routerParam;

  const PageBaseWidget({super.key, required this.currentIndex, this.routerParam});

}

abstract class InterfaceOne {
  void one();
}

mixin Breathing {
  void swim() => print('Breathing');
}
