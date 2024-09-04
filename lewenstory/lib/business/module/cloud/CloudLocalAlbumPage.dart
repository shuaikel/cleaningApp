import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/Base/category/sk_string_ext.dart';
import 'package:lewenstory/Base/widget/common_navi_widget.dart';

class CloudLocalAlbumPage extends StatefulWidget {
  final Object? params;
  const CloudLocalAlbumPage(this.params, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CloudLocalAlbumPageState();
  }
}

class _CloudLocalAlbumPageState extends State<CloudLocalAlbumPage> {
  List<Object?> dataSource = [];

  @override
  void initState() {
    super.initState();
    List<Object?> dataList = (widget.params as Map)["list"];
    SkLogUtils.logMessage('dataSource: ${dataList.length}');
    setState(() {
      dataSource = dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonNavigationBarWidget(
                configM: CommonNavigationBarConfigM(
                    leftIconName: 'images/cloud_local_album_close.png',
                    leftClickCallBackBlock: () {
                      SkLogUtils.logMessage('返回按钮点击');
                    },
                    title: '导入本地相册')),

            // title
            Container(
              height: 72.5.pt,
              padding: EdgeInsets.only(left: 12.pt),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: 22.5.pt,
                      margin: EdgeInsets.only(top: 12.pt),
                      child: Text('本地相册（${dataSource.length}）',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SKColor.ff000000,
                              fontSize: 16.pt))),
                  Container(
                      height: 20.pt,
                      margin: EdgeInsets.only(top: 6.pt),
                      child: Text('提示：本地相册导入后，此页面中将不再展示',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: SKColor.ff000000,
                              fontSize: 14.pt)))
                ],
              ),
            ),

            // 列表
            Expanded(
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 12.pt, right: 12.pt),
                    itemCount: dataSource.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (ctx, index) {
                      final item = dataSource[index];
                      return configAlbumCell(item, index);
                    }))
          ],
        ),
      )),
    );
  }
}

extension _CloudLocalAlbumPageStateExt on _CloudLocalAlbumPageState {
  //
  Widget configAlbumCell(dynamic item, int index) {
    double sw = SKScreenUtils.getInstance().screenWidth;
    String? base64Image = (item as Map)["assetCover"];
    int assetAlbumCount = (item as Map)["assetAlbumCount"];
    int assetVideoCount = (item as Map)["assetVideoCount"];
    return Container(
      height: 114.pt,
      width: sw,
      margin: index == 0 ? EdgeInsets.zero : EdgeInsets.only(top: 7.5.pt),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.pt), color: SKColor.ffffffff),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 114.pt,
            height: 114.pt,
            color: SKColor.randomColor(),
            child: base64Image?.base64Str2Image(),
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 12.pt),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 20.pt,
                  margin: EdgeInsets.only(top: 12.pt),
                  child: Text(
                    '${(item as Map)["albumName"]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.pt,
                        color: SKColor.ff000000),
                  ),
                ),

                // 数量
                Container(
                  margin: EdgeInsets.only(top: 12.pt),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //
                      SizedBox(
                        child: Text(
                          '$assetAlbumCount 张照片',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.pt,
                              color: SKColor.ff999999),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(left: 8.pt, right: 8.pt, top: 2.pt),
                        width: 1.pt,
                        height: 12.pt,
                        color: SKColor.ff999999,
                      ),
                      Text(
                        '$assetVideoCount 个视频',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14.pt,
                            color: SKColor.ff999999),
                      )
                    ],
                  ),
                ),

                // 导入按钮
                Container(
                  margin: EdgeInsets.only(top: 7.pt),
                  padding: EdgeInsets.only(right: 12.pt),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 88.pt,
                            height: 32.pt,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: SKColor.ff296eff,
                                borderRadius: BorderRadius.circular(16.pt)),
                            child: Text(
                              '立即导入',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.pt,
                                color: SKColor.ffffffff,
                              ),
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
