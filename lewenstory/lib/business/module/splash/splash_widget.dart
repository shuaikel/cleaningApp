import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/sk_screen_utils.dart';
import 'package:lewenstory/Base/Service/storage/sk_share_preferences.dart';
import 'package:lewenstory/Base/Service/storage/sk_storage_keys.dart';
import 'package:lewenstory/Base/category/sk_number_ext.dart';
import 'package:lewenstory/business/module/cloud/CloudPage.dart';
import 'package:lewenstory/business/module/splash/contain_widget.dart';
import 'package:lewenstory/business/tabbar/tabbarController.dart';

class SplashWidget extends StatefulWidget {
  const SplashWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashWidgetState();
  }
}

class _SplashWidgetState extends State<SplashWidget> {
  var container = const Tabbarcontroller();

  bool showLaunch = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 是否显示过引导页面
    SkSharePreferences()
        .getStorage(SkSharePreferencesKey.isShowGuide)
        .then((value) => {SkLogUtils.logMessage('isShowGuide: $value')});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Offstage(
          child: container,
          offstage: showLaunch,
        ),
        //
        Offstage(
          offstage: !showLaunch,
          child: Container(
            width: SKScreenUtils.screenW(context),
            height: SKScreenUtils.screenH(context),
            color: SKColor.ffffffff,
            child: Stack(
              children: [
                SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 44.pt,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 12.pt),
                        child: CountDownWidget(
                          onCountDownFinishCallBack: (bool value) {
                            if (value) {
                              setState(() {
                                showLaunch = false;
                              });
                            }
                          },
                        ),
                      ),
                      //
                      Container(
                        margin: EdgeInsets.only(top: 133.pt),
                        child: Image(
                          image: const AssetImage('images/launch_logo.png'),
                          width: 80.pt,
                          height: 80.pt,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 15.pt),
                        height: 25.pt,
                        child: // Text
                            const Text(
                          '七号清理大师',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: SKColor.ff000000),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 14.pt),
                        height: 20.pt,
                        child: // Text
                            Text(
                          '为您的手机保驾护航',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14.pt,
                              color: SKColor.ff666666),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CountDownWidget extends StatefulWidget {
  final onCountDownFinishCallBack;

  const CountDownWidget({super.key, this.onCountDownFinishCallBack});

  @override
  State<StatefulWidget> createState() {
    return _CountDownWidgetState();
  }
}

class _CountDownWidgetState extends State<CountDownWidget> {
  var _seconds = 5;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44.pt,
      height: 44.pt,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: SKColor.ff999999,
            borderRadius: BorderRadius.circular(22.pt)),
        child: Text(
          '$_seconds',
          style: const TextStyle(
              fontSize: 14.0,
              color: SKColor.ff000000,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds <= 1) {
          widget.onCountDownFinishCallBack(true);
          _cancelTimer();
          return;
        }
        _seconds--;
      });
    });
  }
}
