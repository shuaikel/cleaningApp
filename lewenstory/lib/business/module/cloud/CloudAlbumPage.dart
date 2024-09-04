import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/widget/common_navi_widget.dart';
import 'package:lewenstory/business/module/guide/guide_widget.dart';

class CloudAlbumM {
  String albumId;
  String label;
  String name;
  String photoCount;
  String videoCount;
  String cover;

  CloudAlbumM(
      {required this.albumId,
      required this.label,
      required this.name,
      required this.photoCount,
      required this.videoCount,
      required this.cover});
}

class CloudAlbumPage extends StatefulWidget {
  final Object? params;
  const CloudAlbumPage(this.params, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CloudAlbumPageState();
  }
}

class _CloudAlbumPageState extends State<CloudAlbumPage> {
  //
  final List<CloudAlbumM> albumMList = [];
  bool isNavigationRightBtnClick = false;
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
    return Scaffold(
      backgroundColor: SKColor.fff5f5f5,
      body: SafeArea(
          child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                // 导航栏
                CommonNavigationBarWidget(
                    configM: CommonNavigationBarConfigM(
                        leftClickCallBackBlock: () {
                          SkLogUtils.logMessage('返回按钮点击');
                        },
                        rightClickCallBackBlock: (params) {
                          SkLogUtils.logMessage('右侧按钮点击回调: $params');
                          //
                          setState(() {
                            isNavigationRightBtnClick =
                                !isNavigationRightBtnClick;
                          });
                        },
                        // rightTitle: '',
                        rightIconName: 'images/cloud_navi_right.png',
                        title: '云相册')),

                // 信息流广告
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.pt),
                    color: SKColor.ffffffff,
                  ),
                  height: 88.pt,
                  margin:
                      EdgeInsets.only(left: 7.5.pt, right: 7.5.pt, top: 7.5.pt),
                ),

                // 存储剩余空间
                Container(
                  margin: EdgeInsets.only(top: 15.pt, left: 16.pt),
                  height: 20.pt,
                  alignment: Alignment.topLeft,
                  child: Text(
                    '存储空间剩余：3G/10G',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14.pt,
                        color: SKColor.ff000000),
                  ),
                ),

                // empty
                Visibility(
                    visible: albumMList.isEmpty,
                    child: Container(
                      margin: EdgeInsets.only(top: 60.pt),
                      width: 360.pt,
                      // color: SKColor.randomColor(),
                      child: Column(
                        children: [
                          Image(
                            image: const AssetImage(
                                'images/cloud_album_empty.png'),
                            width: 110.pt,
                            height: 110.pt,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.pt),
                            height: 22.5.pt,
                            child: Text(
                              '暂无相册哦～',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.pt,
                                  color: SKColor.ff000000),
                            ),
                          ),
                          SizedBox(
                            height: 40.pt,
                          ),
                          // 新建相册
                          TextButton(
                              onPressed: () {
                                SkLogUtils.logMessage('新建相册');
                              },
                              style: ButtonStyle(
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent)),
                              child: Container(
                                alignment: Alignment.center,
                                width: 180.pt,
                                height: 44.pt,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.pt),
                                    color: SKColor.ff296eff),
                                child: Text(
                                  '新建相册',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.pt,
                                      color: SKColor.ffffffff),
                                ),
                              ))
                        ],
                      ),
                    )),
              ],
            ),
          ),
          Visibility(
              visible: isNavigationRightBtnClick,
              child: Positioned(
                  right: 12.pt,
                  top: 44.pt,
                  child: Container(
                    width: 156.pt,
                    height: 120.pt,
                    alignment: Alignment.bottomRight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.pt),
                        color: SKColor.ffffffff,
                        boxShadow: [
                          BoxShadow(
                            color: SKColor.c00d8d8d8,
                            offset: Offset(5.0, 5.0),
                            blurRadius: 10.0,
                          )
                        ]),
                  )))
        ],
      )),
    );
  }
}
