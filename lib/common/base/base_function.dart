import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/base/permission_ktx.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/res/dimens.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/utils/date_util.dart';
import 'package:flutter_base/utils/dialog_utils.dart';
import 'package:flutter_base/utils/log_util.dart';
import 'package:flutter_base/utils/time_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart';

/// app common
import '../app.dart';
import 'widget/file_page.dart';

export '../app.dart';
export '../app.dart';

showHint(BuildContext context, String content) {
  DialogUtils.showHint(context, content);
}


bool isEmpty(String str) => str == null || str.isEmpty;

bool isEmptyList(List list) => list == null || list.isEmpty;

///----------------------------------------------------

/// 页面跳转

Future navigateTo(BuildContext context, Widget pageWidget,
    {Map<String, String> params,bool replace = false,String path = ""}) {
  return App.navigateTo(context, params: params, pageWidget: pageWidget,replace: replace,path: path);
}

void pop(BuildContext context, {Map<String, dynamic> result, Map<String, dynamic> exts}) {
  App.pop(context, result: result, exts: exts);
}


/// image ----------------------------------------------------

///
AssetImage assetImage(String namePath) => AssetImage("images/$namePath");

String assetName(String namePath) => "images/$namePath";

assetImageXX(String namePath) => AssetImage("images/2.0x/$namePath.png");

assetImageXXX(String namePath) => AssetImage("images/3.0x/$namePath.png");

/// image ----------------------------------------------------

///screen ----------------------------------------------------

h(double height) => ScreenUtil().setHeight(height);

w(double width) => ScreenUtil().setWidth(width);

sp(double fontSize) => ScreenUtil().setSp(fontSize);

double get screenDpW => ScreenUtil().screenWidth;

double get screenDpH => ScreenUtil().screenHeight;

double get screenHalfDpW => screenDpW * 0.5;

double get screenHalfDpH => screenDpH * 0.5;


/// 安全区域的dp高度
double get safeContentH => screenDpH - ScreenUtil().statusBarHeight - ScreenUtil().bottomBarHeight;

double get statusBarHeight => ScreenUtil().statusBarHeight;

double get bottomBarHeight => ScreenUtil().bottomBarHeight;

/// 实际安全区域的dp高度
double get safeH => safeContentH - kToolbarHeight - kBottomNavigationBarHeight;

double get appBarHeight => kToolbarHeight;

double get appNavBarHeight => kBottomNavigationBarHeight;

///----------------------------------------------------

Widget get emptyCenterWidget => Center(
  child: Text("内容空"),
);

/// msg：提示的文字，String类型。
/// toastLength: 提示的样式，主要是长度，有两个值可以选择：Toast.LENGTH_SHORT ：短模式，就是比较短。Toast.LENGTH_LONG : 长模式，就是比较长。
/// gravity：提示出现的位置，分别是上中下，三个选项。ToastGravity.TOP顶部提示，ToastGravit.CENTER中部提示，ToastGravity.BOTTOM底部提示。
/// bgcolor: 背景颜色，跟从Flutter颜色。
/// textcolor：文字的颜色。
/// fontSize： 文字的大小。
void show(String msg) => Fluttertoast.showToast(msg: msg);

Map<String,LogBean> logMap = HashMap();
class LogBean{
  String tag;
  String log;

  LogBean(this.tag, this.log);
}
printLog(Object o,{String tag}) {
  logMap["${App.topStackWidget}-${DateUtil.getNowDateByYYYYMMDDHHMMSS()}"] = LogBean(tag,o);
  LogUtil.iTag(o,tag: tag ?? "");
}

///
/// 重复点击
///
var lastPopTime;
clickWithTrigger(clickBack) {
  if (lastPopTime == null ||
      DateTime.now().difference(lastPopTime) > Duration(seconds: 2)) {
    lastPopTime = DateTime.now();
    clickBack();
  } else {
    lastPopTime = DateTime.now();
  }
}

String filterNull(dynamic str) {
  if (null == str || "null" == str) {
    return "-";
  } else {
    return str;
  }
}

String filterEmpty(dynamic str) {
  if (null == str || "null" == str) {
    return "";
  } else {
    return str;
  }
}
//String filterNullByParent(Object parent,Object str) {
//  print("filterNullByParentparent:$parent");
//  print("str:$str");
//  return null!=parent?str:"-";
//}

String filterNullByParent(dynamic parent, dynamic str) {
  if (null == parent || "null" == parent) {
    return "-";
  }
  if (null == str || "null" == str) {
    return "-";
  } else {
    return str;
  }
}

String getImgPath(String name, {String format: 'png',
  bool isBaseModuleRun}) {
  if(null == isBaseModuleRun) isBaseModuleRun = BaseConstants.isBaseModuleRun;
  if(isBaseModuleRun)
    return 'assets/images/3.0x/$name.$format';
  else
    return 'packages/flutter_base/assets/images/3.0x/$name.$format';
}

String filterNullBack(dynamic str,String back) {
  if (null == str || "null" == str) {
    return back;
  } else {
    return str;
  }
}
/// 去除.00
String filterNum(String data) {
  if (data.isEmpty) return "";
  if (data.contains(".") && RegExp(r"\.(0+)$").hasMatch(data)) {
    return data.split('.')[0];
  } else {
    return data;
  }
}

/// 间隔
class Gaps {
  /// 水平间隔
  static Widget hGap3 = SizedBox(width: Dimens.gap_dp3);
  static Widget hGap4 = SizedBox(width: Dimens.gap_dp4);
  static Widget hGap5 = SizedBox(width: Dimens.gap_dp5);
  static Widget hGap6 = SizedBox(width: Dimens.gap_dp6);
  static Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static Widget hGap10 = SizedBox(width: Dimens.gap_dp10);
  static Widget hGap12 = SizedBox(width: Dimens.gap_dp12);
  static Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
  static Widget hGap20 = SizedBox(width: Dimens.gap_dp20);
  static Widget hGap24 = SizedBox(width: Dimens.gap_dp24);
  static Widget hGap40 = SizedBox(width: Dimens.gap_dp40);

  /// 垂直间隔
  static Widget vGap3 = SizedBox(height: Dimens.gap_dp3);
  static Widget vGap4 = SizedBox(height: Dimens.gap_dp4);
  static Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static Widget vGap6 = SizedBox(height: Dimens.gap_dp6);
  static Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static Widget vGap15 = SizedBox(height: Dimens.gap_dp15);
  static Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static Widget vGap20 = SizedBox(height: Dimens.gap_dp20);
  static Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static Widget vGap25 = SizedBox(height: Dimens.gap_dp25);
  static Widget vGap40 = SizedBox(height: Dimens.gap_dp40);

  static Widget getHGap(double w) {
    return SizedBox(width: w);
  }

  static Widget getVGap(double h) {
    return SizedBox(height: h);
  }
}

class TextStyles {
  static const TextStyle textRed12 =
  TextStyle(fontSize: Dimens.font_sp12, color: Colors.red);
  static const TextStyle textBlue12 =
  TextStyle(fontSize: Dimens.font_sp12, color: Colors.blueAccent);
  static const TextStyle textWhite12 =
  TextStyle(fontSize: Dimens.font_sp12, color: Colors.white);
  static const TextStyle textGrayC12 =
  TextStyle(fontSize: Dimens.font_sp12, color: Color(0xFFcccccc));
  static const TextStyle textGray12 =
  TextStyle(fontSize: Dimens.font_sp12, color: Colors.grey);
  static const TextStyle textDark12 =
  TextStyle(fontSize: Dimens.font_sp12, color: Color(0xFF333333));
  static const TextStyle textBoldDark12 = TextStyle(
      fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle textBoldWhile12 = TextStyle(
      fontSize: 12.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle textWhite14 =
  TextStyle(fontSize: Dimens.font_sp14, color: Colors.white);
  static const TextStyle textRed14 =
  TextStyle(fontSize: Dimens.font_sp14, color: Colors.red);
  static const TextStyle textBlue14 =
  TextStyle(fontSize: Dimens.font_sp14, color: Colors.blueAccent);
  static const TextStyle textGrayC14 =
  TextStyle(fontSize: Dimens.font_sp14, color: Color(0xFFcccccc));
  static const TextStyle textGray14 =
  TextStyle(fontSize: Dimens.font_sp14, color: Colors.grey);
  static const TextStyle textDark14 =
  TextStyle(fontSize: Dimens.font_sp14, color: Color(0xFF333333));
  static const TextStyle textBoldDark14 = TextStyle(
      fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle textBoldWhile14 = TextStyle(
      fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle textRed16 =
  TextStyle(fontSize: Dimens.font_sp16, color: Colors.red);
  static const TextStyle textBlue16 =
  TextStyle(fontSize: Dimens.font_sp16, color: Colors.blueAccent);
  static const TextStyle textWhite16 =
  TextStyle(fontSize: Dimens.font_sp16, color: Colors.white);
  static const TextStyle textGrayC16 =
  TextStyle(fontSize: Dimens.font_sp16, color: Color(0xFFcccccc));
  static const TextStyle textGray16 =
  TextStyle(fontSize: Dimens.font_sp16, color: Colors.grey);
  static const TextStyle textDark16 =
  TextStyle(fontSize: Dimens.font_sp16, color: Color(0xFF333333));
  static const TextStyle textBoldDark16 = TextStyle(
      fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold);
  static const TextStyle textBoldWhile16 = TextStyle(
      fontSize: 16.0, color: Colors.white, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark20 = TextStyle(
      fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.bold);

  static const TextStyle textBoldDark26 = TextStyle(
      fontSize: 26.0, color: Colors.black, fontWeight: FontWeight.bold);
}

buildCategoryStr(String value1,String value2,String value3){
  StringBuffer stringBuffer = StringBuffer();
  if(null!=value1 && value1.isNotEmpty){
    stringBuffer.write(value1+"  ");
  }
  if(null!=value2 && value2.isNotEmpty){
    stringBuffer.write(value2+"  ");
  }
  if(null!=value3 && value3.isNotEmpty){
    stringBuffer.write(value3+"  ");
  }
  return stringBuffer.toString();
}


///图片预览
previewImage(BuildContext context,String url,{bool isLocationImage = false, Color bgColor}) {
  printLog("context:$context,url:$url,bgColor:$bgColor");
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        insetPadding: EdgeInsets.all(0),
        backgroundColor:Color.fromARGB(0, 0, 0, 0),
        child: Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenHeight,
          child: PhotoView(
            imageProvider:isLocationImage?
            FileImage(File(url)):
            NetworkImage(
              url,   /// filePath
            ),
            backgroundDecoration:
            BoxDecoration(color:bgColor ?? Color.fromARGB(255, 0, 0, 0)),
          ),
        ),
      );
    },
  );
}

///
/// 图片      打开预览
/// word pdf 进入FileViewPage
/// 其他      进入WebView
///
///
openFileByUrl(BuildContext context,String url,{bool isUseBaseUrl = true,bool isForceImage = false}){
  printLog("openFileByUrl:$url");
  if(null!=url && ""!=url){
    var split = url.split(".");
    String endStr = split[split.length-1];
    if(isForceImage){
      previewImage(context,isUseBaseUrl?BaseApi.baseImgUrl+url:""+url);
      return;
    }
    switch(endStr){
      case "jpeg":
      case "jpg":
      case "png":
        previewImage(context,isUseBaseUrl?BaseApi.baseImgUrl+url:""+url);
        return;
      case "doc":
      case "docx":
      case "pdf":
        App.navigateTo(context, pageWidget:FileViewPage(url));
        return;
      default:
        Fluttertoast.showToast(msg: "不支持打开的附件");
        return;
    }
  }else{
    Fluttertoast.showToast(msg: "不支持打开的附件");
  }
}

int string2int(String value){
  if(null == value || "" == value) return 0;
  return double.parse(value).round();
}

///
/// PDF WORD DOC预览布局背景颜色
///
getFileBgColorByUrl(String url){
  if(null!=url && ""!=url){
    var split = url.split(".");
    String endStr = split[split.length-1];
    switch(endStr){
      case "doc":
        return ResColors.app_main;
      case "docx":
        return ResColors.app_main;
      case "pdf":
        return ResColors.material_red_400;
      default:
        return ResColors.app_main;
    }
  }else{
    return ResColors.app_main;
  }
}

///
/// 获取链接后缀名称
///
String getEndNameByUrl(String url){
  if(null!=url && url.contains(".") && url.contains("/")){
    List split = url.split("/");
    return split[split.length-1];
  }
  return "无";
}

///
/// 获取唯一设备地址
///
Future<String> getDeviceIdPath() async{
  bool hasWrite = await checkAndRequestWritePermission();
  if(!hasWrite) return "";
  Directory directory = await getExternalStorageDirectory();
  String sdPath = directory.path;
  if(sdPath.contains("data")){
    List<String> lists = sdPath.split("data");
    String path = "${lists[0]}yc_project_device_id/";
    await existPathAndCreate(path);
    return path;
  }else{
    return directory.path;
  }
}

///
/// 获取数据库地址
///
Future<String> getDbParentPath() async{
  bool hasWrite = await checkAndRequestWritePermission();
  if(!hasWrite) return "";
  Directory directory = await getExternalStorageDirectory();
  String sdPath = directory.path;
  if(sdPath.contains("data")){
    List<String> lists = sdPath.split("data");
    String path = "${lists[0]}yc_project_db_file/";
    await existPathAndCreate(path);
    return path;
  }else{
    return directory.path;
  }
}

///
/// 获取安装包地址
///
Future<String> getApkParentPath() async{
  bool hasWrite = await checkAndRequestWritePermission();
  if(!hasWrite) return "";
  Directory directory = await getExternalStorageDirectory();
  String sdPath = directory.path;
  if(sdPath.contains("data")){
    List<String> lists = sdPath.split("data");
    String path = "${lists[0]}yc_project_apk_file/";
    await existPathAndCreate(path);
    return path;
  }else{
    return directory.path;
  }
}

///
/// 校验文件夹是否存在，不存在创建
///
existPathAndCreate(String path) async{
  if(!Directory(path).existsSync()){
    await Directory(path).create();
  }
}

///
/// 请求链接拼接非空参数
///
class ParamBuilder{

  ParamBuilder paramBuilder;
  String url;

  ParamBuilder(this.url){
    this.url = url;
    paramBuilder = this;
  }

  ParamBuilder addParameter(String paramKey,Object paramValue){
    if(null!=paramValue && ""!=paramValue){
      url+="&$paramKey=$paramValue";
    }
    return paramBuilder;
  }

  String builder(){
    return url;
  }
}

String getTimeDifferenceByStr(String time) {
  return getTimeDifference(DateTime.parse(time),time);
}

String getTimeDifference(DateTime time,String oldTime) {
  int difference =
      (DateTime.now().millisecondsSinceEpoch - time.millisecondsSinceEpoch) ~/
          1000;

  const int secondPerDay = 60 * 60 * 24; // 一天有多少秒

  String hour = (time.hour < 10 ? "0" : "") + time.hour.toString();
  String minute = (time.minute < 10 ? "0" : "") + time.minute.toString();

  if (difference <= 0) {
    return oldTime;
  }
  if (difference ~/ secondPerDay > 0) {
    if (difference ~/ secondPerDay == 2) return "前天 " + hour + ":" + minute;
    if (difference ~/ secondPerDay == 1) return "昨天 " + hour + ":" + minute;
    return oldTime;
  } else {
    return "今天 " + hour + ":" + minute;
  }
}

isNull(dynamic value){
  if(null!=value && ""!=value && "null"!=value)
    return false;
  else
    return true;
}

isNullList(List list){
  if(null!=list && list.length >0){
    return false;
  }else{
    return true;
  }
}
///
/// 截取固定长度文本其他...
///
interceptFixedLengthTextOther(String text,int maxLength){
  if(null!=text && text.length > maxLength){
    return "${text.substring(0,maxLength)}...";
  }else{
    return text;
  }
}