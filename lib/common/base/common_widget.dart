import 'dart:ffi';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/form/multi_select_form_item.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/common/ui/base_signature_page.dart';
import 'package:flutter_base/entry/key_value.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/res/res_font.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../BaseConstants.dart';
import '../global_config.dart';
import 'base_function.dart';
import 'form/form-item.dart';
import 'form/select_form_item.dart';
import 'widget/my_app_bar.dart';

import 'package:bruno/bruno.dart';

///
/// 通用的widget
///
///
/// ShapeBorder: 类的使用
///   - BeveledRectangleBorder 扁平或“斜角”角的矩形边框
///   - CircleBorder 可用空间内适合圆的边界
///   - StadiumBorder 半圆角矩形（StadiumBorder 翻译：像体育场形状的边框）

Widget labTab(String text, {String labText}) {
  if (labText != null && labText.isNotEmpty) {
    return Tab(
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: ResColors.red_e2),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  labText,
                  style: TextStyle(color: ResColors.white, fontSize: 10),
                ),
              ),
            ),
          ),
          Center(child: Text(text)),
        ],
      ),
    );
  }
  return Tab(text: text);
}

/// 底部扫码通用布局
/// 该布局包含: (左侧: [二维码扫码] + 中间: [条码输入框] + 右侧: [提交按钮])
Widget scanBottomWidget(var onSubmit, var onSubmitByKeyboard, var onOpenCamera,
    TextEditingController inputController, var _commentFocus,
    {String submitText = "提交本次扫入"}) {
  return Container(
    height: 50,
    color: Colors.white,
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: Icon(
            CupertinoIcons.photo_camera,
            size: 32,
          ),
          onPressed: onOpenCamera,
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
            decoration: BoxDecoration(
              color: ResColors.gray_light,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              focusNode: _commentFocus,
              autofocus: true,
              controller: inputController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              onSubmitted: (text) {
                onSubmitByKeyboard(text);
              },
              onChanged: (text) {
                if (text.contains("\n")) {
                  onSubmitByKeyboard(text);
                }
              },
            ),
          ),
        ),
        RoundedButton(
          text: submitText,
          onTap: () {
            onSubmit(inputController.text);
          },
        )
      ],
    ),
  );
}

/// AppBar 附带右侧文字按钮
class AppBarWithRightBtn extends AppBar {
  final VoidCallback onPressed;
  final String btnText;
  final String titleText;

  AppBarWithRightBtn({this.onPressed, this.btnText = '', this.titleText = ''})
      : super(
    actions: <Widget>[
      FlatButton(
        textColor: Colors.white,
        child: Text(btnText),
        onPressed: btnText.isEmpty ? null : onPressed,
      )
    ],
    centerTitle: true,
    title: Text(titleText),
    backgroundColor: ResColors.app_main,
  );
}

/// AppBar 仅文字
class AppBarOnlyTitle extends AppBar {
  final String titleText;

  AppBarOnlyTitle(this.titleText)
      : super(
    centerTitle: true,
    title: Text(
      titleText,
      style: TextStyle(color: ResColors.white),
    ),
    backgroundColor: ResColors.red_fe,
  );
}

/// 圆角按钮
/// 已经废弃
///
class RoundedButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap; //点击事件
  final double width;

  RoundedButton({this.text = '确定', this.width = 100, this.onTap});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: ResColors.app_main,
      textColor: Colors.white,
      highlightColor: Theme
          .of(context)
          .primaryColorLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      // 阴影
      elevation: 2,
      // 按下时的阴影
      highlightElevation: 8,
      // 禁用时的阴影
      disabledElevation: 0,
      child: Container(alignment: Alignment.center,
          width: width,
          height: 35,
          child: Text(text)),
      onPressed: onTap,
    );
  }
}

/// 圆角按钮
/// 目前使用
///
// ignore: must_be_immutable
class RoundedDivButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap; //点击事件
  final double width;
  final double height;
  final double fontSize;
  final double radius;
  final Color backgroundColor;
  final Color textColor;
  final bool disabled;

  RoundedDivButton(this.text,
      {this.width = 100,
        this.height = 60,
        this.fontSize = 30,
        this.onTap,
        this.backgroundColor,
        this.textColor = ResColors.white,
        this.disabled = false, this.radius = 20.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h(height),
      width: w(width + 20),
      child: RaisedButton(
        color: backgroundColor ?? BaseConstants.getAppMainColor(context),
        textColor: textColor,
        highlightColor: ResColors.gray_f1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius)),
        // 阴影
        elevation: 2,
        // 按下时的阴影
        highlightElevation: 8,
        // 禁用时的阴影
        disabledElevation: 0,
        disabledColor: backgroundColor?? BaseConstants.getAppMainColor(context).withOpacity(0.5),
        disabledTextColor: textColor,
        child: Text(
          text,
          style: TextStyle(fontSize: sp(fontSize)),
        ),
        onPressed: disabled ? null : onTap,
      ),
    );
  }
}

/// 圆环按钮
class CircularButton extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap; //点击事件
  final double width;
  final double height;
  final double fontSize;
  final Key key;
  final bool disabled;

  /// 是否计算宽高
  final bool useDP;

  CircularButton({
    this.text = '确定',
    this.onTap,
    this.key,
    this.useDP = false,
    this.width = 150,
    this.height = 60,
    this.fontSize = ResSize.text_default,
    this.disabled = false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: useDP ? height : (height == null ? null : h(height)),
      width: useDP ? width : (width == null ? null : w(width + 20)),
      child: RaisedButton(
        key: key,
        color: Colors.white,
        textColor: disabled ? ResColors.gray_99 : ResColors.app_main,
        highlightColor: Theme
            .of(context)
            .primaryColorLight,
        shape: new StadiumBorder(
            side: new BorderSide(
              style: BorderStyle.solid,
              color: disabled ? ResColors.gray_99 : ResColors.app_main,
            )),
        // 阴影
        elevation: 2,
        // 按下时的阴影
        highlightElevation: 8,
        // 禁用时的阴影
        disabledElevation: 0,
        disabledColor: ResColors.white,
        disabledTextColor: ResColors.gray_99,
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
        ),
        onPressed: disabled ? null : onTap,
      ),
    );
  }
}

class RefreshFooter extends ClassicalFooter {
  RefreshFooter()
      : super(
      loadText: "上拉加载",
      loadReadyText: "释放加载",
      loadingText: "正在加载…",
      loadedText: "加载完成",
      loadFailedText: "加载失败",
      noMoreText: "没有更多了",
      infoText: "更新时间为%T",
      infoColor: ResColors.black
  );
}

class RefreshHeader extends ClassicalHeader {
  RefreshHeader()
      : super(
    refreshText: "下拉刷新",
    refreshReadyText: "松开刷新",
    refreshingText: "正在刷新中...",
    refreshedText: "刷新完成",
    refreshFailedText: "刷新失败",
    noMoreText: "没有更多了",
    infoColor: ResColors.black,
    textColor: ResColors.black,
    infoText: "更新时间为%T",
  );
}


Decoration bottomGrayBorder = BoxDecoration(
  border: Border(bottom: BorderSide(width: 1, color: ResColors.gray)),
);

Decoration topGrayBorder = BoxDecoration(
  border: Border(top: BorderSide(width: 1, color: ResColors.gray)),
);

Decoration rightGrayBorder = BoxDecoration(
  border: Border(right: BorderSide(width: 1, color: ResColors.gray)),
);

Decoration leftGrayBorder = BoxDecoration(
  border: Border(left: BorderSide(width: 1, color: ResColors.gray)),
);

Decoration getDecoration(
    {double mLeft = 0, double mTop = 0, double mRight = 0, double mBottom = 0}) {
  return BoxDecoration(
    border: Border(
        left: BorderSide(width: mLeft, color: ResColors.gray),
        top: BorderSide(width: mTop, color: ResColors.gray),
        right: BorderSide(width: mRight, color: ResColors.gray),
        bottom: BorderSide(width: mBottom, color: ResColors.gray)),
  );
}

Image imgDefault = Image(
  image: AssetImage("images/default_image.png"),
  fit: BoxFit.fill,
);

class GradientRedButton extends StatelessWidget {
  final _name;
  final double width;
  final double height;
  final Color startColor; //渐变开始颜色
  final Color endColor; //渐变结束颜色
  final double fontSize; //内容文字大小
  final GestureTapCallback onTap; //点击事件
  final Color textColor; // 内容文字颜色
  final bool showBoxShadow; // 是否显示阴影

  GradientRedButton(this._name,
      {this.width = screenWidth - 32,
        this.height = 60,
        this.startColor = ResColors.red_fe,
        this.endColor = ResColors.red_e2,
        this.fontSize = 32,
        this.textColor = Colors.white,
        this.showBoxShadow = true,
        this.onTap})
      : super();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
          //背景渐变
          gradient: LinearGradient(colors: [startColor, endColor]),
          //圆角
          borderRadius: BorderRadius.circular(44),
          //阴影
          boxShadow: showBoxShadow
              ? [
            BoxShadow(
                color: ResColors.text_dark,
                offset: Offset(1.0, 1.0),
                blurRadius: 2.0)
          ]
              : [],
        ),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: w(width),
            height: h(height),
            alignment: Alignment.center,
            child: Text(
              _name,
              style: TextStyle(
                color: textColor,
                fontSize: sp(fontSize),
              ),
            ),
          ),
        ));
  }
}

class buildStatusView extends StatelessWidget {

  String statusText;
  Color statusBgColor;
  double right;
  String status;

  buildStatusView(this.statusText, this.statusBgColor, {this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      padding: EdgeInsets.only(
          left: 10, right: 10, top: 3, bottom: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          color: statusBgColor),
      child: textStyle(statusText,
          color: ResColors.white, fontSize: 12.0),
    );
  }
}

///
/// 角标 根据状态自动转换颜色
///
// ignore: must_be_immutable, camel_case_types
class buildStatusViewV2 extends StatelessWidget {

  String statusText;
  String status;
  Color statusBgColor = ResColors.material_deepPurple_100;
  Color statusTextColor = ResColors.white;

  buildStatusViewV2(this.statusText, this.status);

  getColorByStatus() {
    switch (status) {
      case "purple" :
        statusBgColor = ResColors.material_deepPurple_50;
        statusTextColor = ResColors.material_deepPurple_600;
        return;
      case "red" :
        statusBgColor = ResColors.material_red_50;
        statusTextColor = ResColors.material_red_600;
        return;
      case "green" :
        statusBgColor = ResColors.material_green_50;
        statusTextColor = ResColors.material_green_600;
        return;
      case "blue" :
        statusBgColor = ResColors.material_blue_50;
        statusTextColor = ResColors.material_blue_600;
        return;
      case "brown" :
        statusBgColor = ResColors.material_brown_50;
        statusTextColor = ResColors.material_brown_600;
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    getColorByStatus();
    return Container(
      constraints: BoxConstraints(maxWidth: 110),
      margin: EdgeInsets.only(left: 5),
      padding: EdgeInsets.only(
          left: 10, right: 10, top: 3, bottom: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20)),
          color: statusBgColor),
      child: textStyle(statusText,
          maxLines: 1,
          color: statusTextColor, fontSize: 12.0),
    );
  }
}



// 审批状态
//1-已提交，2-本机构领导审批通过，3-本机构领导审批不通过，4-供应机构领导审批，5-供应机构领导审批不通过，6-供应机构仓管审批通过，7-供应机构仓管审批不通过
////8-供应机构仓管提交物流单号， 9-申请方确认入库
getAuditStatusName(String status){
  switch(status){
    case "1":
      return "已提交";
    case "2":
      return "本机构领导审批通过";
    case "3":
      return "本机构领导审批不通过";
    case "4":
      return "供应机构领导审批";
    case "5":
      return "供应机构领导审批不通过";
    case "6":
      return "供应机构仓管审批通过";
    case "7":
      return "供应机构仓管审批不通过";
    case "8":
      return "供应机构仓管提交物流单号";
    case "9":
      return "申请方确认入库";
    default:
      return '-';
  }
}
getAuditStatusShortColor(String status) {
  switch (status) {
    case "1":
      return "green";
    case "2":
      return "green";
    case "3":
      return "red";
    case "4":
      return "purple";
    case "5":
      return "red";
    case "6":
      return "green";
    case "7":
      return "red";
  }
  return "purple";
}


getTaskTypeName(String status){
  switch(status){
    case "1":
      return "紧急领用";
    case "2":
      return "正常领用";
    case "3":
      return " 临时资产";
    case "4":
      return "物资归还";
    case "5":
      return "资产借用";
    case "6":
      return "区域物资调拨";
    case "7":
      return "资产续借";
    case "8":
      return "资产调拨归还";
    default:
      return '-';
  }
}

getTaskTypeColor(String status){
  switch(status){
    case "1":
      return "green";
    case "2":
      return "purple";
    case "3":
      return " red";
    case "4":
      return "purple";
    case "5":
      return "green";
    case "6":
      return "red";
    case "7":
      return "green";
    case "8":
      return "purple";
    default:
      return 'purple';
  }
}

////1-已提交，2-本机构领导审批通过，3-本机构领导审批不通过，4-供应机构领导审批，5-供应机构领导审批不通过，6-供应机构仓管审批通过，7-供应机构仓管审批不通过
////8-供应机构仓管提交物流单号， 9-申请方确认入库
getAuditStatusShortName(String status){
  switch(status){
    case "1":
      return "已提交";
    case "2":
      return "通过";
    case "3":
      return "不通过";
    case "4":
      return "领导审批";
    case "5":
      return "不通过";
    case "6":
      return "通过";
    case "7":
      return "不通过";
    case "8":
      return "提交物流单号";
    case "9":
      return "申请方确认入库";
    default:
      return '-';
  }
}

///流程状态 0未提交  1已提交（负责人审核） 2 负责人审核不通过   3负责人审核通过（仓库待确认）4 仓库不通过  5 通过已完成
getStatusName(String status){
  switch(status){
    case "0":
      return "未提交";
    case "1":
      return "已提交";
    case "2":
      return "负责人审核不通过";
    case "3":
      return "负责人审核通过";
    case "4":
      return "仓库不通过";
    case "5":
      return "通过已完成";
  }
}
///流程状态 0未提交  1已提交（负责人审核） 2 负责人审核不通过   3负责人审核通过（仓库待确认）4 仓库不通过  5 通过已完成
getStatusColor(String status) {
  switch (status) {
    case "0":
      return "purple";
    case "1":
      return "green";
    case "2":
      return "red";
    case "3":
      return "blue";
    case "4":
      return "red";
    case "5":
      return "green";
  }
  return "purple";
}


buildCircleAvatar(String url,BuildContext context,{double width = 80.0}) {
  if (null!=url && ""!=url && "null"!=url) {
    return InkWell(
      onTap: (){
        openFileByUrl(context,url,isUseBaseUrl: false);
      },
      child: ClipOval(
        child: new FadeInImage.assetNetwork(
          imageErrorBuilder: (c,e,s){
            return Image.asset(
              getImgPath("icon_user_header_def"),
              width: width,
              height: width,
            );
          },
          placeholder: getImgPath("icon_user_header_def"),
          fit: BoxFit.cover,
          image: url,
          width: width,
          height: width,
        ),
      ),
    );
  } else {
    return Image.asset(
      getImgPath("icon_user_header_def"),
      width: width,
      height: width,
    );
  }
}

buildCircleAvatarNameView(BuildContext context,String url,String name) {
  if (null!=url && ""!=url && "null"!=url) {
    return InkWell(
      onTap: (){
        openFileByUrl(context,url,isUseBaseUrl: false);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        color: ResColors.app_main,
        child: Row(
          children: <Widget>[
            ClipOval(
              child: new FadeInImage.assetNetwork(
                imageErrorBuilder: (c,e,s){
                  return Image.asset(
                    getImgPath("icon_user_header_def"),
                    width: 60.0,
                    height: 60.0,
                  );
                },
                placeholder: getImgPath("icon_user_header_def"),
                fit: BoxFit.cover,
                image: url,
                width: 60.0,
                height: 60.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: textStyle(name,fontSize: ResSize.text_16,color: ResColors.white),
            )
          ],
        ),
      ),
    );
  } else {
    return Container(
      padding: EdgeInsets.all(10),
      color: ResColors.app_main,
      child: Row(
        children: <Widget>[
          Image.asset(
            getImgPath("icon_user_header_def"),
            width: 60,
            height: 60,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: textStyle(name,fontSize: ResSize.text_16,color: ResColors.white),
          )
        ],
      ),
    );
  }
}


buildAppBar(String title,BuildContext context) {
  return MyAppBar(
    backgroundColor: BaseConstants.getAppMainColor(context),
    title: new Text(
      title,
      style: new TextStyle(color: ResColors.white, fontSize: 16),
    ),
    centerTitle: true,
    elevation: 4,
  );
}

///
/// PDF WORD DOC预览布局
///
buildTextCardView(String text,Color bgColor){
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color:bgColor,
        borderRadius: BorderRadius.all(Radius.circular(10))),
    child: Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: textStyle(text,color: ResColors.white,fontSize: ResSize.text_20,fontWeight: FontWeight.bold),
    ),
  );
}


Widget buildInputFormView(String label,String hint,TextEditingController controller,{TextInputType keyboardType}){
  return  FormItemWidget(
    label: label,
    controller: controller,
    hintText: hint,
    keyboardType: keyboardType,
  );
}

Widget buildSelectFormView(String id,List<KeyValue> options,Function onChanged,String title,String hint){
  return SelectFormItemWidget(
    label: title,
    options: options,
    value: id,
    hintText: hint,
    onChanged: (v) {
      onChanged(v);
    },
  );
}

Widget buildMultiSelectFormView(List<KeyValue> options,Function onChanged,String title,String hint,List<dynamic> values){
  return MultiSelectFormItemWidget(
    label: title,
    options: options,
    value: values,
    hintText: hint,
    onChanged: (v) {
      onChanged(v);
    },
  );
}

///
/// 空状态
///
Widget buildEmptyView(){
  return Center(child: textStyle("暂无数据"),);
}

///
/// 重新加载布局
///buildReLoadView
Widget buildReLoadView(BuildContext context,Function reLoadNet){
  return BrnAbnormalStateWidget(
    img: Image.asset(
      'assets/images/3.0x/empty_data.png',
      scale: 3.0,
    ),
    isCenterVertical: true,
    title: BrnStrings.getDateFailed,
    operateTexts: <String>[BrnStrings.clickPageRetry],
//    operateAreaType: OperateAreaType.TextButton,
    action: (index) {
      reLoadNet();
    },
  );

}


buildNetImageView(String url,BuildContext context,{double imageWidth = 60.0,bool isIntoBigImagePage  = false,String defaultImg,Color imgBgColor}) {
  if (null!=url && ""!=url && "null"!=url) {
    return isIntoBigImagePage?GestureDetector(
      onTap: (){
        previewImage(context,url,bgColor: imgBgColor);
      },
      child: new FadeInImage.assetNetwork(
        imageErrorBuilder: (c,e,s){
          return Image.asset(
            getImgPath(defaultImg ?? "ic_add_empty"),
            width: imageWidth,
            height: imageWidth,
            fit:BoxFit.contain
          );
        },
        placeholder: getImgPath(defaultImg ?? "ic_add_empty"),
        fit: BoxFit.contain,
        image: url,
        width: imageWidth,
        height: imageWidth,
      ),
    ):new FadeInImage.assetNetwork(
      imageErrorBuilder: (c,e,s){
        return Image.asset(
          getImgPath(defaultImg ?? "ic_add_empty"),
          width: imageWidth,
          height: imageWidth,
          fit:BoxFit.contain
        );
      },
      placeholder: getImgPath(defaultImg ?? "ic_add_empty"),
      fit: BoxFit.contain,
      image: url,
      width: imageWidth,
      height: imageWidth,
    );

  } else {
    return Image.asset(
      getImgPath(defaultImg ?? "ic_add_empty"),
      width: imageWidth,
      height: imageWidth,
    );
  }
}

///
/// 切换tab
///
buildTabLBar(List tabList,BuildContext context,{TabController controller}){
  return Container(
    margin: EdgeInsets.only(top: 8,bottom: 8),
    height: 35,
    child: TabBar(
      labelColor: ResColors.color_333333,
      labelStyle: TextStyle(fontSize: ResSize.text_14,fontWeight: FontWeight.bold),
      isScrollable:true,
      indicatorWeight: 2.5,
      labelPadding: EdgeInsets.only(left: 10,right: 10),
      indicatorPadding: EdgeInsets.only(left: 20,right: 20,top: -10),
      unselectedLabelColor: ResColors.color_666666,
      unselectedLabelStyle: TextStyle(fontSize: ResSize.text_14),
      indicatorColor: BaseConstants.getAppMainColor(context),
      controller: controller,
      tabs: tabList.map((it) => Tab(text: it)).toList(),
    ),);
}

///
/// 手写签名
///
buildSignImageView(BuildContext context,{String signImagePath,bool isShowNetImage=false,Function backFunction}){
  return Container(
    height: 100,
    padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Container(
          width: 100.0,
          child: Text(
            "签名：",
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
        ),
        Expanded(
            child: InkWell(
              onTap: (){
                navigateTo(context, BaseSignaturePage((path){
                  if(null!=backFunction)
                    backFunction(path);
                }));
              },
              child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: _buildSignImageView(signImagePath,isShowNetImage),
              ),
            ),)),
      ],
    ),
  );
}
_buildSignImageView(String signImagePath,bool isShowNetImage){
  if(!isShowNetImage){
    return null!=signImagePath?Image.file(File(signImagePath)):Text(
      "请输入签名",
      style: TextStyle(fontSize: 14.0,color: ResColors.gray_99),
    );
  }else{
    return null!=signImagePath?Image.network(signImagePath,errorBuilder: (c,e,s){
      return textStyle("暂无手写签名");
    },):Text(
      "暂无手写签名",
      style: TextStyle(fontSize: 14.0,color: ResColors.gray_99),
    );
  }
}
