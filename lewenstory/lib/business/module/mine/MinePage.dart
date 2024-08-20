import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/widget/page_base_widget.dart';
import 'package:lewenstory/business/module/index/component/clean_quick_widget.dart';

class MinePage extends PageBaseWidget {
  const MinePage({super.key, required super.currentIndex});

  @override
  State<StatefulWidget> createState() {
    return _MinePage();
  }
}

class _MinePage extends State<MinePage> with TickerProviderStateMixin {
  int? _currentIndex;
  ScrollController _scrollController = ScrollController();
  List<CleanAlbumM> listData = [];
  int albumCount = 0;

  @override
  void initState() {
    super.initState();

    registerScrollObserver();
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    return Scaffold(
      appBar: AppBar(title: Text("平移动画")),
      body: Center(
        child: Stack(
          children: [
            Container(
              width: sw + 40.pt,
              height: 80.pt,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.pt),
                color: SKColor.randomColor(),
              ),
              child: OverflowBox(
                  minWidth: sw + 10.pt,
                  minHeight: 80.pt,
                  maxHeight: 200.pt,
                  maxWidth: sw + 40.pt,
                  child: Transform.rotate(
                      angle: -pi * 0.083,
                      // angle: 0,
                      child: GridView.builder(
                          itemCount: listData.length,
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                  color: SKColor.clear,
                  borderRadius: BorderRadius.circular(10.pt)),
              child: Image(
                image: AssetImage('images/clean_quick_widget_ent.png'),
                width: 360.pt,
                height: 80.pt,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MinePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentIndex != 2) {
      return;
    }
    SkLogUtils.logMessage('mine page didUpdateWidget');
    setState(() {
      _currentIndex = widget.currentIndex;
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
        CleanAlbumM(name: '9')
      ];
    });

    Future.delayed(Duration(milliseconds: 1200), () {
      if (_currentIndex == 2) {
        SkLogUtils.logMessage(
            '延迟1秒执行了: ${_scrollController.offset}====${_scrollController.position.maxScrollExtent}');
        startAnimation();
      }
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

    Timer(Duration(microseconds: 200), () {
      double _initOffset = isTop
          ? _scrollController.position.maxScrollExtent
          : _scrollController.position.minScrollExtent;
      _scrollController.animateTo(_initOffset,
          duration: const Duration(seconds: 5), curve: Curves.linear);
    });
  }
}
