import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';

class CleanMemberWidget extends StatelessWidget {
  const CleanMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 8.pt, right: 5.pt, bottom: 7.5.pt),
            child: const Image(
                image: AssetImage('images/clean_member_icon_ent.png')),
          ),
          GestureDetector(
              onTap: () {
                SkLogUtils.logMessage('关闭按钮click');
              },
              child: Container(
                alignment: AlignmentDirectional.topEnd,
                child: Image(
                  image: const AssetImage('images/clean_member_close.png'),
                  width: 16.pt,
                  height: 16.pt,
                ),
              )),
        ],
      ),
    );
  }
}
