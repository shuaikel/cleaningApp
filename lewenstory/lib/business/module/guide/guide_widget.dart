import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/StorageUtils/sk_share_preferences.dart';
import 'package:lewenstory/Base/StorageUtils/sk_storage_keys.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/business/module/mine/MinePage.dart';
import 'package:lewenstory/business/tabbar/tabbarController.dart';

class GuideWidget extends StatefulWidget {

  const GuideWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GuideWidget();
  }
}

class _GuideWidget extends State<GuideWidget> {
  final PageController _pageController = PageController(initialPage: 0);
  var tabbarWidget = const Tabbarcontroller();
  bool isAlreadyShowGuide = false;

  int currentIndex = 0;
  String btnTitle = "继续";
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
          Offstage(
            offstage: !isAlreadyShowGuide,
            child: tabbarWidget,
          ),
          // 
          Offstage(
            offstage: isAlreadyShowGuide,
            child: Stack(
              children: [
                PageView(
                  controller: _pageController,
                  onPageChanged: (int index) {
                    setState(() {
                      currentIndex = index;
                      btnTitle = index == 0 ? "继续" : "开始使用";
                      SkLogUtils.logMessage(
                          '_pageController index: $currentIndex');
                    });
                  },
                  physics: const ClampingScrollPhysics(),
                  children: [
                    SizedBox(
                      width: sw,
                      child: const Image(
                        image: AssetImage('images/launch_guide_1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      width: sw,
                      child: const Image(
                        image: AssetImage('images/launch_guide_2.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ],
                ),
                SafeArea(
                    child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 46.pt),
                    height: 76.pt,
                    // color: SKColor.randomColor(),
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // circle
                        SizedBox(
                          height: 8.pt,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8.pt,
                                height: 8.pt,
                                decoration: BoxDecoration(
                                    color: currentIndex == 0
                                        ? SKColor.ff296eff
                                        : SKColor.c33296eff,
                                    borderRadius: BorderRadius.circular(4.pt)),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 12.pt),
                                width: 8.pt,
                                height: 8.pt,
                                decoration: BoxDecoration(
                                    color: currentIndex == 1
                                        ? SKColor.ff296eff
                                        : SKColor.c33296eff,
                                    borderRadius: BorderRadius.circular(4.pt)),
                              )
                            ],
                          ),
                        ),

                        //
                        GestureDetector(
                          onTap: () {
                            handleNextBtnClickAct();
                          },
                          child: Container(
                              width: sw,
                              height: 48.pt,
                              alignment: Alignment.center,
                              margin:
                                  EdgeInsets.only(left: 20.pt, right: 20.pt),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24.pt),
                                color: SKColor.ff296eff,
                              ),
                              child: Text(
                                btnTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: SKColor.ffffffff,
                                  fontSize: 18.pt,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

extension _GuideWidgetExt on _GuideWidget {
  //
  void handleNextBtnClickAct() {
    if (currentIndex == 0) {
      setState(() {
        currentIndex = 1;
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 250), curve: Curves.linear);
      });
      return;
    }

    setState(() {
      isAlreadyShowGuide = true;
      // 引导流程结束
      SkSharePreferences().updateStorage(SkSharePreferencesKey.isShowGuide, true);
    });
  }
}
