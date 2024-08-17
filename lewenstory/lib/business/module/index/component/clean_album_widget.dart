// ignore_for_file: library_private_types_in_public_api

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';

class CleanAlbumWidget extends StatefulWidget {
  const CleanAlbumWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CleanAlbumWidget();
  }
}

class _CleanAlbumWidgetM {
  final String title;
  final String subTitle;
  final String icon;

  _CleanAlbumWidgetM(
      {required this.title, required this.subTitle, required this.icon});
}

class _CleanAlbumWidget extends State<CleanAlbumWidget> {
  List<_CleanAlbumWidgetM> cleanAlbumConfigMList = [
    _CleanAlbumWidgetM(
        title: '相似照片',
        subTitle: '可选相似度',
        icon: 'images/clean_similar_album_ent.png'),
    _CleanAlbumWidgetM(
        title: '重复照片',
        subTitle: '识别快速准确',
        icon: 'images/clean_copy_album_ent.png'),
    _CleanAlbumWidgetM(
        title: '模糊照片',
        subTitle: '清理模糊照片',
        icon: 'images/clean_blurry_album_ent.png'),
    _CleanAlbumWidgetM(
        title: '过暗照片',
        subTitle: '清理过暗照片',
        icon: 'images/clean_dark_album_ent.png')
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 58.pt,
          color: SKColor.clear,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 12.5.pt),
                height: 58.pt,
                child: Center(
                  child: Text(
                    '相册清理',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 14.pt,
                        color: SKColor.ff000000),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 12.pt),
                height: 58.pt,
                child: Center(
                  child: Row(
                    children: [
                      Text(
                        '查看全部',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.pt,
                            color: SKColor.ff999999),
                      ),
                      Image(
                          image:
                              const AssetImage('images/clean_album_arrow.png'),
                          width: 20.pt,
                          height: 28.pt,
                          fit: BoxFit.fill),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 140.pt,
          // color: SKColor.randomColor(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 66.pt,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: CleanAlbumWidgetItemWidget(
                            configM: cleanAlbumConfigMList[0])),
                    SizedBox(
                      width: 8.pt,
                    ),
                    Expanded(
                        flex: 1,
                        child: CleanAlbumWidgetItemWidget(
                            configM: cleanAlbumConfigMList[1]))
                  ],
                ),
              ),
              SizedBox(
                  height: 66.pt,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: CleanAlbumWidgetItemWidget(
                              configM: cleanAlbumConfigMList[2])),
                      SizedBox(
                        width: 8.pt,
                      ),
                      Expanded(
                          flex: 1,
                          child: CleanAlbumWidgetItemWidget(
                              configM: cleanAlbumConfigMList[3]))
                    ],
                  ))
            ],
          ),
        )
      ],
    );
  }
}

class CleanAlbumWidgetItemWidget extends StatelessWidget {
  final _CleanAlbumWidgetM configM;

  const CleanAlbumWidgetItemWidget({super.key, required this.configM});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          SkLogUtils.logMessage('点击了 ${configM.title}');
        },
        child: Container(
          decoration: BoxDecoration(
              color: SKColor.ffffffff, borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12.pt),
                      child: Text(configM.title,
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: SKColor.ff000000)),
                    ),
                    SizedBox(
                      height: 6.pt,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12.pt),
                      child: Text(configM.subTitle,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              color: SKColor.ff999999)),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                margin: EdgeInsets.only(right: 12.pt),
                child: Image(
                  image: AssetImage(configM.icon),
                  width: 44.pt,
                  height: 44.pt,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ));
  }
}
