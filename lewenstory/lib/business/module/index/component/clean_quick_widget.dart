import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';

class CleanAlbumM {
  String name;

  CleanAlbumM({required this.name});
}

// ignore: must_be_immutable
class CleanQuickWidget extends StatelessWidget {
  CleanQuickWidget(
      {super.key, required this.listData, required this.currentSelectIndex});

  List<CleanAlbumM> listData;
  int currentSelectIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CleanQuickGrideWidget(listData: listData);
  }
}

// ignore: must_be_immutable
class CleanQuickGrideWidget extends StatefulWidget {
  CleanQuickGrideWidget({super.key, required this.listData});

  List<CleanAlbumM> listData;
  int currentSelectIndex = 0;

  @override
  State<StatefulWidget> createState() {
    return _CleanQuickGrideWidget();
  }
}

class _CleanQuickGrideWidget extends State<CleanQuickGrideWidget> {
  final ScrollController _scrollController = ScrollController();
  List<CleanAlbumM> listData = [];
  int albumCount = 0;

  @override
  void initState() {
    super.initState();
    // 滑动监听
    registerScrollObserver();
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    return Stack(
      children: [
        Container(
          // 超出屏幕显示，以此来保证父容器左右两边显示效果更好
          width: sw + 40.pt,
          height: 80.pt,
          // 超出部分截掉
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.pt),
          ),
          child: OverflowBox(
              minWidth: sw + 10.pt,
              minHeight: 80.pt,
              maxHeight: 200.pt,
              maxWidth: sw + 40.pt,
              child: Transform.rotate(
                  // 旋转15度
                  angle: -pi * 0.083,
                  child: GridView.builder(
                      itemCount: listData.length,
                      controller: _scrollController,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 8.pt,
                        mainAxisSpacing: 8.pt,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.zero,
                          child: Container(
                            width: 80.pt,
                            height: 80.pt,
                            color: SKColor.randomColor(),
                          ),
                        );
                      }))),
        ),
        Container(
          width: 360.pt,
          decoration: BoxDecoration(
              color: SKColor.clear, borderRadius: BorderRadius.circular(10.pt)),
          child: Image(
            image: const AssetImage('images/clean_quick_widget_ent.png'),
            width: 360.pt,
            height: 80.pt,
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant CleanQuickGrideWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentSelectIndex != 0) {
      return;
    }
    // 数据源是否改变，此处先mark
    setState(() {
      albumCount = 14;
      listData = [
        CleanAlbumM(name: '1'),
        CleanAlbumM(name: '2'),
        CleanAlbumM(name: '3'),
        CleanAlbumM(name: '4'),
        CleanAlbumM(name: '5'),
        CleanAlbumM(name: '6'),
        CleanAlbumM(name: '7'),
        CleanAlbumM(name: '8'),
        CleanAlbumM(name: '9'),
        CleanAlbumM(name: '10')
      ];
    });

    Future.delayed(const Duration(milliseconds: 1200), () {
      startAnimation();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void registerScrollObserver() {
    _scrollController.addListener(() {
      startAnimation();
    });
  }

  void startAnimation() {
    if (_scrollController.position.maxScrollExtent == 0) {
      SkLogUtils.logMessage('列表content size 为0');
      return;
    }

    if (_scrollController.offset !=
            _scrollController.position.minScrollExtent &&
        _scrollController.offset !=
            _scrollController.position.maxScrollExtent) {
      return;
    }

    bool isTop =
        _scrollController.offset == _scrollController.position.minScrollExtent;

    Timer(const Duration(microseconds: 200), () {
      double animationOffset = isTop
          ? _scrollController.position.maxScrollExtent
          : _scrollController.position.minScrollExtent;
      _scrollController.animateTo(animationOffset,
          duration: const Duration(seconds: 5), curve: Curves.linear);
    });
  }
}
