import 'package:flutter/material.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../BaseConstants.dart';
import 'my_app_bar.dart';

///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 2021/7/12 11:11 AM
///     desc   : 
///     version: v1.0
/// </pre>
///
class WebViewPage extends StatelessWidget{

  String url;

  WebViewPage(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  _buildAppBar(context),
      body: null==url || ""==url ? Center(child: Text("暂无数据"),) :WebView(
        initialUrl: url ?? "",
        //JS执行模式 是否允许JS执行
        javascriptMode: JavascriptMode.unrestricted,
      ),
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