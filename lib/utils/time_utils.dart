import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:intl/intl.dart';

///
/// 时间工具类
///
///
class TimeUtils {
  static const int seconds = 1000; // 1 秒
  static const int minutes = seconds * 60; // 1 分钟
  static const int minutes_3 = minutes * 3; // 3 分钟
  static const int minutes_5 = minutes * 5; // 5 分钟
  static const int minutes_10 = minutes * 10; // 10 分钟
  static const int hour = minutes * 60; // 1 小时
  static const int day = hour * 24; // 1 天

  /// 显示BottomSheet形式的日期时间选择器。
  ///
  /// context: [BuildContext]
  /// minDateTime: [DateTime] 日期选择器的最小值
  /// maxDateTime: [DateTime] 日期选择器的最大值
  /// initialDateTime: [DateTime] 日期选择器的初始值
  /// dateFormat: [String] 日期时间格式化
  /// locale: [DateTimePickerLocale] 国际化，语言地区
  /// pickerMode: [DateTimePickerMode] 显示的类型: date(日期选择器)、time(时间选择器)、datetime(日期时间选择器)
  /// pickerTheme: [DateTimePickerTheme] 日期选择器的样式
  /// onCancel: [DateVoidCallback] 点击标题取消按钮的回调事件
  /// onClose: [DateVoidCallback] 关闭日期时间选择器的回调事件
  /// onChange: [DateValueCallback] 选择的日期时间改变的事件
  /// onConfirm: [DateValueCallback] 点击标题确定按钮的回调事件
  static void showBottomSheetTimePicker(BuildContext context,  onConfirm, { String format ="yyyy-MM-dd HH:mm:ss"
    ,String currentTime}) {
    DateTime formatTime;
    printLog("format:$format");
    if(null!=currentTime && ""!=currentTime)
      formatTime = DateFormat(format).parse(currentTime);
    printLog("format:$formatTime");
    BrnDatePicker.showDatePicker(context,
        initialDateTime: null!=formatTime?formatTime:DateTime.now(),
        // 支持DateTimePickerMode.date、DateTimePickerMode.datetime、DateTimePickerMode.time
        minuteDivider: 1,
        maxDateTime: DateTime.parse("2033-01-01 24:59:59"),
        minDateTime: DateTime.parse("1999-01-01 00:00:00"),
        pickerMode: BrnDateTimePickerMode.datetime,
        pickerTitleConfig: BrnPickerTitleConfig.Default,
        dateFormat: format, onConfirm: onConfirm,
        onClose: () {
          print("onClose");
        },
        onCancel: () {
          print("onCancel");
        },
        onChange: (dateTime, list) {
          print("onChange:  $dateTime    $list");
        });
  }
}
