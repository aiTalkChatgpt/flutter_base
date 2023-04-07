import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  final permissions =
      await PermissionHandler().requestPermissions([PermissionGroup.location]);

  if (permissions[PermissionGroup.location] == PermissionStatus.granted ) {
    return true;
  } else {
    Fluttertoast.showToast(msg: "需要定位权限!");
    return false;
  }

}

Future<bool> requestPermissionWrite() async {
  final permissions =
  await PermissionHandler().requestPermissions([PermissionGroup.storage]);

  if (permissions[PermissionGroup.storage] == PermissionStatus.granted ) {
    return true;
  } else {
    Fluttertoast.showToast(msg: "需要存储权限!");
    return false;
  }
}


