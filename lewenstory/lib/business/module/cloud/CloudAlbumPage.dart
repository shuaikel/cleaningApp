import 'package:flutter/material.dart';

class MethodController {
  // 用此方法调用子组件方法
  Function(String arg)? dealSubFunction;

  // 用此方法调用父组件方法
  Function(String arg)? dealFatherFunction;
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
  final MethodController methodController = MethodController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    methodController.dealFatherFunction = (String arg) {
      // 调用父组件方法
      fatherFunction(arg);
    };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 这里是父组件方法
  void fatherFunction(String param) {
    print("这里是父组件方法 params:${param}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375,
      height: 600,
      color: Colors.amber,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 100,
          ),
          SubChild(
            methodController: methodController,
          ),
          SizedBox(
            width: 20,
            height: 40,
          ),
          TextButton(
            child: Text("点击调用子组件方法${widget.params}"),
            onPressed: () {
              String arg = "来自父组件的参数";
              if (methodController.dealSubFunction != null) {
                methodController.dealSubFunction!(arg);
              }
            },
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}

// 子组件Widget
class SubChild extends StatefulWidget {
  const SubChild({
    super.key,
    required this.methodController,
  });

  final MethodController methodController;

  @override
  State<SubChild> createState() => _SubChildState();
}

class _SubChildState extends State<SubChild> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.methodController.dealSubFunction = (String arg) {
      // 调用子方法
      subFunction(arg);
    };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // 这里是子组件方法
  void subFunction(String arg) {
    print("这里是子组件方法 arg:${arg}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 300,
        color: Colors.greenAccent,
        child: Container(
          width: 200,
          height: 50,
          child: TextButton(
            child: Text(
              "点击调用父组件方法",
              style: TextStyle(color: Colors.brown),
            ),
            onPressed: () {
              onSubBtnPressed();
            },
          ),
        ));
  }

  // 点击调用父组件方法
  void onSubBtnPressed() {
    print("点击调用父组件方法");
    String param = "来自子组件的参数";
    if (widget.methodController.dealFatherFunction != null) {
      widget.methodController.dealFatherFunction!(param);
    }
  }
}
