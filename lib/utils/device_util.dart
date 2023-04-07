import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/permission_ktx.dart';

///
/// 使用规则
/// 1.可以使用sd卡权限 - 使用getDeviceUniqueId进行获取
/// 2.不可以使用权限 -先判断androidId是否相同 不同判断hardwareId是否相同 两个有一个相同为同一设备
/// 备注：
/// 如果只使用getDeviceUniqueId，不用做任何操作，直接调用
/// 如果使用方案2，需要在Android端增加 DeviceIdUtil 工具类
/// 此工具仅限于Android端使用，ios端使用需要再增加类型
///
class DeviceUtil {
  
  static const platformLog = const MethodChannel('device_channel');

  ///
  /// 同设备安装不同应用 hardwareId相同
  /// 缺点：同设备同型号多个设备可能相同
  ///
  static  getHardwareId () async{
     String hardwareId = await platformLog.invokeMethod("get_hardware_id");
     return hardwareId ?? "";
  }

  ///
  /// 同设备安装不同应用 androidId不同
  /// 不用申请权限 无权限走catch 返回空
  /// 优点：每个设备肯定不同
  ///
  static  getAndroidId () async{
    String androidId = await platformLog.invokeMethod("get_android_id");
    return androidId ?? "";
  }

  ///
  /// 本地存储的id
  /// 缺点：需要获取存储权限
  /// 路径：/storage/emulated/0/Android/yc_project_device_id/device_id.text
  ///
  static getDeviceUniqueId() async{
    bool isHasPermission = await checkAndRequestWritePermission(isAutoIntoSetting: false);
    if(isHasPermission){
      try {
        String storagePath = await getDeviceIdPath() + "device_id.text";
        File file = new File(storagePath);
        printLog("filePath:${file.path}");
        if (!file.existsSync()) {
          //文件不存在
          file.createSync();
          String id = getRandomId();
          file.writeAsBytesSync(id.codeUnits);
          return id;
        }else{
          //存在 取之前的
          String contents = await file.readAsString();
          return contents;
        }

      } catch (e) {
        return "";
      }
    }
    return "";
  }

  ///
  /// 随机id
  /// 系统时间戳+随机三位数字
  ///
  static getRandomId(){
    const keys = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    var rng = new Random();
    String randomKey = keys[rng.nextInt(keys.length-1)];
    return "${new DateTime.now().millisecondsSinceEpoch}$randomKey${rng.nextInt(1000000)}";
  }
}
