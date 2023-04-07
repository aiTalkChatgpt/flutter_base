import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_printer/common/printer_helper.dart';


///
/// <pre>
///     author : pengMaster
///     e-mail :
///     time   : 3/22/22 5:26 PM
///     desc   :
///     version: v1.0
/// </pre>
///
class PrinterPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return PrinterState();
  }
}
class PrinterState extends AppBarViewState{

  @override
  Widget buildBody() {
    return Column(children: [
      InkWell(
        onTap: (){
          PrinterHelper.startPrinter();
        },
        child: textStyle("开始打印"),
      )
    ],);
  }

  @override
  String getTitle() {
    return "打印机";
  }

}