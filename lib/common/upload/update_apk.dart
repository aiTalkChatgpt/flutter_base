import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/api/net_utils.dart';
import 'package:flutter_base/common/api/result_data.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/upload/update_dialog.dart';
import 'package:flutter_base/entry/update_version_entity.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/utils/InstallPlugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


/// APP更新类
class UpdateApk {
  static String _version;
  static String _buildNumber;
  static String _flatform;
  static File upFile;
  static String appPackName = "com.example.flutter_base_app";
  static bool isInstall = true;
  static bool isInstallSync = true;
  static UpdateDialog dialog;
  static double progress = 0.0;

  ///
  /// 检查是否有更新
  ///
  static checkUpdate(BuildContext context) async {

    _version = await _checkAppInfo();
    _flatform = await getFlatForm();

    UpdateVersionEntity _hotVersion = await _fetchVersionInfo();

    if (null!=_buildNumber && null!=_hotVersion.versionCode &&
        _hotVersion.versionCode > int.parse(_buildNumber) ) {
      switch (_flatform) {
        case "android":
          bool result = await _checkPermission();
          if (result) {
            isInstall = true;
            bool isForce = "true"==_hotVersion.isForce ? true : false;
            printLog("isForce:$isForce");

            if (dialog != null && dialog.isShowing()) {
              return;
            }
            dialog = UpdateDialog.showUpdate(context,
                width: 250,
                title: '是否升级到最新版本？',
                updateContent: _hotVersion.updateInfo,
                titleTextSize: 14,
                contentTextSize: 12,
                buttonTextSize: 12,
                topImage: Image.asset(getImgPath("update_bg_app_top_blue")),
                extraHeight: 5,
                radius: 8,
                themeColor: ResColors.material_blue_400,
                progressBackgroundColor: ResColors.material_blue_100,
                isForce: isForce,
                updateButtonText: '升级',
                ignoreButtonText: '忽略此版本',
                enableIgnore: false, onIgnore: () {
                  dialog.dismiss();
                }, onUpdate:(){
                  isInstall = true;
                  handleDownloadOrInstall(url: _hotVersion.downloadUrl,version: _hotVersion.versionCode);
                });
          } else {
            return false;
          }
          break;
        case "ios":
          break;
        default:
      }
    }else{
      Fluttertoast.showToast(msg: "已经是最新版本了！");
    }
  }


  static void installApkProcess(){
    if(isInstall && null!=upFile){
      installApk(apkFile: upFile, success: (){
        upFile.deleteSync();
        if(null!=dialog)
        dialog.dismiss();
      });
    }
  }
  /// 获取APP版本号
  static Future _checkAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    return _version;
  }

  ///
  /// 检查是否有权限，用于安卓
  ///
  static Future<bool> _checkPermission() async {
    if (_flatform == 'android') {
      PermissionStatus permission = await PermissionHandler()
          .checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler()
            .requestPermissions([PermissionGroup.storage]);
        if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  /// 获取平台信息
  ///
  /// @return "android" || "ios"
  static Future<String> getFlatForm() async {
    String flatform;
    if (Platform.isAndroid) {
      flatform = 'android';
    } else {
      flatform = 'ios';
    }
    return flatform;
  }

  ///
  /// 拉取版本号信息
  ///
  static Future<UpdateVersionEntity> _fetchVersionInfo() async {
    ResultData resultData = await NetUtils.get(BaseApi.updateVersion+"?appId=$appPackName");
    if(resultData.code ==200 && null!=resultData.data){
      UpdateVersionEntity entity = UpdateVersionEntity.fromJson(resultData.data['data']);
      return entity;
    }
//    return new UpdateVersionEntity(
//        downloadUrl: "http://81.69.4.61:8085/appdown/app-release.apk",
//        versionCode: 20221219,
//        isForce:"false",
//        updateInfo:"1.增加应用内更新功能。\n2.应用内更新方式：进入首页自动更新；手动点击‘检查更新’触发更新。");
  }

  ///
  /// 下载安卓更新包或者直接安装
  ///
   static Future handleDownloadOrInstall({String url, int version}) async {
    /// 创建存储文件
    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    printLog("====>本地版本$_version");
    printLog("====>线上版本$version");

    File file = new File('$storagePath/good-manager-v$version.apk');
    printLog("file.existsSync:${file.existsSync()}");
    if (!file.existsSync()) {
      file.createSync();
    } else {
      upFile = file;
      if(await file.length() > 0 && isInstall){
        installApkProcess();
        return false;
      }

    }
    try {
      Response response = await Dio().get(url, onReceiveProgress: showDownloadProgress,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          )
      );
      file.writeAsBytesSync(response.data);
      upFile = file;
      installApkProcess();
      return file;
    } catch (e) {
      return file;
    }
  }

  ///
  /// 处理下载进度
  ///
  static void showDownloadProgress(num received, num total) {
    if (total != -1) {
      progress = double.parse('${(received / total).toStringAsFixed(2)}');
      printLog("_progress:$progress");
      if (progress >= 1) {
        if(null!=dialog)
        dialog.dismiss();
        progress = 0;
      } else {
        if(null!=dialog)
        dialog.update(progress);
      }
    }
  }

  ///
  /// 安装apk
  ///
  static Future<Null> installApk({@required File apkFile, @required Function success, Function error}) async {
    String _apkFilePath = apkFile.path;
    if (_apkFilePath.isEmpty) {
      return;
    }
    isInstall = false;
    InstallPlugin.installApk(_apkFilePath, appPackName).then((result) {
      success(result);
    }).catchError((err) {
      if (error != null) {
        error(err);
      }
    });
  }

  ///
  /// ios更新转跳
  ///
  static Future<Null> iosLaunch({@required String link}) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  }
}