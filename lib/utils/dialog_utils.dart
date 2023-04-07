import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/common_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';

/// common
import '../common/app.dart';

///
/// 对话框工具类
///
///

class DialogUtils {

  static bool isShowWindow = false;

  /// 显示简单的提示类型对话框
  static void showWindow(BuildContext context, Widget content,
      {bool barrierDismissible = true}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(content: content);
        });
  }

  /// 显示简单的提示类型对话框
  static void showSingleWindow(BuildContext context, Widget content,
      {bool barrierDismissible = true}) {
    if(isShowWindow) return;
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(content: content);
        });
    isShowWindow = true;
  }

  /// 显示简单的提示类型对话框
  static void showHint(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text(content),
          );
        });
  }

  static void showBottomSheet(
      BuildContext context, List<CupertinoActionSheetAction> actions,
      {String title = '提示', String cancel = '取消'}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return Stack(
            children: <Widget>[
              Positioned(
                bottom: 0,
                child: CupertinoActionSheet(
                  title: Text(title),
                  actions: actions,
                  cancelButton: CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    child: Text(cancel),
                    onPressed: () {
                      App.pop(context);
                    },
                  ),
                ),
              ),
            ],
          );
        });
//    .then((onPressedResult){
//          App.pop(context);
//    });
  }

  ///
  /// 显示简单的加载类型对话框更新
  /// barrierDismissible 是否点击外面区域会关闭弹框
  ///
  static void showProgress(BuildContext context,
      {bool barrierDismissible = false,String content="正在加载中..."}) {
    showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return AlertDialog(
              content: Container(
            width: 60,
            child: Row(
              children: <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(),
                  height: 30.0,
                  width: 30.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: textStyle(content),)
              ],
            ),
          ));
        });
  }
}
