import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/business/module/index/component/clean_arc_paint_widget.dart';

class CleanOneKeyWidget extends StatelessWidget {
  final String freeEnableMemory;
  final String availableMemory;
  final String summaryMemory;
  final double memoryUsePart;
  final double memoryFreePart;

  const CleanOneKeyWidget(
      {super.key,
      required this.freeEnableMemory,
      required this.availableMemory,
      required this.summaryMemory,
      required this.memoryUsePart,
      required this.memoryFreePart});

  @override
  Widget build(BuildContext context) {
    double screenWidth = SKScreenUtils.getInstance().screenWidth;
    return Container(
      padding: EdgeInsets.only(left: 12.pt, right: 6.pt),
      width: screenWidth,
      height: 165.pt,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 115.pt,
            height: 115.pt,
            // color: SKColor.randomColor(),
            margin: const EdgeInsets.only(right: 13),
            child: Transform.rotate(
              angle: -(math.pi * 0.8),
              child: Stack(
                children: [
                  CleanDeviceMemoryProgressWidget(
                    freeEnableMemory: freeEnableMemory,
                    availableMemory: availableMemory,
                    summaryMemory: summaryMemory,
                    memoryUsePart: memoryUsePart,
                    memoryFreePart: memoryFreePart,
                  ),
                  Transform.rotate(
                      angle: 0.8 * math.pi,
                      child: SizedBox(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                        text: '${memoryUsePart.toInt()}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25.pt,
                                            color: SKColor.ffff5d29),
                                      ),
                                      TextSpan(
                                        text: '%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13.pt,
                                            color: SKColor.ffff5d29),
                                      )
                                    ])),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 14.pt,
                                child: Text(
                                  '已使用内存',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 10.pt,
                                      color: SKColor.ff666666),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 当前可用内存
                Container(
                  height: 37.pt,
                  margin: EdgeInsets.only(top: 34.pt),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                          child: Container(
                        height: 37.pt,
                        margin: EdgeInsets.only(left: 11.pt),
                        child:
                            // 可释放空间
                            CleanOneKeyWidgetExt.configCleanWidgetBy(
                                MainAxisAlignment.start,
                                CrossAxisAlignment.start,
                                SKColor.ff296eff,
                                freeEnableMemory,
                                '可释放空间',
                                CrossAxisAlignment.start),
                      )),
                      Expanded(
                          child: Container(
                        margin: EdgeInsets.only(right: 18.pt),
                        child:
                            // 剩余空间
                            CleanOneKeyWidgetExt.configCleanWidgetBy(
                                MainAxisAlignment.end,
                                CrossAxisAlignment.start,
                                SKColor.f33000000,
                                availableMemory,
                                '剩余空间',
                                CrossAxisAlignment.start),
                      )),
                    ],
                  ),
                ),
                // 一键清理按钮
                Container(
                  height: 44.pt,
                  margin: EdgeInsets.only(top: 26.pt),
                  child: GestureDetector(
                    onTap: () {
                      SkLogUtils.logMessage('按钮点击');
                    },
                    child: Container(
                      height: 44.pt,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage('images/clean_one_key_logo.png'),
                              fit: BoxFit.fill)),
                      child: Center(
                        child: Text(
                          '一键清理',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.pt,
                              color: SKColor.ffffffff),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

extension CleanOneKeyWidgetExt on CleanOneKeyWidget {
  // 构造component
  static Widget configCleanWidgetBy(
      MainAxisAlignment mainAxisAlignment,
      CrossAxisAlignment crossAxisAlignment,
      Color dotColor,
      String title,
      String subTitle,
      CrossAxisAlignment titleCrossAxisAlignment) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        // 圆点
        Container(
          margin: EdgeInsets.only(top: 7.5.pt),
          width: 6.pt,
          height: 6.pt,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.pt), color: dotColor),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.pt),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: titleCrossAxisAlignment,
            children: [
              Text(
                title,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 15.pt,
                    fontWeight: FontWeight.w600,
                    color: SKColor.ff000000),
              ),
              Text(
                subTitle,
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 10.pt,
                    color: SKColor.ff666666),
              )
            ],
          ),
        )
      ],
    );
  }
}
