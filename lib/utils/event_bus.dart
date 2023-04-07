import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';

///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 8/9/22 2:04 PM
///     desc   : 
///     version: v1.0
/// </pre>
///
class EventBus {

  static Map<String,Function> maps = new HashMap();
  static Map<String,List<Function>> mapList = new HashMap();


  ///
  /// 一对一刷新
  ///
  static void postSingle(String key,Object content){
    Function function = maps[key];
    function(content);
  }

  ///
  /// 一对一观察
  ///
  static void observerSingle(String key,Function function){
     maps[key] = function;
  }

  ///
  /// 多对多刷新
  ///
  static void post(Widget widget,String key,Object content){
    printLog("mapList${mapList.length}");
    mapList.forEach((keyList, value) {
      if(keyList == "$widget-$key"){
        value.forEach((element) {
          element(content);
        });
      }
    });
  }

  ///
  /// 多对多观察
  ///
  static void observer(Widget widget,String key,Function function){
    List<Function> list = mapList["$widget-$key"] ?? [];
    list.add(function);
    mapList["$widget-$key"] = list;
    printLog("mapList-observer${mapList.length}");
  }

  ///
  /// 多对多取消观察
  ///
  static void cancel(Widget widget){
    mapList.forEach((key, value) {
      if(key.contains(widget.toString())){
        mapList.remove(key);
      }
    });
  }
}