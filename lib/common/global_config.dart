import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/BaseRouter.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/widget/weather/utils/weather_type.dart';
import 'package:flutter_base/utils/sp_util.dart';
import 'package:flutter_base/utils/time_utils.dart';
///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'api/net_utils.dart';
/// common
import 'app.dart';
import 'base/base_function.dart';
import 'BaseConstants.dart';

///
/// 全局配置文件
///
///

const double screenWidth = 750;
const double screenHeight = 1334;

class BaseGlobalConfig {
  static void init(BuildContext context,{bool isInitWeather=true}) {
    BaseConstants.isUseWeather = isInitWeather;
    SpUtil.getInstance();
    initBaseUrl();
    //设置尺寸（填写设计中设备的屏幕尺寸）如果设计基于360dp * 690dp的屏幕
    ScreenUtil.init(
        BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width,
            maxHeight: MediaQuery.of(context).size.height),
        designSize: Size(screenWidth, screenHeight),
        orientation: Orientation.portrait);

    App.context = context;
    BaseRouter.init();
    //目的：初始化状态栏按钮的颜色
    if(isInitWeather){
      BaseConstants.updateColorBgIndex(context);
    }
  }

  static void initBaseUrl() {

    NetUtils.init(new HttpOptionsModel(BaseApi.BASE_URL,
        connectTimeout: TimeUtils.minutes,
        receiveTimeout: TimeUtils.minutes,
        headers: {
          'accept-language': 'zh-cn',
          'content-type': 'application/json; charset=utf-8',
        }));
  }

  static void setToken(String token) {
    if(token.isNotEmpty){
      dio.options.headers["Authorization"] = 'Bearer ' + token;
      SpUtil.putString(SpUtil.token, token);
    }
  }

  static void setTokenV2(String token) {
    if(token.isNotEmpty){
      dio.options.headers["X-Access-Token"] = token;
      SpUtil.putString(SpUtil.token, token);
    }
  }
}
