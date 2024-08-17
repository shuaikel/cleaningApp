import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/business/module/index/IndexPage.dart';

class HomeNavigationBarView extends StatelessWidget {
  const HomeNavigationBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: SKColor.clear,
      width: SKScreenUtils.getInstance().screenWidth,
      height: 44,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: SKScreenUtils.getInstance().screenWidth,
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.pink,
                  margin: const EdgeInsets.only(left: 12),
                  child: Image(
                      image: const AssetImage('images/index_mark_logo.png'),
                      width: 108.pt,
                      height: 22.pt),
                ),
                Image(
                    image: const AssetImage('images/vip_index_entrance.png'),
                    width: 130.pt,
                    height: 44)
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
