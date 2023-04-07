import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/res/res_colors.dart';


///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 3/1/22 4:19 PM
///     desc   : 主题扩展
///     version: v1.0
/// </pre>
///

setWhiteTextWithTranslate32Bg(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ResColors.transparent_32,
    statusBarIconBrightness: Brightness.dark,
  ));
}

setWhiteTextWithTranslateBg(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: ResColors.transparent_32,
    statusBarIconBrightness: Brightness.dark,
  ));
}

setBlackTextWithTranslateBg(){
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));
}