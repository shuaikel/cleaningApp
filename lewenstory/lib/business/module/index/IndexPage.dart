// ignore_for_file: no_logic_in_create_state
import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_event_bus_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/widget/page_base_widget.dart';
import 'package:lewenstory/business/module/index/component/clean_member_widget.dart';
import 'package:lewenstory/business/module/index/component/clean_other_widget.dart';
import '../../../Base/Service/sk_screen_utils.dart';
import 'component/clean_album_widget.dart';
import 'component/clean_one_key_widget.dart';
import 'component/clean_quick_widget.dart';
import 'component/clean_top_navi_widget.dart';

class IndexPage extends PageBaseWidget {
  const IndexPage({super.key, required super.currentIndex});

  @override
  State<StatefulWidget> createState() {
    return _IndexPage();
  }
}

class _IndexPage extends State<IndexPage> {
  // state
  // 当前可释放空间
  String freeEnableMemory = '0KB';
  // 当前剩余空间
  String availableMemory = "37.65GB";
  // 当前tabbar 选中索引
  int? _currentIndex;
  // 总内存空间
  String summaryMemory = "63.89";
  // 当前是否需要显示开会员引导
  bool isShowCleanMemberGuide = false;
  // 随心清会员高度
  double cleanMemberHeight = (64 + 8).pt;
  // 当前已使用内存%
  double memoryUsePart = 30;
  // 可释放空间
  double memoryFreePart = 10;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;

    SKEventBusUtils.on<SKEventType>((event) {
      SkLogUtils.logMessage('SKEventBusUtils : ${event.value}');
    });
  }

  //
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 依赖关系变化响应
    SkLogUtils.logMessage('依赖关系变化');
  }

  @override
  void didUpdateWidget(IndexPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    SkLogUtils.logMessage('didUpdateWidget');
    if (oldWidget.currentIndex != widget.currentIndex) {
      setState(() {
        _currentIndex = widget.currentIndex;
        isShowCleanMemberGuide = !isShowCleanMemberGuide;
      });
      //
      if (widget.currentIndex == 0) {
        fetchDeviceAlbumInfo();
      }
    }
  }

  @override
  void deactivate() {
    super.deactivate();
    // 当State对象从树中移除但仍保持与原始树的配置关联时做出响应
    SkLogUtils.logMessage('当State对象从树中移除但仍保持与原始树的配置关联时做出响应');
  }

  @override
  void dispose() {
    super.dispose();
    // 清理资源
    SkLogUtils.logMessage('清理资源');
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    double sh = SKScreenUtils.getInstance().screenHeight;
    double tabbarHeight = SKScreenUtils.getInstance().appBarHeight;
    double bottomSafeHeight = SKScreenUtils.getInstance().bottomBarHeight;
    double pageHeight = sh - tabbarHeight - bottomSafeHeight;

    return Scaffold(
      body: Stack(
        children: [
          //
          Container(
            color: SKColor.fff5f5f5,
          ),
          // 背景图片
          Image(
              image: const AssetImage('images/index_gradient_bg.png'),
              width: sw,
              height: 383.pt),
          // 导航栏
          HomeNavigationBarView(),
          // cell 滑动部分
          SafeArea(
              child: Container(
            margin: const EdgeInsets.only(top: 44),
            padding: EdgeInsets.only(left: 7.5.pt, right: 7.5.pt, top: 7.5.pt),
            height: pageHeight,
            color: SKColor.clear,
            child: ListView(
              children: [
                // 一键清理部分
                Container(
                  width: sw,
                  height: 165.pt,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: SKColor.ffffffff),
                  child: CleanOneKeyWidget(
                    freeEnableMemory: freeEnableMemory,
                    availableMemory: availableMemory,
                    summaryMemory: summaryMemory,
                    memoryUsePart: memoryUsePart,
                    memoryFreePart: memoryFreePart,
                  ),
                ),
                // 相册清理部分
                SizedBox(
                  width: sw,
                  child: CleanAlbumWidget(),
                ),
                // 极速快清部分
                Container(
                  width: sw,
                  height: 80,
                  margin: EdgeInsets.only(top: 7.5.pt),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.pt),
                      color: SKColor.ff296eff),
                  child: CleanQuickWidget(
                    listData: [
                      CleanAlbumM(name: '1'),
                      CleanAlbumM(name: '2'),
                      CleanAlbumM(name: '3'),
                      CleanAlbumM(name: '4'),
                      CleanAlbumM(name: '5'),
                      CleanAlbumM(name: '6'),
                      CleanAlbumM(name: '7'),
                      CleanAlbumM(name: '8')
                    ],
                    currentSelectIndex: _currentIndex ?? 0,
                  ),
                ),
                // TODO: 信息流广告
                Container(
                  width: sw,
                  height: 88.pt,
                  margin: EdgeInsets.only(top: 7.5.pt),
                  decoration: BoxDecoration(
                      color: SKColor.randomColor(),
                      borderRadius: BorderRadius.circular(10.pt)),
                  // child: ,
                ),
                // 其他清理部分
                SizedBox(
                  width: sw,
                  height: (82 + 50).pt,
                  child: const CleanOtherWidget(),
                ),
                SizedBox(
                  height: isShowCleanMemberGuide
                      ? cleanMemberHeight + 7.5.pt
                      : 15.5.pt,
                )
              ],
            ),
          )),
          // 会员浮窗
          Visibility(
              visible: isShowCleanMemberGuide,
              child: Positioned(
                  left: 7.5.pt,
                  right: 7.5.pt,
                  bottom: 0,
                  height: cleanMemberHeight,
                  child: const CleanMemberWidget()))
        ],
      ),
    );
  }
}

//
extension _IndexPageExt on _IndexPage {
  // 获取用户相册可清理数据信息
  void fetchDeviceAlbumInfo() {
    SkLogUtils.logMessage('获取用户相册可清理数据信息');
    // 重新绘制
    setState(() {
      memoryUsePart = memoryUsePart > 30 ? 30 : 60;
      memoryFreePart = memoryFreePart > 30 ? 30 : 50;
      isShowCleanMemberGuide = !isShowCleanMemberGuide;
      // SkLogUtils.logMessage('memoryUsePart: $memoryUsePart' +
      //     'isShowCleanMemberGuide: $isShowCleanMemberGuide' +
      //     'memoryFreePart: ' +
      //     '$memoryFreePart');
    });
  }
}
