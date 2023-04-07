import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/api/net_utils.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/global_config.dart';
import 'package:flutter_base/entry/key_value_back.dart';
import 'package:flutter_base/res/index_res.dart';
import 'package:flutter_base/ui/function_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';

import '../../app.dart';


///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 4/10/22 10:23 AM
///     desc   : 
///     version: v1.0
/// </pre>
///
class ToolPage extends StatefulWidget{

  String title;

  ToolPage(this.title);

  @override
  State<StatefulWidget> createState() {
    return ToolState(title);
  }

}
class ToolState extends AppBarViewState{

  List<Widget> widgets = [];
  String title;
  bool isPageWidgetHasValue;

  ToolState(this.title);

  @override
  Widget buildBody() {
    isPageWidgetHasValue = null!="${App.topStackWidget}" && ""!="${App.topStackWidget}" && "Widget"!="${App.topStackWidget}";
    NetUtils.netMap.forEach((key, value) {
      if(key.contains("${App.topStackWidget}"))
      widgets.add(buildNetCardView(value));
    });

    return SingleChildScrollView(child: Column(children: [
      Gaps.vGap10,
        buildCardWidgetView("页面", Column(children: [
          buildContentItemSingle("页面：", "${App.topStackWidget}"),
          buildContentItemSingle("名称：", "$title")
        ],)),
      buildDeviceView(),
      buildVersionView(),
      Column(children: widgets,),
      buildLogCardView()
    ],),);
  }

  buildNetCardView(NetBean netBean){
    return Column(children: [
      Gaps.vGap10,
      buildCardWidgetView("请求结果", Column(children: [
        buildContentItemSingle("请求地址：", "${BaseApi.BASE_URL+netBean.url}"),
        buildContentItemSingle("token:", "${netBean.token}",maxLines: 5),
        buildContentItemSingle("请求时间:", "${netBean.time}",maxLines: 5),
        if(null!=netBean.params)
        buildContentItemSingle("请求参数:", netBean.params,maxLines: 999),
        buildContentItemSingle("请求结果:", "",maxLines: 999),
        buildContentItemSingle("", "${netBean.response}",maxLines: 999,hintWidth: 0),
      ],))
    ],);
  }

  buildLogCardView(){
    List<Widget> logWidgets = [];
    logMap.forEach((key, value) {
      LogBean logBean = value;
      if(key.contains("${App.topStackWidget}"))
      logWidgets.add(
        Column(children: [
            buildContentItemSingle("$key:","",hintWidth: 300),
            if(null==logBean.tag || ""==logBean.tag)
            buildContentItemSingle("","${logBean.log}",hintWidth: 0),
            if(null!=logBean.tag && ""!=logBean.tag)
            buildContentItemSingle("","tag:${logBean.tag},log:${logBean.log}",maxLines: 999,hintWidth: 0),
        ],)
      );
    });
    return Column(children: [
      Gaps.vGap10,
      buildCardWidgetView("log信息", Column(children: logWidgets,))
    ],);
  }

  buildDeviceView(){
    MediaQueryData mq = MediaQuery.of(context);
    List<KeyValueBack> deviceLists = [];
    deviceLists.add(KeyValueBack("屏幕高度：", "${1.sh}"));
    deviceLists.add(KeyValueBack("屏幕宽度：", "${ScreenUtil().screenWidth}"));
    deviceLists.add(KeyValueBack("屏幕密度：", "${mq.devicePixelRatio}"));
    deviceLists.add(KeyValueBack("屏幕分辨率：", "${window.physicalSize.width}-${window.physicalSize.height}"));
    return Column(children: [
      Gaps.vGap10,
      buildTitleContentCard("设备信息", deviceLists)
    ],);
  }

  buildVersionView(){
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
        builder: (c,d){
          PackageInfo packageInfo = d.data as PackageInfo;
          List<KeyValueBack> deviceLists = [];
          deviceLists.add(KeyValueBack("版本号：", "${packageInfo.version}"));
          deviceLists.add(KeyValueBack("版本编号：", "${packageInfo.buildNumber}"));
      return Column(children: [
        Gaps.vGap10,
        buildTitleContentCard("版本信息", deviceLists)
      ],);
    });
  }

  @override
  String getTitle() {
    return "marspower-debug-tool";
  }

  @override
  Function onClickAppBarRightButton() {
    return (){
      navigateTo(context, FunctionPage());
    };
  }

  @override
  String getAppBarRightButtonText() {
    return BaseConstants.isDebug ? "方 舱" : "";
  }


  @override
  void dispose() {
    super.dispose();
    NetUtils.netMap.clear();
  }

}