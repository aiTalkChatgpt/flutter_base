
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/widget/weather/utils/weather_type.dart';
import 'package:flutter_base/provide/CommonProvider.dart';
import 'package:flutter_base/utils/sp_util.dart';
import 'package:provider/provider.dart';

///
/// 储存全局变量
///
class BaseConstants {


  static bool isBaseLogin;

  static String token;

  ///
  /// 控制登录地址输入
  /// 顶部导航栏页面名称和Tool进入
  ///
  static bool isDebug = true;

  ///Tool进入
  static bool isShowBarTool = false;


  ///
  /// 是否是友创自己用
  ///
  static bool isYCApp = false;

  ///
  /// 独立运行true 其他工程运行时false
  ///
  static bool isModuleRun = false;

  ///
  /// flutter_base 运行true 其他工程运行时false
  ///
  static bool isBaseModuleRun = false;

  static String umengKey;
  static String channel;

  ///用户选择的天气背景
  static int weatherIndex = 0;

  ///默认天气背景索引
  static int initWeatherIndex = 7;

  ///
  ///是否使用天气
  ///
  static bool isUseWeather = true;

  static CommonProvider colorProvider;

  ///
  /// 设置天气背景索引
  /// 
  static void setWeatherBgIndex(int index,BuildContext context){
    if(null==colorProvider){
      colorProvider = Provider.of<CommonProvider>(context);
    }
    printLog("setWeatherBgIndex:$index");
    weatherIndex = index;
    SpUtil.putInt(SpUtil.weatherBgIndex, index);
    List<Color> weatherColor = WeatherUtil.getColor(WeatherType.values[index]);
    colorProvider?.postRefreshAppMainColors(weatherColor);
    colorProvider?.postRefreshWeatherIndex(index);
  }

  ///
  /// 更新主题色根据索引
  ///
  static void updateColorBgIndex(BuildContext context){
    if(null==colorProvider){
      colorProvider = Provider.of<CommonProvider>(context);
    }
    int index = SpUtil.getInt(SpUtil.weatherBgIndex, defValue: initWeatherIndex);
    List<Color> weatherColor = WeatherUtil.getColor(WeatherType.values[index]);
    colorProvider.postRefreshAppMainColors(weatherColor);
    colorProvider.postRefreshWeatherIndex(index);
  }

  ///
  /// 获取天气背景索引
  /// 
  static int getWeatherBgIndex(BuildContext context){
    int weatherIndex = Provider.of<CommonProvider>(context)?.weatherIndex;
    if(null==weatherIndex || 0==weatherIndex){
      weatherIndex = SpUtil.getInt(SpUtil.weatherBgIndex,defValue: initWeatherIndex);
    }
    return weatherIndex;
  }

  ///
  /// 获取动态主颜色
  /// 
  static Color getAppMainColor(BuildContext context){
    Color appMainColor = Provider.of<CommonProvider>(context)?.appMainColor;
    return appMainColor;
  }

  ///
  /// 获取动态主颜色-less
  /// 
  static Color getAppMainLessColor(BuildContext context){
    Color appMainLessColor = Provider.of<CommonProvider>(context)?.appMainLessColor;
    return appMainLessColor;
  }

}
