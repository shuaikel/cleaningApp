import 'package:flutter/material.dart';
import 'package:lewenstory/Base/widget/page_base_widget.dart';

class MinePage extends PageBaseWidget {
  const MinePage({super.key, required super.currentIndex});

  @override
  State<StatefulWidget> createState() {
    return _MinePage();
  }
}

class _MinePage extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: <Widget>[Text('123456')],
      ),
    );
  }
}
