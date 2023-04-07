import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BaseRouter.dart';
import 'base/base_function.dart';

/// router

///
/// 主要提供 context 使用的方法
///
///
class App {

  static BuildContext context;
  static Widget topStackWidget;

  static Future navigateTo(BuildContext context,
      {Map<String, String> params, bool replace = false, bool clearStack = false, Widget pageWidget,String path=""}) {
    print("path:$path,ARouter.routers:${BaseRouter.routers.length}");
    if(path.isNotEmpty){
      pageWidget = BaseRouter.routers[path];
    }
    if("$pageWidget" != "ToolPage")
    topStackWidget = pageWidget;
    printLog("pageWidget:${pageWidget},page-str:${pageWidget.toString()},topStackWidget:$topStackWidget,path:${BaseRouter.routers[path]}");
    if(null==pageWidget){
      Fluttertoast.showToast(msg: "路由地址为空");
      return null;
    }
    if(null!=params){
      BaseRouter.params.addAll(params);
    }
    if (replace) {
      return Navigator.pushReplacement(context, CupertinoPageRoute(
          settings: RouteSettings(arguments: params),
          builder: (ctx) => pageWidget));
    }else {
      return Navigator.push(context, CupertinoPageRoute(
          settings: RouteSettings(arguments: params),
          builder: (ctx) => pageWidget));
    }
  }

  static void pop(BuildContext context, {Map<String,dynamic> result ,Map<String,dynamic> exts}) {
    Navigator.pop(context, result);
  }

  static String getNavigateToParams(Map<String, String> params) {
    String path = "";
    var isFirst = true;
//    params.entries.toList().sublist(1, params.length).forEach((e) {
//
//    });
    params.entries.forEach((e) {
      var k = e.key;
      var v = e.value;
      if (isFirst) {
        path += "?$k=$v";
        isFirst = false;
      } else {
        path += "&$k=$v";
      }
    });
    return path;
  }
}

class FadePageRoute<T> extends MaterialPageRoute<T> {
  FadePageRoute({
    WidgetBuilder builder,
    RouteSettings settings,
  }) : super(
    builder: builder,
    settings: settings,
  );

  @override Duration get transitionDuration => const Duration(milliseconds: 600);

  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
//    if (settings.isInitialRoute) {
//      return child;
//    }

    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
