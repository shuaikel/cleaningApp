import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';

class CleanOtherWidget extends StatelessWidget {
  const CleanOtherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width;

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.pt),
          width: width,
          height: 20.pt,
          child: Text(
            '其他清理',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.pt,
                color: SKColor.ff000000),
          ),
        ),
        Expanded(
            child: Container(
          margin: EdgeInsets.only(top: 10.pt),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.pt)),
                child: const Image(
                    image: AssetImage('images/clean_guide_ent.png')),
              ),
              const SizedBox(
                child:
                    Image(image: AssetImage('images/clean_calendar_ent.png')),
              )
            ],
          ),
        ))
      ],
    );
  }
}
