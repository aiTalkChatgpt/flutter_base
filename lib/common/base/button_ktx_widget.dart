import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/res/res_colors.dart';

import 'base_function.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2/22/22 8:06 PM
///     desc   : 按钮公共组件
///     version: v1.0
/// </pre>
///

buildWhiteRoundButton(String text,Function onClick,BuildContext context){
  return InkWell(
    onTap: (){
      onClick();
    },
    child: Container(
      margin: EdgeInsets.only(left: 5, top: 16, right: 5, bottom: 16),
      padding: EdgeInsets.only(left: 8, right: 8, bottom: 2),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: ResColors.white),
      child: Text(
        text,
        style: TextStyle(fontSize: 12, color: BaseConstants.getAppMainColor(context)),
      ),
    ),
  );
}