

import 'package:flutter/material.dart';
import 'package:flutter_base/entry/feed_list_bean.dart';

///common
///
/// <pre>
///     author : szyc
///     e-mail : szyc
///     time   : 2019/11/7 3:14 PM
///     desc   : 
///     version: 1.0
/// </pre>
///
class KeyValueBack{
   String key;
   dynamic value;
   Function onClickFunction;
   int maxLines = 3;
   Color valueColor;
   Color imgBgColor;
   List<MultiFileBean> files;

   KeyValueBack(this.key, this.value,{this.onClickFunction,this.maxLines,this.valueColor, this.files,this.imgBgColor});
}

