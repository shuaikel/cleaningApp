// ignore_for_file: file_names

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lewenstory/Base/Service/sk_log_utils.dart';
import 'package:lewenstory/Base/webview/webview_widget.dart';
import 'package:lewenstory/business/module/cloud/CloudAlbumPage.dart';
import 'package:lewenstory/business/module/cloud/CloudLocalAlbumPage.dart';
import 'package:lewenstory/business/module/index/onekeycleanerPage.dart';

class SKRouterPath {
  // 清理页面
  static const String clean = "cleaner/index";
  // 云空间页面
  static const String cloud = "cleaner/cloud";
  // 我的页面
  static const String mine = "cleaner/mine";
  // 一键清理页面
  static const String onekeyCleaner = "cleaner/onekeyCleaner";
  // 云空间详细页面
  static const String cloudAlbumPage = "cleaner/cloud/album/index";
  // 云空间导入本地相册页面
  static const String cloudLocalAlbumPage = "cleaner/cloud/album/local";
}

class SKRouterSchemeUtils {
  static const String http = "http";

  static const String https = "https";

  static const String app = "cleaner";
}

class SKRouterHostUtils {
  static const String native = "com.sk.cleaner";
}

class SKRouterPathMakeUtils {
  static String makeRouterUrl(SKRouterPath path) {
    return "${SKRouterSchemeUtils.app}://${SKRouterHostUtils.native}/${path.toString()}";
  }
}

class SkRouter {
  //路径-widget映射
  static Widget? generateRouter(String url, Object params) {
    // 是否是网页
    if (url.startsWith("http") || url.startsWith("html")) {
      SkLogUtils.logMessage('url info: $url');
      return SKWebviewWidget(url: url, params: params);
    }
    if (url == SKRouterPath.onekeyCleaner) {
      return OnekeyCleanerPage(params);
    }
    if (url == SKRouterPath.cloudAlbumPage) {
      return CloudAlbumPage(params);
    }
    if (url == SKRouterPath.cloudLocalAlbumPage) {
      return CloudLocalAlbumPage(params);
    }
    return null;
  }

// push
  static void pushWithContext(
      BuildContext context, String url, dynamic params) {
    Widget? matchW = generateRouter(url, params);
    SkLogUtils.logMessage('pushWithContext:url = $url' + "params: $params");
    if (matchW == null) {
      debugPrint('路由_路径错误_url:$url');
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return matchW!;
    }));
  }

// pop
  static void popWithContext(BuildContext context, dynamic callbackParam) {
    Navigator.of(context).pop(callbackParam);
  }

  // replace
  static void replace(BuildContext context, String url, dynamic params) {
    Widget? newPageRouter = generateRouter(url, params);
    if (newPageRouter == null) {
      debugPrint('路由_路径错误_url:$url');
    }
    Navigator.of(context).replace(
        oldRoute: ModalRoute.of(context)!,
        newRoute: MaterialPageRoute(builder: (context) {
          return newPageRouter!;
        }));
  }

  // present
  static void presentWithContext(
      BuildContext context, String url, dynamic params, callbackFunc) {
    Widget? matchW = generateRouter(url, params);
    SkLogUtils.logMessage('presentWithContext:url = $url' + "params: $params");
    if (matchW == null) {
      debugPrint('路由_路径错误_url:$url');
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) {
              return matchW!;
            }));
  }

  // remove
  static void remove(BuildContext context, String url) {
    Route? routeToRemove = ModalRoute.of(context);
    if (routeToRemove == null) {
      debugPrint("路由_移除页面_路径错误_url: $url");
    }
    Navigator.of(context).removeRoute(routeToRemove!);
  }
}
