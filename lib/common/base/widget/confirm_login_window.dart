import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/res/res_colors.dart';

import '../base_function.dart';
import '../common_widget.dart';
import '../text_ktx_widget.dart';

///
/// <pre>
///     author : SZYC
///     e-mail :
///     time   : 2020/11/30 2:08 PM
///     desc   : 确认框
///     version: v1.0
/// </pre>
///
// ignore: must_be_immutable
class ConfirmLoginWindow extends StatelessWidget {

  String hint = "确认提交";
  String content = "请确认是否执行该操作？";
  Function okBack;
  Function cancelBack;


  ConfirmLoginWindow(this.okBack,{this.cancelBack,this.hint, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h(350),
      width: w(200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: screenDpW,
            child: textStyle("提示"),
          ),
          Expanded(child: Padding(padding: EdgeInsets.only(top: 50),child: textStyle("登录已过期，请重新登录！",fontSize: 15.0),),),
          Container(
            width: screenDpW,
            padding: EdgeInsets.only(left: 20,right: 20),
            child: RoundedDivButton(
              "确  定",
              backgroundColor: BaseConstants.getAppMainColor(context),
              onTap: () {
                App.pop(context);
                okBack();
              },
              textColor: ResColors.white,
              height: 65,
              fontSize: 30,
            ),
          )
        ],
      ),
    );
  }
}
