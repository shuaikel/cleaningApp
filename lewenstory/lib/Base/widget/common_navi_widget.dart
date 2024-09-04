import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/router/sk_router.dart';

class CommonNavigationBarConfigM {
  final String? title;
  final String? leftIconName;
  final Function leftClickCallBackBlock;
  final Function? rightClickCallBackBlock;
  final String? rightTitle;
  final String? rightIconName;

  CommonNavigationBarConfigM(
      {this.title,
      this.leftIconName,
      required this.leftClickCallBackBlock,
      this.rightClickCallBackBlock,
      this.rightTitle,
      this.rightIconName});
}

class CommonNavigationBarWidget extends StatefulWidget {
  final CommonNavigationBarConfigM? configM;
  const CommonNavigationBarWidget({super.key, required this.configM});

  @override
  State<StatefulWidget> createState() {
    return _CommonNavigationBarWidgetState();
  }
}

class _CommonNavigationBarWidgetState extends State<CommonNavigationBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    return Container(
      color: SKColor.clear,
      width: sw,
      height: 44,
      child: Stack(
        children: [
          // title
          Visibility(
              visible: widget.configM?.title?.isNotEmpty ?? false,
              child: OverflowBox(
                  minHeight: 44,
                  maxHeight: 44,
                  minWidth: 0,
                  maxWidth: 200,
                  child: Center(
                    child: Text(
                      widget.configM?.title ?? "",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: SKColor.ff000000,
                      ),
                    ),
                  ))),
          // 左右两侧按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left
              GestureDetector(
                onTap: () => {
                  SkLogUtils.logMessage('点击按钮回退'),
                  SkRouter.popWithContext(context, null),
                  widget.configM?.leftClickCallBackBlock()
                },
                child: Container(
                  margin: EdgeInsets.only(left: 8.pt),
                  child: Image(
                    image: AssetImage(widget.configM?.leftIconName ??
                        "images/clean_common_black_back.png"),
                    width: 28,
                    height: 28,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // right
              Visibility(
                  visible: (widget.configM?.rightTitle?.isNotEmpty ??
                      false ||
                          (widget.configM?.rightIconName?.isNotEmpty ?? false)),
                  child: Container(
                      margin: EdgeInsets.only(right: 8.pt),
                      height: 44,
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            // SkLogUtils.logMessage('右侧按钮点击')
                            if (widget.configM?.rightClickCallBackBlock ==
                                null) {
                              return;
                            }
                            widget.configM?.rightClickCallBackBlock!('回到参数');
                          },
                          //TODO: 图片兼容网络图片
                          child: ((widget.configM?.rightTitle?.length ?? 0) > 0)
                              ? Text(
                                  widget.configM?.rightTitle ?? "",
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontSize: 16.pt,
                                    fontWeight: FontWeight.normal,
                                    color: SKColor.ff666666,
                                  ),
                                )
                              : Image(
                                  image: AssetImage(
                                      widget.configM?.rightIconName ?? ""),
                                  width: 28,
                                  height: 28,
                                ),
                        ),
                      ))),
            ],
          )
        ],
      ),
    );
  }
}
