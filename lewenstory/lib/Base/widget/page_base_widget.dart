import 'package:flutter/material.dart';

abstract class PageBaseWidget extends StatefulWidget {
  final int currentIndex;

  const PageBaseWidget({super.key, required this.currentIndex});
}

abstract class InterfaceOne {
  void one();
}

mixin Breathing {
  void swim() => print('Breathing');
}
