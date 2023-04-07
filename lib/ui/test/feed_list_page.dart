import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/upload/update_apk.dart';
import 'package:flutter_base/entry/feed_list_bean.dart';
import 'package:flutter_base/provide/TestProvider.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:provider/provider.dart';

///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 2/17/22 4:23 PM
///     desc   : 
///     version: v1.0
/// </pre>
///
// ignore: must_be_immutable
class FeedListPage extends StatefulWidget{

  bool isShowBar;

  FeedListPage({this.isShowBar});

  @override
  State<StatefulWidget> createState() {
    return FeedListState(isShowBar);
  }
}
class FeedListState extends ListViewState<FeedListPage>{

  TestBaseProvider _provider;
  bool isShowBar;

  FeedListState(this.isShowBar);

  @override
  void initState() {
    super.initState();
    if(null == isShowBar)
      isShowBar  =true;
  }

  @override
  Color backgroundColor() {
    return ResColors.white;
  }

  @override
  List buildList() {
    List<FeedListBean> list = Provider.of<TestBaseProvider>(context).feedList ?? [];
    return list;
  }

  @override
  Widget buildListItemView(Object object, int index) {
    FeedListBean bean = object;
    switch(bean.type){
      case "1" :
        return Column(children: [
          Gaps.vGap10,
          buildWorkCardView(context,bean.bean,radius: 10.0)
        ],);
      case "2":
        return Column(children: [
          Gaps.vGap10,
          buildNewsCardView(context,bean.bean,radius: 10.0)
        ],);
      case "3":
        return Column(children: [
          Gaps.vGap10,
          buildNewsRightImageCardView(context,bean.bean,radius: 10.0)
        ],);
    }
    return Column(children: [
      Gaps.vGap10,
      buildWorkCardView(context,bean.bean,radius: 10.0)
    ],);
  }

  @override
  getDataByNet(bool isRefresh, int page, int size) {
    _provider.getFeedList(isRefresh);
  }

  @override
  String getTitle() {
    return isShowBar ?"Feed流" : "";
  }

  @override
  initProvider(BuildContext context) {
    _provider = Provider.of<TestBaseProvider>(context);
  }

  @override
  bool isUsePage() {
    return true;
  }

}

enum ListType{
  user_content_approve,

}