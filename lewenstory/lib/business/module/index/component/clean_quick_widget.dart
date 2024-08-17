import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';

class CleanQuickWidget extends StatelessWidget {
  const CleanQuickWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width;
    final height = mediaQueryData.size.height;

    return GestureDetector(
      onTap: () => {SkLogUtils.logMessage('点击了极速快清')},
      child: Container(
        color: SKColor.clear,
        child: Stack(
          children: [
            Container(),
            Container(
              width: width,
              decoration: BoxDecoration(
                  color: SKColor.clear,
                  borderRadius: BorderRadius.circular(10.pt)),
              child: Image(
                image: AssetImage('images/clean_quick_widget_ent.png'),
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
