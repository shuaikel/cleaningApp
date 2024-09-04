import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_event_bus_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/widget/page_base_widget.dart';
import 'package:lewenstory/router/sk_router.dart';
import 'package:provider/provider.dart';

class CloudPage extends PageBaseWidget {
  const CloudPage({super.key, required super.currentIndex});

  @override
  State<StatefulWidget> createState() {
    return _CloudPage();
  }
}

class _CloudPage extends State<CloudPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    // 3、在子孙组件都可以读取并修改共享数据
    return Scaffold(
      body: Provider(
          create: (_) {},
          child: Builder(builder: (context) {
            return Container(
              width: SKScreenUtils.getInstance().screenWidth,
              child: Stack(
                children: [
                  Image(
                    image: const AssetImage('images/cloud_top_bg.png'),
                    width: sw,
                    height: 320.pt,
                  ),

                  // scrollView
                  SingleChildScrollView(
                    child: SafeArea(
                        child: Column(
                      children: [
                        // 登录
                        Container(
                          margin: EdgeInsets.only(top: 27.pt),
                          padding: EdgeInsets.only(
                              left: 12.pt, right: 12.pt, bottom: 12.pt),
                          height: 60.pt,
                          // color: SKColor.randomColor(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image: const AssetImage(
                                    'images/mine_icon_placehold.png'),
                                width: 60.pt,
                                height: 60.pt,
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 12.pt),
                                // color: SKColor.randomColor(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 22.pt,
                                      // color: SKColor.randomColor(),
                                      child: Text(
                                        '登录七号云空间',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18.pt,
                                            color: SKColor.ff000000),
                                      ),
                                    ),
                                    Container(
                                      height: 16.pt,
                                      margin: EdgeInsets.only(top: 3.pt),
                                      // color: SKColor.randomColor(),
                                      child: Text(
                                        '登录后领取100M空间',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.pt,
                                            color: SKColor.ff296eff),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  SkLogUtils.logMessage('登录');
                                },
                                child: SizedBox(
                                  width: 100.pt,
                                  height: 36.pt,
                                  child: Stack(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'images/cloud_login_bg.png'),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Center(
                                            child: Text(
                                              '立即登录',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: SKColor.ffffffff),
                                            ),
                                          ),
                                          Image(
                                            image: const AssetImage(
                                                'images/cloud_login_arrow.png'),
                                            width: 20.pt,
                                            height: 28.pt,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 加密空间
                        widget.configCellWith(
                            context,
                            'images/cloud_album_security.png',
                            '加密空间',
                            'images/cloud_vip_mark.png',
                            '身份证、银行卡、驾驶证照片存在这里',
                            'images/cloud_black_arrow.png',
                            EdgeInsets.only(left: 12.pt, right: 12.pt)),

                        // 云相册
                        widget.configCellWith(
                            context,
                            'images/cloud_album_zone.png',
                            '云相册',
                            '',
                            '可以将本地相册备份到云端',
                            'images/cloud_black_arrow.png',
                            EdgeInsets.only(
                                left: 12.pt, right: 12.pt, top: 7.5.pt)),

                        // 信息流广告
                        Container(
                            margin: EdgeInsets.only(
                                left: 12.pt, right: 12.pt, top: 7.5.pt),
                            height: 88.pt,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.pt),
                              color: SKColor.ffffffff,
                            )),

                        // 云回收站
                        widget.configCellWith(
                            context,
                            'images/cloud_album_recovery.png',
                            '云回收站',
                            '',
                            '服务期间支持恢复30天内删除的文件',
                            'images/cloud_black_arrow.png',
                            EdgeInsets.only(
                                left: 12.pt, right: 12.pt, top: 7.5.pt)),
                      ],
                    )),
                  )
                ],
              ),
            );
          })),
    );
  }
}

extension CloudPageExt on CloudPage {
  Widget configCellWith(BuildContext context, String leftIcon, String title,
      String imageExt, String subTitle, String arrow, EdgeInsets margin) {
    return GestureDetector(
      onTap: () {
        // SkLogUtils.logMessage('点击响应: $title'),
        if (title == "云相册") {
          SkRouter.pushWithContext(context, SKRouterPath.cloudAlbumPage, {});
          return;
        }
      },
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.pt),
          color: SKColor.ffffffff,
        ),
        height: 72.pt,
        padding: EdgeInsets.only(left: 12.pt, right: 12.pt),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  Image(
                    image: AssetImage(leftIcon),
                    width: 48.pt,
                    height: 48.pt,
                  ),
                  SizedBox(
                    width: 7.pt,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                                fontSize: 14.pt,
                                fontWeight: FontWeight.w500,
                                color: SKColor.ff000000),
                          ),
                          Visibility(
                              visible: imageExt.length > 0,
                              child: Container(
                                margin: EdgeInsets.only(left: 6.pt),
                                child: Image(
                                  image: AssetImage(imageExt),
                                  width: 65.5.pt,
                                  height: 16.pt,
                                ),
                              ))
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.pt),
                        child: Text(
                          subTitle,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12.pt,
                              color: SKColor.ff999999),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Image(
              image: AssetImage(arrow),
              width: 20.pt,
              height: 28.pt,
            )
          ],
        ),
      ),
    );
  }
}
