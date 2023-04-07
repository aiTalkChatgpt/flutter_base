import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/api/net_utils.dart';
import 'package:flutter_base/entry/feed_list_bean.dart';
import 'package:flutter_base/entry/key_value.dart';
import 'package:flutter_base/res/index_res.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2021/4/22 6:07 PM
///     desc   : 共享provider
///     version: v1.0
/// </pre>
///
class CommonProvider with ChangeNotifier{

  Color appMainColor = ResColors.app_main;
  Color appMainLessColor = ResColors.app_main_less;

  int weatherIndex = 0;

  ///
  /// 刷新主题颜色
  ///
  void postRefreshAppMainColors(List<Color> colors,{bool isRefresh}){
    this.appMainColor = colors[0];
    this.appMainLessColor = colors[1];
    if(null!=isRefresh && isRefresh)
    notifyListeners();
  }

  ///
  /// 刷新天气索引
  ///
  void postRefreshWeatherIndex(int index){
    this.weatherIndex = index;
    notifyListeners();
  }

}