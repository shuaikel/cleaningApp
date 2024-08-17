import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/widget/page_base_widget.dart';

class CloudPage extends PageBaseWidget {
  const CloudPage({super.key, required super.currentIndex});

  @override
  State<StatefulWidget> createState() {
    return _CloudPage();
  }
}

class _CloudPage extends State<CloudPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            width: 200.pt,
            height: 200.pt,
            color: SKColor.randomColor(),
            child: SKPaintWidget()),
      ),
    );
  }
}

class SKPaintWidget extends StatefulWidget {
  const SKPaintWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SKPaintWidget();
  }
}

class _SKPaintWidget extends State<SKPaintWidget> {
  @override
  Widget build(Object context) {
    return Scaffold(
        body: Center(
      child: Container(
        color: SKColor.randomColor(),
        child: CustomPaint(
          painter: SKPaint(),
          size: const Size(200, 200),
        ),
      ),
    ));
  }
}

class SKPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..strokeWidth = 10;

    canvas.drawPoints(
        PointMode.points,
        [
          const Offset(10, 10),
          const Offset(50, 10),
          const Offset(90, 10),
          const Offset(130, 10),
          const Offset(170, 10)
        ],
        paint);
    Paint paint2 = Paint()
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(
        PointMode.points,
        [
          const Offset(10, 50),
        ],
        paint2);

    Paint circlePaint = Paint()
      ..color = SKColor.randomColor()
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;
    // canvas.drawCircle(const Offset(100, 100), 100, circlePaint);

    // final paintCircle2 = Paint()..color = Colors.blue;
    // canvas.drawCircle(
    //     Offset(size.width / 2, size.height / 2), 100, paintCircle2);

    final rctPaint = Paint()
      ..color = const Color.fromARGB(255, 206, 17, 112)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 30;
    Rect rct = const Rect.fromLTWH(15, 15, 170, 170);
    canvas.drawArc(rct, 0, pi * 1.5, false, rctPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
