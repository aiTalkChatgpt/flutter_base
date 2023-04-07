import 'package:flutter/material.dart';
import 'package:flutter_base/ui/test/db_list_page.dart';
import 'package:flutter_base/ui/test/device_id_page.dart';
import 'package:flutter_base/ui/test/feed_list_page.dart';
import 'package:flutter_base/ui/test/printer_page.dart';
import 'package:flutter_base/ui/test/scan_code_page.dart';
import 'package:flutter_base/ui/test/tab_page.dart';
import 'package:flutter_base/common/ui/weather_page_view.dart';
import 'package:flutter_base/ui/test/test_sample_page.dart';
import 'package:flutter_base/common/ui/weather_grid_view.dart';
import 'package:flutter_base/ui/test/weather_page.dart';
import 'package:flutter_calendar/main.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail :
///     time   : 2021/4/20 3:33 PM
///     desc   : 路由调拨
///     version: v1.0
/// </pre>
///
class BaseRouter{

  static Map<String, Widget> routers = new Map();
  static Map<String, String> params = new Map();

  //参数key
  static String id = "/id";

  static String feedList = "feedList";
  static String tabPage = "tabPage";
  static String dbPage = "dbPage";
  static String printerPage = "PrinterPage";
  static String deviceIdPage = "DeviceIdPage";
  static String scanCodePage = "ScanCodePage";
  static String weatherPage = "WeatherPage";
  static String weatherGridViewWidget = "WeatherGridViewWidget";
  static String testSamplePage = "TestSamplePage";
  static String fullCalendarPage = "FullCalendarPage";


  static void init(){
    routers[feedList] = FeedListPage();
    routers[tabPage] = TabPage();
    routers[dbPage] = DbListPage();
    routers[weatherPage] = WeatherPage();
    routers[deviceIdPage] = DeviceIdPage();
    routers[scanCodePage] = ScanCodePage();
    routers[weatherGridViewWidget] = WeatherGridViewWidget();
    routers[testSamplePage] = TestSamplePage();
    routers[fullCalendarPage] = FullCalendarPage();
    routers[printerPage] = PrinterPage();
  }

  ///
  /// key 规则
  /// 路由 + 参数key
  /// 参数都用这个传递接收，不可以直接在页面widget中传递
  ///
  static String getParamByKey(String key,BuildContext context){
    Map argms = ModalRoute.of(context)?.settings?.arguments;
    if(null == argms)return "";
    return argms[key] ?? "";
  }
}