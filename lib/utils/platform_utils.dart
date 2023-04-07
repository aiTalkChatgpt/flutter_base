import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';

class PlatformUtils {

  static String appVersion = "";

  static String getPlatform() => Platform.operatingSystem;

  static bool isAndroid() => Platform.isAndroid;

  static bool isIOS() => Platform.isIOS;

  /// 获取 Dart Version
  static String getFlutterVersion() => Platform.version;

  static Future<PackageInfo> getAppPackageInfo() {
    return PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    if (appVersion.isEmpty) {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return appVersion = packageInfo.version;
    }else {
      return appVersion;
    }
  }

  static Future getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (isAndroid()) {
      return await deviceInfo.androidInfo;
    } else if (isIOS()) {
      return await deviceInfo.iosInfo;
    } else {
      return null;
    }
  }
}
