import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'dart:math' as math;
import 'package:lewenstory/Base/category/sk_number_ext.dart';

// 内存使用圆弧
class CleanDeviceMemoryProgressWidget extends StatefulWidget {
  // state
  final String freeEnableMemory;
  final String availableMemory;
  final String summaryMemory;
  double memoryUsePart;
  double memoryFreePart;

  double width = 115.pt;
  double height = 115.pt;

  CleanDeviceMemoryProgressWidget(
      {super.key,
      required this.freeEnableMemory,
      required this.availableMemory,
      required this.summaryMemory,
      required this.memoryUsePart,
      required this.memoryFreePart});

  @override
  State<StatefulWidget> createState() {
    return _CleanDeviceMemoryProgressWidget();
  }
}

class _CleanDeviceMemoryProgressWidget
    extends State<CleanDeviceMemoryProgressWidget>
    with TickerProviderStateMixin {
  // 外环
  late AnimationController controller;
  // 内环
  late AnimationController freeController;

  final double storkWidth = 14.pt;
  final double freeStorkWidth = 12.pt;

  @override
  void initState() {
    super.initState();

    // lazy init
    _initAnimationController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    freeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          SizedBox(
            child: CustomPaint(
              painter: ArcPainter(
                strokeWidth: storkWidth,
                strokeCap: StrokeCap.round,
                gradientColors: const [SKColor.ffff6127, SKColor.a0ff6127],
                bgColor: SKColor.f1a000000,
                progress: controller.value,
                roundColor: SKColor.ffffffff,
                width: widget.width, //需要与widget.width一致
              ),
              size: Size(widget.width, widget.height), // 调整大小以适应你的需求
            ),
          ),
          Container(
            margin: EdgeInsets.all(14.pt),
            child: CustomPaint(
              painter: ArcPainter(
                strokeWidth: freeStorkWidth,
                strokeCap: StrokeCap.round,
                gradientColors: const [SKColor.ff296eff, SKColor.ff97b8ff],
                bgColor: SKColor.clear,
                progress: freeController.value,
                roundColor: SKColor.ffffffff,
                width: widget.width - storkWidth * 2, //需要与widget.width一致
              ),
              size: Size(widget.width - storkWidth * 2,
                  widget.height - storkWidth * 2), // 调整大小以适应你的需求
            ),
          ),
        ],
      ),
    );
  }

  //
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(CleanDeviceMemoryProgressWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.memoryUsePart != widget.memoryUsePart) {
      _initAnimationController();
    }
  }
}

extension __CleanDeviceMemoryProgressWidgetExt
    on _CleanDeviceMemoryProgressWidget {
  // lazy
  void _initAnimationController() {
    // 外环
    controller = AnimationController(
        duration: const Duration(seconds: 3),
        lowerBound: 0,
        upperBound: widget.memoryUsePart,
        vsync: this)
      ..addListener(() {
        setState(() {
          controller.forward();
        });
      });
    if (widget.memoryUsePart > 0) {
      controller.forward();
    }

    // 内环
    freeController = AnimationController(
        duration: const Duration(seconds: 2),
        lowerBound: 0,
        upperBound: widget.memoryFreePart,
        vsync: this)
      ..addListener(() {
        setState(() {
          freeController.forward();
        });
      });
    if (widget.memoryFreePart > 0) {
      freeController.forward();
    }
  }
}

class ArcPainter extends CustomPainter {
  /// rect 容器宽度
  double width;

  ///圆弧粗细
  double strokeWidth;

  ///圆弧边缘显示样式
  StrokeCap strokeCap;

  ///进度条渐变色
  List<Color> gradientColors;

  ///背景颜色
  Color bgColor;

  ///百分比进度，自己内部转换为具体度数
  final double progress;

  ///圆点颜色
  Color roundColor;

  ArcPainter(
      {required this.width,
      required this.strokeWidth,
      required this.strokeCap,
      required this.gradientColors,
      required this.bgColor,
      required this.progress,
      required this.roundColor});

  @override
  void paint(Canvas canvas, Size size) {
    // SkLogUtils.logMessage('paint method: $progress');
    // 要去除storeWidth
    final rect = Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2,
        size.width - strokeWidth, size.height - strokeWidth);

    /// 修正后的开始角度，弧度制
    final startAngle = math.asin(math.pi / 4);

    /// 扫过的角度，弧度制
    final sweepAngle = (math.pi * 2) * progress / 100;

    var gradient = SweepGradient(
      center: Alignment.center,
      colors: gradientColors, // 渐变颜色列表
      startAngle: 0, // 渐变起始位置
      endAngle: 2 * math.pi, // 渐变结束位置
    );

    final paint = Paint()
      ..shader = gradient.createShader(rect) // 使用渐变作为画笔的颜色
      ..style = PaintingStyle.stroke
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth;

    final bgPaint = Paint()
      ..color = bgColor
      ..style = PaintingStyle.stroke
      ..strokeCap = strokeCap
      ..strokeWidth = strokeWidth;
    // 大环圈
    canvas.drawArc(rect, startAngle, math.pi * 2, false, bgPaint);
    // 进度条
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);

    final double drawRadius = (width - strokeWidth) / 2;
    final double center = width / 2;

    // ///修正原点初始角度 90度
    var deg = degToRad(90) + startAngle + sweepAngle;
    final double dx = center + drawRadius * math.sin(deg);
    final double dy = center - drawRadius * math.cos(deg);
    Offset offsetCenter = Offset(dx, dy);
    final roundPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = roundColor;
    canvas.drawCircle(offsetCenter, strokeWidth / 2 - 2, roundPaint);
  }

  /// 度数转类似于π的那种角度
  double degToRad(double deg) => deg * (math.pi / 180.0);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // SkLogUtils.logMessage(oldDelegate.);
    return true;
  }
}
