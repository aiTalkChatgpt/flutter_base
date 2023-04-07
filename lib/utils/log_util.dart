import 'dart:collection';

import 'package:flutter/services.dart';


/// Log Util.
class LogUtil {
  
  static const platformLog = const MethodChannel('log_channel');

  static  iTag (String log,{String tag = "LogUtilTag"}){
    Map map = new HashMap();
    map["tag"] = tag;
    map["content"] = log;
    platformLog.invokeMethod("show_log",map);
  }

  static iNet (String url,String response,{String params,String baseUrl}){
    Map map = new HashMap();
    map["tag"] = url;
    map["url"] = baseUrl + url;
    if(null!=params){
      map["params"] = params;
    }
    map["response"] = response;
    platformLog.invokeMethod("net_log",map);
  }
}
