import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/permission_ktx.dart';

import 'feed_list_page.dart';


///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2021/12/14 11:07 AM
///     desc   :
///     version: v1.0
/// </pre>
///
// ignore: must_be_immutable
class TabPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return TabPageState();
  }

}
class TabPageState extends TabState<TabPage>{

  @override
  void initState() {
    super.initState();
  }

  @override
  List<Widget> buildFragments() {
    return [
      FeedListPage(isShowBar: false),
      FeedListPage(isShowBar: false),
    ];
  }

  @override
  List<String> buildTabs() {
    return ["待审核","已审核"];
  }

  @override
  String getTitle() {
    return "审批";
  }

}