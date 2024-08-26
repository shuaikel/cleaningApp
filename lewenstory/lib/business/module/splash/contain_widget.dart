

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';

class ContainWidget extends StatefulWidget{
  const ContainWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ContainWidget();
  }

}

class _ContainWidget extends State<ContainWidget> {

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    return Container(
      width: sw,
      color: SKColor.randomColor(),
    );
  }
  
}