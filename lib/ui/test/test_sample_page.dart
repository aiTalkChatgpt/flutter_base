import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/common_widget.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/common/base/widget/confirm_login_window.dart';
import 'package:flutter_base/export.dart';
import 'package:flutter_base/utils/dialog_utils.dart';
import 'package:flutter_base/utils/event_bus.dart';

///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 8/9/22 11:24 AM
///     desc   : 
///     version: v1.0
/// </pre>
///
class TestSamplePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TestSampleState();
  }

}
class TestSampleState extends AppBarViewState<TestSamplePage>{

  String name = "-";

  @override
  Widget buildBody() {
    EventBus.observer(TestSamplePage(),"name", (value){
      name = value;
      printLog("name:$name");
    });

    EventBus.observer(TestSamplePage(),"name", (value){
      name = value;
      printLog("name1:$name");
      setState(() {

      });
    });
    return Container(
      width: ScreenUtil().screenWidth,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gaps.vGap15,
        RoundedDivButton("显示登录超时弹框",width:500,onTap: (){
          DialogUtils.showWindow(context, ConfirmLoginWindow(() {

          }));
        },),
        Gaps.vGap15,
        RoundedDivButton("更新observer",width:500,onTap: (){
          EventBus.post(TestSamplePage(),"name", "张三丰");
        },),
        Gaps.vGap15,
        textStyle(name)
      ],),);
  }

  @override
  String getTitle() {
    return "测试用例";
  }

  @override
  void dispose() {
    super.dispose();
    EventBus.cancel(TestSamplePage());
  }

}