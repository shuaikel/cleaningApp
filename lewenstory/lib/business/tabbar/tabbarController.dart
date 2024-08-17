import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/business/tabbar/TabbarItem.dart';
import '../module/index/IndexPage.dart';
import '../module/cloud/CloudPage.dart';
import '../module/mine/MinePage.dart';
import '../../Base/Service/sk_color_utils.dart';

class Tabbarcontroller extends StatefulWidget {
  const Tabbarcontroller({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabbarState();
  }
}

class _TabbarState extends State<Tabbarcontroller> {
  int currentIndex = 0;
  // tabbar配置数据源
  List<TabbarItemM> tabbarConfigMList = [
    const TabbarItemM(
        normalIcon: 'images/tab_clear_select.png',
        activeIcon: 'images/tab_clear_unselect.png',
        title: '清理'),
    const TabbarItemM(
        normalIcon: 'images/tab_cloud_select.png',
        activeIcon: 'images/tab_cloud_unselect.png',
        title: '云空间'),
    const TabbarItemM(
        normalIcon: 'images/tab_mine_select.png',
        activeIcon: 'images/tab_mine_unselect.png',
        title: '我的')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: this.pageList[this.currentIndex],
      //页面缓存
      body: IndexedStack(
        index: currentIndex,
        children: <Widget>[
          IndexPage(currentIndex: currentIndex),
          CloudPage(currentIndex: currentIndex),
          MinePage(
            currentIndex: currentIndex,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: SKColor.ffffffff,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        selectedItemColor: SKColor.ff296eff,
        unselectedItemColor: SKColor.ff6d7278,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        enableFeedback: false,
        currentIndex: this.currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
            SkLogUtils.logMessage('当前选择index $currentIndex');
          });
        },
        type: BottomNavigationBarType.fixed,
        items: tabbarConfigMList
            .map((TabbarItemM tabbarM) => BottomNavigationBarItem(
                activeIcon: Image(
                  image: AssetImage(tabbarM.normalIcon ?? ""),
                  width: 28,
                  height: 28,
                ),
                icon: Image(
                    image: AssetImage(tabbarM.activeIcon ?? ""),
                    width: 28,
                    height: 28),
                label: tabbarM.title ?? ""))
            .toList(),
      ),
    );
  }
}
