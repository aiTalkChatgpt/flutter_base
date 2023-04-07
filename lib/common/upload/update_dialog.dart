import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/common_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/res/res_font.dart';
import 'package:flutter_base/utils/string_utils.dart';

import 'number_progress.dart';

///版本更新加提示框
class UpdateDialog {
  bool _isShowing = false;
  BuildContext _context;
  UpdateWidget _widget;

  UpdateDialog(BuildContext context,
      {double width = 0.0, 
        String title,
       String updateContent,
       VoidCallback onUpdate,
      double titleTextSize = 16.0,
      double contentTextSize = 14.0,
      double buttonTextSize = 14.0,
      double progress = -1.0,
      Color progressBackgroundColor = const Color(0xFFFFCDD2),
      Image topImage,
      double extraHeight = 5.0,
      double radius = 4.0,
      Color themeColor = Colors.red,
      bool enableIgnore = false,
      VoidCallback onIgnore,
      bool isForce = false,
      String updateButtonText,
      String ignoreButtonText,
      VoidCallback onClose}) {
    _context = context;
    _widget = UpdateWidget(
        width: width,
        title: title,
        updateContent: updateContent,
        onUpdate: onUpdate,
        titleTextSize: titleTextSize,
        contentTextSize: contentTextSize,
        buttonTextSize: buttonTextSize,
        progress: progress,
        topImage: topImage,
        extraHeight: extraHeight,
        radius: radius,
        themeColor: themeColor,
        progressBackgroundColor: progressBackgroundColor,
        enableIgnore: enableIgnore,
        onIgnore: onIgnore,
        isForce: isForce,
        updateButtonText: updateButtonText ?? '更新',
        ignoreButtonText: ignoreButtonText ?? '忽略此版本',
        onClose: onClose ?? () => dismiss());
  }

  /// 显示弹窗
  Future<bool> show() {
    try {
      if (isShowing()) {
        return Future<bool>.value(false);
      }
      showDialog<bool>(
          context: _context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () => Future<bool>.value(false), child: _widget);
          });
      _isShowing = true;
      return Future<bool>.value(true);
    } catch (err) {
      _isShowing = false;
      return Future<bool>.value(false);
    }
  }

  /// 隐藏弹窗
  Future<bool> dismiss() {
    try {
      if (_isShowing) {
        _isShowing = false;
        Navigator.pop(_context);
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    } catch (err) {
      return Future<bool>.value(false);
    }
  }

  /// 是否显示
  bool isShowing() {
    return _isShowing;
  }

  /// 更新进度
  void update(double progress) {
    if (isShowing()) {
      _widget.update(progress);
    }
  }

  /// 显示版本更新提示框
  static UpdateDialog showUpdate(BuildContext context,
      {double width = 0.0,
       String title,
       String updateContent,
       VoidCallback onUpdate,
      double titleTextSize = 16.0,
      double contentTextSize = 14.0,
      double buttonTextSize = 14.0,
      double progress = -1.0,
      Color progressBackgroundColor = const Color(0xFFFFCDD2),
      Image topImage,
      double extraHeight = 5.0,
      double radius = 4.0,
      Color themeColor = Colors.red,
      bool enableIgnore = false,
      VoidCallback onIgnore,
      String updateButtonText,
      String ignoreButtonText,
      bool isForce = false}) {
    final UpdateDialog dialog = UpdateDialog(context,
        width: width,
        title: title,
        updateContent: updateContent,
        onUpdate: onUpdate,
        titleTextSize: titleTextSize,
        contentTextSize: contentTextSize,
        buttonTextSize: buttonTextSize,
        progress: progress,
        topImage: topImage,
        extraHeight: extraHeight,
        radius: radius,
        themeColor: themeColor,
        progressBackgroundColor: progressBackgroundColor,
        enableIgnore: enableIgnore,
        isForce: isForce,
        updateButtonText: updateButtonText,
        ignoreButtonText: ignoreButtonText,
        onIgnore: onIgnore);
    dialog.show();
    return dialog;
  }
}

// ignore: must_be_immutable
class UpdateWidget extends StatefulWidget {
  /// 对话框的宽度
  final double width;

  /// 升级标题
  final String title;

  /// 更新内容
  final String updateContent;

  /// 标题文字的大小
  final double titleTextSize;

  /// 更新文字内容的大小
  final double contentTextSize;

  /// 按钮文字的大小
  final double buttonTextSize;

  /// 顶部图片
  final Widget topImage;

  /// 拓展高度(适配顶部图片高度不一致的情况）
  final double extraHeight;

  /// 边框圆角大小
  final double radius;

  /// 主题颜色
  final Color themeColor;

  /// 更新事件
  final VoidCallback onUpdate;

  /// 可忽略更新
  final bool enableIgnore;

  /// 更新事件
  final VoidCallback onIgnore;

  double progress;

  /// 进度条的背景颜色
  final Color progressBackgroundColor;

  /// 更新事件
  final VoidCallback onClose;

  /// 是否是强制更新
  final bool isForce;

  /// 更新按钮内容
  final String updateButtonText;

  /// 忽略按钮内容
  final String ignoreButtonText;

  UpdateWidget(
      {Key key,
      this.width = 0.0,
       this.title,
       this.updateContent,
       this.onUpdate,
      this.titleTextSize = 16.0,
      this.contentTextSize = 14.0,
      this.buttonTextSize = 14.0,
      this.progress = -1.0,
      this.progressBackgroundColor = const Color(0xFFFFCDD2),
      this.topImage,
      this.extraHeight = 5.0,
      this.radius = 4.0,
      this.themeColor = Colors.red,
      this.enableIgnore = false,
      this.onIgnore,
      this.isForce = false,
      this.updateButtonText = '更新',
      this.ignoreButtonText = '忽略此版本',
      this.onClose})
      : super(key: key);

  final _UpdateWidgetState _state = _UpdateWidgetState();

  void update(double progress) {
    _state.update(progress);
  }

  @override
  _UpdateWidgetState createState() => _state;
}

class _UpdateWidgetState extends State<UpdateWidget> {
  void update(double progress) {
    if (!mounted) {
      return;
    }
    setState(() {
      widget.progress = progress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double dialogWidth =
        widget.width <= 0  ?getFitWidth(context) * 0.618 : widget.width;
    return Material(
        type: MaterialType.transparency,
        child: Container(
          child: SizedBox(
            width: dialogWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: dialogWidth,
                  child: widget.topImage ??
                      Image.asset(getImgPath("update_bg_app_top_blue"), fit: BoxFit.fill),
                ),
                Container(
                  width: dialogWidth,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 8, bottom: 8),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(widget.radius),
                          bottomRight: Radius.circular(widget.radius)),
                    ),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: widget.extraHeight),
                        child: Text(widget.title,
                            style: TextStyle(
                                fontSize: widget.titleTextSize,
                                color: Colors.black)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(widget.updateContent,
                            style: TextStyle(
                                fontSize: widget.contentTextSize,
                                color: const Color(0xFF666666))),
                      ),
                      if (widget.progress < 0)
                        Column(children: <Widget>[
                          FractionallySizedBox(
                            widthFactor: 1,
                            child: RoundedDivButton(
                              widget.updateButtonText,
                              onTap: widget.onUpdate,
                              radius: 8,
                              backgroundColor: widget.themeColor,
                            ),
                          ),
                          if (widget.enableIgnore && widget.onIgnore != null)
                            FractionallySizedBox(
                                widthFactor: 1,
                                child: GestureDetector(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 10,bottom: 5),
                                    child: textStyle(widget.ignoreButtonText,fontSize: ResSize.text_12),
                                  ),
                                  onTap: widget.onIgnore,
                                ))
                          else
                            const SizedBox()
                        ])
                      else
                        NumberProgress(
                            value: widget.progress,
                            backgroundColor: widget.progressBackgroundColor,
                            valueColor: widget.themeColor,
                            padding: const EdgeInsets.symmetric(vertical: 10))
                    ],
                  )),
                ),
                if (!widget.isForce)
                  Column(children: <Widget>[
                    const SizedBox(
                        width: 1.5,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.white))),
                    IconButton(
                      iconSize: 30,
                      constraints:
                          const BoxConstraints(maxHeight: 30, maxWidth: 30),
                      padding: EdgeInsets.zero,
                      icon: Image.asset(getImgPath("update_ic_close"),),
                      onPressed: widget.onClose,
                    )
                  ])
                else
                  const SizedBox()
              ],
            ),
          ),
        ));
  }

  double getFitWidth(BuildContext context) {
    return min(getScreenHeight(context), getScreenWidth(context));
  }

  double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
}
