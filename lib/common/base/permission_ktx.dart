import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 3/3/22 4:00 PM
///     desc   : 权限扩展
///     version: v1.0
/// </pre>
///
Future<bool> requestLocationPermission() async {
  final permissions =
  await PermissionHandler().requestPermissions([PermissionGroup.location]);

  if (permissions[PermissionGroup.location] == PermissionStatus.granted ) {
    return true;
  } else {
    Fluttertoast.showToast(msg: "需要定位权限!");
    return false;
  }

}

Future<bool> checkAndRequestWritePermission({bool isAutoIntoSetting = true}) async {
  PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
  if (permissionStatus == PermissionStatus.granted) {
    return true;
  }else{
    final permissions = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    if (permissions[PermissionGroup.location] == PermissionStatus.granted ) {
      return true;
    } else {
      bool isShow = await PermissionHandler().shouldShowRequestPermissionRationale(PermissionGroup.storage);
      if (!isShow && isAutoIntoSetting) {
        Fluttertoast.showToast(msg: '当前权限已被禁用申请，请在设置中手动开启后退出重新进入程序');
        await PermissionHandler().openAppSettings();
      }
      return false;
    }
  }

}

Future<bool> requestPhonePermission() async {
  final permissions =
  await PermissionHandler().requestPermissions([PermissionGroup.phone]);

  if (permissions[PermissionGroup.phone] == PermissionStatus.granted ) {
    return true;
  } else {
    Fluttertoast.showToast(msg: "需要电话权限!");
    return false;
  }

}