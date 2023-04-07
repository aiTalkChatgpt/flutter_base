import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/form/form-item.dart';
import 'package:flutter_base/common/base/form/select_form_item.dart';
import 'package:flutter_base/common/base/form/time_form_item.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/entry/key_value.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 4/8/22 9:52 AM
///     desc   : 公共查询页面
///     version: v1.0
/// </pre>
///
// ignore: must_be_immutable
class BaseQueryPage extends StatefulWidget{

  Function backFunction;
  Map<String,QueryCommonBean> queryMap;

  BaseQueryPage(this.queryMap, this.backFunction);

  @override
  State<StatefulWidget> createState() {
    return BaseQueryPageState(queryMap,backFunction);
  }

}
class BaseQueryPageState extends AppBarViewState<BaseQueryPage>{

  Function backFunction;
  Map<String,QueryCommonBean> queryMap;

  BaseQueryPageState(this.queryMap, this.backFunction);


  List<Widget> widgets = [];

  @override
  Widget buildBody() {
    widgets.clear();
    queryMap.forEach((key,value) {
      //0输入 1选择 2时间
      switch(value.type){
        case "input":
          widgets.add(_buildInputView(value));
          break;
        case "select":
          widgets.add(_buildOptionView(value));
          break;
        case "time":
          widgets.add(_buildTimePickerView(value));
          break;
      }
    });

    return Column(children: widgets,);
  }

  bool isTimeRange = false;
  String startTime = "";
  String startTile = "";
  String endTime = "";
  String endTile = "";

  @override
  Function onClickAppBarRightButton() {

    return (){
      if(null!=backFunction){
        queryMap.forEach((key,element) {
          //0输入 1选择 2时间
          switch(element.type){
            case "input":
              element.result = element.textController.text;
              break;
            case "time":
              if(null!=element.isTimeRange && element.isTimeRange)
                isTimeRange = true;
              if(element.title.contains("开始")||element.title.contains("发起")){
                startTime = element.result ?? "";
                startTile = element.title;
              }
              else if(element.title.contains("结束")||element.title.contains("终止")){
                endTime = element.result ?? "";
                endTile = element.title;
              }
              break;
          }
          printLog("key:$key,element:${element.result}");
        });
        //时间范围 选择一个时间 必须选择另外一个时间
        printLog("$isTimeRange,$startTime,$endTime");
        if(isTimeRange &&((startTime!="" && endTime=="")|| (startTime=="" && endTime!="")) ){
          if(startTime ==""){
            show("请选择$startTile");
          }else if(endTime==""){
            show("请选择$endTile");
          }
          return;
        }
        backFunction(queryMap);
        pop(context);
      }
    };
  }


  _buildInputView(QueryCommonBean bean){
    return FormItemWidget(
      keyboardType:null!=bean.keyboardType?bean.keyboardType:TextInputType.multiline,
      label: '${bean.title}：',
      controller: bean.textController,
      hintText: '请输入${bean.title}',
    );
  }


  _buildOptionView(QueryCommonBean bean){
    return SelectFormItemWidget(
      label: '${bean.title}：',
      options: bean.options,
      value: bean.result,
      hintText: '请选择${bean.title}',
      onChanged: (v) {
        setState(() {
          queryMap.forEach((key,element) {
            if(element.title == bean.title){
              element.result = v;
            }
          });
        });
      },
    );
  }

  _buildTimePickerView(QueryCommonBean bean) {
    return TimeFormItemWidget(
      label: '${bean.title}：',
      value: bean.result,
      hintText: '请选择${bean.title}',
      onChanged: (v) {
        setState(() {
          queryMap.forEach((key,element) {
            if(element.title == bean.title){
              element.result = v;
            }
          });
        });
      },
    );
  }


  @override
  String getTitle() {
    return "查询";
  }



  @override
  String getAppBarRightButtonText() {
    return "确定";
  }
}

class QueryCommonBean{
  String title;//描述
  String type;//input输入 select选择 time时间
  String result;//选择结果
  TextInputType keyboardType;//输入内容类型
  TextEditingController textController = new TextEditingController(text: "");
  List<KeyValue> options = [];
  bool isTimeRange = false;//是否是时间范围 选了开始时间必须选择结束时间

  QueryCommonBean(this.title, this.type,{this.options,this.keyboardType,this.isTimeRange});
}

getQueryCommonResult(String key,Map<String,QueryCommonBean> queryMap){
  if(null!=queryMap && queryMap.containsKey(key))
    return queryMap[key].result;
  else
    return "";
}