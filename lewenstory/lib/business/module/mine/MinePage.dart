import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/widget/page_base_widget.dart';

class MineSectionItemConfigM {
  String icon;
  String title;
  String rightIcon;

  MineSectionItemConfigM(this.icon, this.title, this.rightIcon);
}

class MinePage extends PageBaseWidget {
  const MinePage({super.key, required super.currentIndex});

  @override
  State<StatefulWidget> createState() {
    return _MinePage();
  }
}

class _MinePage extends State<MinePage> with TickerProviderStateMixin {
  int? _currentIndex;

  List<MineSectionItemConfigM> sectionList = [
    MineSectionItemConfigM("images/mine_Section_custom_server.png", "会员专属客服",
        "images/mine_section_arrow.png"),
    MineSectionItemConfigM("images/mine_section_privacy.png", "用户政策",
        "images/mine_section_arrow.png"),
    MineSectionItemConfigM("images/mine_section_protocol.png", "用户协议",
        "images/mine_section_arrow.png"),
    MineSectionItemConfigM("images/mine_section_destroy.png", "用户注销",
        "images/mine_section_arrow.png"),
    MineSectionItemConfigM("images/mine_section_about.png", "关于我们",
        "images/mine_section_arrow.png")
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    return Scaffold(
        body: Stack(
      children: [
        // 底图
        Container(
          width: sw.pt,
          height: 320.pt,
          decoration: BoxDecoration(
              color: SKColor.clear, borderRadius: BorderRadius.circular(10.pt)),
          child: Image(
            image: const AssetImage('images/mine_top_bg.png'),
            width: 360.pt,
            height: 80.pt,
            fit: BoxFit.cover,
          ),
        ),
        SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 27.pt),
                padding: EdgeInsets.only(bottom: 12.pt),
                height: (60 + 12).pt,
                width: sw,
                // color: SKColor.randomColor(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 12.pt),
                        child: Image(
                          image: const AssetImage(
                              'images/mine_icon_placehold.png'),
                          width: 60.pt,
                          height: 60.pt,
                        )),
                    TextButton(
                        onPressed: () {
                          SkLogUtils.logMessage('点击登录');
                        },
                        child: Text(
                          '点击登录',
                          style: TextStyle(
                              fontSize: 18.pt,
                              fontWeight: FontWeight.bold,
                              color: SKColor.ff000000),
                        )),
                  ],
                ),
              ),
              
              // 会员
              widget.configVipWidget(),

              // 广告
              Container(
                margin: EdgeInsets.only(top: 12.pt),
                width: 360.pt,
                height: 88.pt,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.pt),
                    color: SKColor.randomColor()),
              ),

              // item
              Container(
                margin: EdgeInsets.only(top: 12.pt),
                width: 360.pt,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.pt),
                  color: SKColor.ffffffff,
                ),
                child: Column(
                  children: sectionList.map((item) {
                    return widget.configSectionItem(item);
                  }).toList(),
                ),
              ),

              //
            ],
          ),
        ))
      ],
    ));
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
  }

  @override
  void dispose() {
    super.dispose();
  }
}

extension MinePageExt on MinePage {
  // section item
  Widget configSectionItem(MineSectionItemConfigM item) {
    return GestureDetector(
        onTap: () {
          SkLogUtils.logMessage('点击: ${item.title}');
        },
        child: Container(
          height: 52.pt,
          color: SKColor.clear,
          padding: EdgeInsets.only(left: 12.pt, right: 12.pt),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(item.icon),
                    width: 28.pt,
                    height: 28.pt,
                  ),
                  SizedBox(
                    width: 8.pt,
                  ),
                  Text(
                    item.title,
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 16.pt,
                        color: SKColor.ff000000),
                  )
                ],
              ),
              SizedBox(
                width: 28.pt,
                height: 28.pt,
                child: Image(
                  image: AssetImage(item.rightIcon),
                ),
              )
            ],
          ),
        ));
  }

  // Vip
  Widget configVipWidget() {
    return SizedBox(
      width: 360.pt,
      height: 76.pt,
      child: Stack(
        children: [
          const Image(
            image: AssetImage('images/mine_clean_member.png'),
            fit: BoxFit.cover,
          ),
          Container(
              margin: EdgeInsets.only(left: 12.pt, top: 16.pt),
              child: Row(
                children: [
                  Image(
                    image: const AssetImage('images/mine_member_mark.png'),
                    width: 90.pt,
                    height: 21.pt,
                  ),
                  SizedBox(
                    width: 6.pt,
                  ),
                  Image(
                    image: const AssetImage('images/mine_member_vip_mark.png'),
                    width: 37.pt,
                    height: 18.pt,
                  )
                ],
              )),
          Container(
            margin: EdgeInsets.only(left: 12.pt, top: 41.pt),
            child: Image(
              image: AssetImage('images/mine_member_upgrade.png'),
              width: 182.pt,
              height: 20.pt,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 18.pt, left: 228.pt),
            child: Container(
              // color: SKColor.randomColor(),
              width: 120.pt,
              height: 40.pt,
              child: Stack(
                children: [
                  const Image(
                      image: AssetImage('images/mine_member_login_bg.png')),
                  GestureDetector(
                    onTap: () {
                      SkLogUtils.logMessage('立即开通');
                    },
                    child: SizedBox(
                      height: 40.pt,
                      // color: SKColor.randomColor(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image(
                            image:
                                const AssetImage('images/mine_member_open.png'),
                            width: 63.pt,
                            height: 15.5.pt,
                          ),
                          Image(
                            image: const AssetImage(
                                'images/mine_member_open_arrow.png'),
                            width: 20.pt,
                            height: 28.pt,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
