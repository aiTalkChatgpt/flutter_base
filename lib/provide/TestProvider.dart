import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/entry/feed_list_bean.dart';
import 'package:flutter_base/entry/key_value.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2021/4/22 6:07 PM
///     desc   : 测试类
///     version: v1.0
/// </pre>
///
class TestBaseProvider with ChangeNotifier{

  String image1 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.jj20.com%2Fup%2Fallimg%2F1111%2F06101Q10J2%2F1P610110J2-9.jpg&refer=http%3A%2F%2Fpic.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647915592&t=7d8c7af40340c6c234bbe944ac96a97f";
  String image2 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1111%2F03021Q40245%2F1P302140245-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647915921&t=7722b1d24e48a8eb85f6c0f6f10bf154";
  String image3 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F101520094J6%2F201015094J6-4-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647915943&t=fc2dfb8674573b76d2348db9d9b67d56";


  List<KeyValue> list = [];
  List<FeedListBean> feedList = [];
  List<KeyValue> tempList = [];

  getTestData(bool isRefresh) {
    if(isRefresh) list.clear();
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    list.add(KeyValue("key-${Random().nextInt(100).toString()}",
        "value-${Random().nextInt(100).toString()}"));
    notifyListeners();
  }

  getFeedList(bool isRefresh){
    List<MultiFileBean> fileUrls = [
      MultiFileBean(0,image1),
      MultiFileBean(0,image2),
      MultiFileBean(0,image3),
    ];
    if(isRefresh) feedList.clear();
    feedList.add(FeedListBean("3",feedBeanAddTestData(NewsFeedBean(true,true,fileUrls: [
      MultiFileBean(0,image3),
    ]))));
    feedList.add(FeedListBean("2",feedBeanAddTestData(NewsFeedBean(true,false,fileUrls:fileUrls))));
    feedList.add(FeedListBean("2",feedBeanAddTestData(NewsFeedBean(true,false,fileUrls:[
      MultiFileBean(0,image1),
      MultiFileBean(0,image2),
      MultiFileBean(1,image3),
    ]))));

    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(true,true,fileUrls:fileUrls))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(true,false,fileUrls:fileUrls))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(false,false,fileUrls:fileUrls))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(false,true,fileUrls:[]))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(false,false,fileUrls:[]))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(true,true,fileUrls: [
      MultiFileBean(0,image1),
      MultiFileBean(1,image2),
    ]))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(true,true,fileUrls: [
      MultiFileBean(0,image1),
      MultiFileBean(2,"/测试.doc"),
    ]))));
    feedList.add(FeedListBean("1",feedBeanAddTestData(BaseFeedBean(true,true,fileUrls: [
      MultiFileBean(2,"/测试.pdf"),
      MultiFileBean(2,"/测试.docx"),
    ]))));
    notifyListeners();
  }

  Future testNet(){
    Future.delayed(Duration(seconds: 2), () {
      return "";
    });
  }

  feedBeanAddTestData(BaseFeedBean feedBean){
    feedBean.title = "测试标题";
    feedBean.content = "测试内容";
    feedBean.name = "张三丰";
    feedBean.deptName = "测试工程科";
    feedBean.status = "1";
    feedBean.dateTime = "今天 9:30";
    return feedBean;
  }

}