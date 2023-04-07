import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

import '../app.dart';


///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2/24/22 4:59 PM
///     desc   : 
///     version: v1.0
/// </pre>
///

///
///弹框组建
///
//双按钮弹框
showConfirmDialog(BuildContext context,Function onConfirm,{String cancel="取消",String confirm="确定"
  ,String title="提示",String message="确认执行该操作?",Function onCancel,bool barrierDismissible = true}){
  BrnDialogManager.showConfirmDialog(context, cancel: cancel,title: title,message:message, confirm: confirm,
      onConfirm: onConfirm,onCancel: onCancel ?? (){ App.pop(context);},barrierDismissible:barrierDismissible);
}

//双按钮弹框
showBottomWritePicker(BuildContext context,BrnBottomWritePickerConfirmClickCallback onConfirm){
  BrnBottomWritePicker.show(context,onConfirm:onConfirm);
}