import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/widget/common_navi_widget.dart';

class OnekeyCleanerPage extends StatefulWidget {
  final Object? params;
  const OnekeyCleanerPage(this.params, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _OnekeyCleanerPageState();
  }
}

class _OnekeyCleanerPageState extends State<OnekeyCleanerPage> {
  Object? _params = {};
  @override
  Widget build(BuildContext context) {
    return Container(
      color: SKColor.fff5f5f5,
      child: SafeArea(
          child: Column(
        children: [
          CommonNavigationBarWidget(
              configM: CommonNavigationBarConfigM(
                  leftClickCallBackBlock: () {
                    SkLogUtils.logMessage('返回按钮点击');
                  },
                  rightClickCallBackBlock: (params) {
                    SkLogUtils.logMessage('右侧按钮点击回调: $params');
                  },
                  rightTitle: '右侧',
                  title: '一键清理')),
          
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    SkLogUtils.logMessage('OnekeyCleanerPage initState: ${widget.params}');
    _params = widget.params;
  }

  @override
  void didUpdateWidget(covariant OnekeyCleanerPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
}
