import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/permission_ktx.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/utils/device_util.dart';


///
/// <pre>
///     author : pengMaster
///     e-mail :
///     time   : 3/22/22 5:26 PM
///     desc   :
///     version: v1.0
/// </pre>
///
class DeviceIdPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PrinterState();
  }
}
class PrinterState extends AppBarViewState{

  static const platformLog = const MethodChannel('device_channel');


  @override
  Widget buildBody() {
    Map argms = ModalRoute.of(context).settings.arguments;
    printLog("argms:$argms");
    printLog("${argms["function"]}");
    String text = argms["function"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      InkWell(
        onTap: (){
          getDeviceId();
        },
        child: textStyle("DeviceIdP"),
      ),
      Gaps.vGap40,
      textStyle(text),
      InkWell(
        onTap: (){
          BaseConstants.setWeatherBgIndex(1, context);
        },
        child: textStyle("天气"),
      )
    ],);
  }

  getDeviceId() async{
    printLog("androidId:${await DeviceUtil.getDeviceUniqueId()}");

//    bool isHas = await requestPhonePermission();
//    if(isHas){
//      platformLog.invokeMethod("get_device_id").then((value) => {
//        printLog("device_id:$value")
//      });
//    }
  }

  @override
  String getTitle() {
    return "DeviceIdP";
  }

}