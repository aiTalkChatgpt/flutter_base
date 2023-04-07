import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/provide/CommonProvider.dart';
import 'package:flutter_base/provide/DbProvider.dart';
import 'package:flutter_base/provide/TestProvider.dart';
import 'package:flutter_base/ui/function_page.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'common/BaseConstants.dart';
import 'common/app.dart';
import 'common/base/base_function.dart';

void main() async {
  runZoned(() {
    printLog("emptyLog_runZoned进来了------>");
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor:
        SystemUiOverlayStyle.dark.systemNavigationBarColor,
      ),
    );

    /// 强制竖屏
//    SystemChrome.setPreferredOrientations(
//        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TestBaseProvider()),
        ChangeNotifierProvider(create: (_) => DbProvider()),
        ChangeNotifierProvider(create: (_) => CommonProvider()),
      ],
      child: MyApp(),
    ));
    printLog("emptyLog_runApp走完了------>");
    PaintingBinding.instance.imageCache.maximumSize = 100;
    configLoading();
  }, onError: (Object error, StackTrace stack) {
    printLog("$error");
    printLog(stack);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    App.context = context;
    BaseConstants.isModuleRun = true;
    BaseConstants.isBaseModuleRun = true;
    printLog("emptyLog_MyApp进来了------>");
    return MaterialApp(
      title: 'Feed',
      home: FunctionPage(),
      builder: EasyLoading.init(),
    );
  }
}

void configLoading() {
  EasyLoading.instance..dismissOnTap = false..maskType = EasyLoadingMaskType.black;
}
