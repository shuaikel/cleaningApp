import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_color_utils.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/Service/storage/sk_share_preferences.dart';
import 'package:lewenstory/business/module/splash/splash_widget.dart';
import 'business/tabbar/tabbarController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //   return MaterialApp(
    //     home: const Tabbarcontroller(),
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //       splashColor: SKColor.clear,
    //       highlightColor: SKColor.clear,
    //     ),
    //   );
    // }
    
    // 三方SDK初始化
    _initAsyncSdk();

    return RestartWidget(
      child: MaterialApp(
        home: const Scaffold(
          body: SplashWidget(),
        ),
        theme: ThemeData(
            splashColor: SKColor.clear, highlightColor: SKColor.clear),
      ),
    );
  }

  void _initAsyncSdk() {
    // 初始化存储插件
    var _ = SkSharePreferences();
  }
}

///这个组件用来重新加载整个child Widget的。当我们需要重启APP的时候，可以使用这个方案
///https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode
class RestartWidget extends StatefulWidget {
  final Widget child;

  const RestartWidget({super.key, required this.child});

  static restartApp(BuildContext context) {
    final _RestartWidgetState? state =
        context.findAncestorStateOfType<_RestartWidgetState>();
    state?.restartApp();
  }

  @override
  State<StatefulWidget> createState() {
    return _RestartWidgetState();
  }
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      child: widget.child,
    );
  }
}
