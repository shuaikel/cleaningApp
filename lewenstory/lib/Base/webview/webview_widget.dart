// Import for iOS features.
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/webview/skBridge.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class SKWebviewWidget extends StatefulWidget {
  final String url;
  final dynamic params;
  static final String title = '';

  const SKWebviewWidget({super.key, required this.url, this.params});

  @override
  State<StatefulWidget> createState() {
    return _SKWebviewWidgetState();
  }
}

class _SKWebviewWidgetState extends State<SKWebviewWidget> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features
    // 清楚缓存
    controller.clearCache();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onHttpError: (HttpResponseError error) {
            debugPrint('Error occurred on page: ${error.response?.statusCode}');
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            // openDialog(request);
            debugPrint('request: $request');
          },
        ),
      )
      ..addJavaScriptChannel('SKBridge',
          onMessageReceived: (JavaScriptMessage message) async {
        SkLogUtils.logMessage('skBridge ${message.message}');

        // 这里解析出来真实的消息对象
        final data = JsMessageData.fromJson(message.message);
        // 获取js传入的回调函数名称，这里很像jsonp的实现
        final callbackName = data.callback;
        // 定义返回的结果
        dynamic result = {};
        // 执行flutter中定义的方法
        if (data.type == 'hello') {
          result = await hello(data.params["name"]);
        }
        // 判断是否有回调函数，有的话就回调结果给网页调用者
        if (callbackName.isNotEmpty) {
          // 最终还是通过JSON的方式返回给H5
          _controller.runJavaScript("$callbackName(${jsonEncode(result)})");
        }
      });

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features
    _controller = controller;

    if (widget.url.startsWith("http")) {
      _controller.loadRequest(Uri.parse(widget.url));
    } else if (widget.url.startsWith("html")) {
      _controller.loadFlutterAsset(widget.url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }

  FutureOr hello(String name) {
    return {"hello": name};
  }
}
