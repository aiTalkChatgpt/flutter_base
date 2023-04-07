import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_html/flutter_html.dart';

import '../base_function.dart';
import 'my_app_bar.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2021/7/12 11:11 AM
///     desc   : 
///     version: v1.0
/// </pre>
///
class HtmlPage extends StatelessWidget{

  String content;

  HtmlPage(this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _buildAppBar(context),
      body: null==content || ""==content ? Center(child: Text("暂无数据"),) :
      SingleChildScrollView(
        child: Html(data: content),
      )
    );
  }

  _buildAppBar(BuildContext context) {
    return MyAppBar(
      backgroundColor: BaseConstants.getAppMainColor(context),
      title: new Text(
        "详情",
        style: new TextStyle(color: ResColors.white, fontSize: 16),
      ),
      centerTitle: true,
      elevation: 4,
    );
  }
}