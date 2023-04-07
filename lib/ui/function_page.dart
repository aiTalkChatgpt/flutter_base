import 'dart:collection';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseRouter.dart';
import 'package:flutter_base/common/api/BaseApi.dart';
import 'package:flutter_base/common/app.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/permission_ktx.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/common/base/widget/my_app_bar.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/base/widget/webview_page.dart';
import 'package:flutter_base/common/export.dart';
import 'package:flutter_base/common/global_config.dart';
import 'package:flutter_base/entry/home_menu_bean.dart';
import 'package:flutter_base/export.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/res/res_font.dart';
import 'package:flutter_calendar/main.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

///
/// 多菜单按钮主页
///
// ignore: must_be_immutable
class FunctionPage extends StatefulWidget {
  static const routeName = '/dashboard';

  @override
  _FunctionPageState createState() => _FunctionPageState();
}

class _FunctionPageState extends State<FunctionPage>
    with AutomaticKeepAliveClientMixin {


  DateTime _lastPressedAt; // 上次点击时间验收
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    printLog("emptyLog_build进来了------>");
    checkAndRequestWritePermission(isAutoIntoSetting: false);
    BaseGlobalConfig.init(context,isInitWeather: true);
    printLog("emptyLog_BaseGlobalConfig.init走完了------>");
    App.context = context;
    return Material(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: ResColors.gray_f1,
          appBar: _buildAppBar(),
          body: _buildNewChildView(),
        ),
      ),
    );
  }

  ///
  /// 图标菜单
  ///
  Widget _buildIconMenuLayout(){
    return Container(
      color: ResColors.white,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListViewDivider(),
        _buildTitleView(title: "生活小助手"),
        _buildMenuLayout(),
        _buildListViewDivider(),],
    ),);
  }

  /// 菜单整体布局
  ///
  Widget _buildMenuLayout(){

    List<Widget> menus1 = [];
    menus1.add(_buildMenuView("疫情",getImgPath("ic_yqfw",isBaseModuleRun: false),"https://voice.baidu.com/act/newpneumonia/newpneumonia/?from=osari_aladin_banner",iconWidth: 35.0));
    menus1.add(_buildMenuView("天气",getImgPath("ic_weather",isBaseModuleRun: false),"https://weathernew.pae.baidu.com/weathernew/pc?query=%E5%8C%97%E4%BA%AC%E5%A4%A9%E6%B0%94&srcid=4982"));
    menus1.add(_buildMenuView("计算器",getImgPath("ic_jsq",isBaseModuleRun: false),"http://cal.apple886.com/"));
    menus1.add(_buildMenuView("日历",getImgPath("ic_jsb_1",isBaseModuleRun: false),BaseRouter.fullCalendarPage,isPageRouter: true));
    menus1.add(_buildMenuView("添加",getImgPath("ic_add_round_blue_less",isBaseModuleRun: false),null,iconWidth: 35.0));


    return Container(
      height: ((menus1.length / 4).ceil() * 90 + 20).toDouble(),
      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
      child:   GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: 3.0,
          vertical: 10,
        ),
        childAspectRatio: .9,
        // crossAxisSpacing: 5,
        crossAxisCount: 4,
        children: menus1,
      ),
    );
  }

  ///
  /// 单个图标布局
  ///
  Widget _buildMenuView(String label,String icon,String path,{double iconWidth = 40.0,bool isPageRouter = false}){
    return Expanded(
      child: InkWell(
        onTap: (){
          navigateTo(context,isPageRouter ? null :WebViewPage(path) , path: isPageRouter?path : "");
        },
        child: Column(
          children: <Widget>[
            Container(
              width: 60.0,
              height: 60.0,
              alignment: Alignment.center,
              child: Image.asset(
                icon,
                width: iconWidth,
                height: iconWidth,
                errorBuilder: (c,e,s){
                  return Image.asset(
                    getImgPath("ic_default_menu"),
                    width: 40,
                    height: 40,
                  );
                },
              ),
            ),
            textStyle(label,color: ResColors.black_34,fontSize: 11.0)
          ],
        ),
      ),
    );
  }

  ///
  /// 标题文案
  ///
  Widget _buildTitleView({String title = "测试标题"}){
    return Container(
      margin: EdgeInsets.only(left: 10,top: 15,bottom: 0),
      child: textStyle(title,fontSize: ResSize.text_17,fontWeight:FontWeight.bold,isTextAlignLeft: true),);
  }
  ///
  /// 分割线
  ///
  _buildListViewDivider() {
    return Container(
      color: ResColors.gray_f1,
      height: 10,
      margin: EdgeInsets.only(top: 10),
    );
  }

  _buildNewChildView() {
    printLog("emptyLog__buildNewChildView进来了------>");
    List<Widget> parentWidgets = [
      _buildParentItem(Data(menuList: [
        MenuList(menuIcon: "",menuName: "feed流",routerUrl: BaseRouter.feedList),
        MenuList(menuIcon: "",menuName: "tab切换页面",routerUrl: BaseRouter.tabPage),
        MenuList(menuIcon: "",menuName: "数据库",routerUrl: BaseRouter.dbPage),
        MenuList(menuIcon: "",menuName: "天气",routerUrl: BaseRouter.weatherPage),
        MenuList(menuIcon: "",menuName: "打印机测试",routerUrl: BaseRouter.printerPage),
        MenuList(menuIcon: "",menuName: "设备唯一Id",routerUrl: BaseRouter.deviceIdPage),
        MenuList(menuIcon: "",menuName: "扫码",routerUrl: BaseRouter.scanCodePage),
        MenuList(menuIcon: "",menuName: "天气网格布局",routerUrl: BaseRouter.weatherGridViewWidget),
        MenuList(menuIcon: "",menuName: "测试用例",routerUrl: BaseRouter.testSamplePage),
      ],menuParentTitle: "测试用例")),

      _buildIconMenuLayout()
    ];

    printLog("emptyLog__buildNewChildView进来了------>");

//    homeMenu.data.forEach((element) {
//      parentWidgets.add(_buildParentItem(element));
//    });

    return SingleChildScrollView(
      child: Column(
        children: parentWidgets,
      ),
    );
  }

  Widget _buildParentItem(Data element) {
    List<Widget> menus = [];
    if (null != element && null != element.menuList) {
      menus.clear();
      element.menuList.forEach((element) {
        if (null == element) return;
        menus.add(_buildButton(
            icon: element.menuIcon != null
                ? BaseApi.baseImgUrl + element.menuIcon
                : null,
            label: element.menuName,
            routerUrl: element.routerUrl
        ));
      });
    }

    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        Container(
          height: ((menus.length / 4).ceil() * 105 + 30).toDouble(),
          padding: EdgeInsets.all(10),
          color: ResColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: textStyle(element.menuParentTitle,fontSize: ResSize.text_17,
                    textAlign: TextAlign.left, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 3.0,
                    vertical: 10,
                  ),
                  childAspectRatio: .9,
                  // crossAxisSpacing: 5,
                  crossAxisCount: 4,
                  children: menus,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }


  ///
  /// 按钮菜单
  ///
  Widget _buildButton(
      {String icon, String label, int count = 0, String routerUrl = ""}) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            Map<String, String> map = HashMap();
            map["function"] = "function_page";
            navigateTo(context, null, path: routerUrl,params: map);
          },
          child: Column(
            children: <Widget>[
              Container(
                width: 60.0,
                height: 60.0,
                alignment: Alignment.center,
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (c,e,s){
                    return Image.asset(
                      getImgPath("ic_default_menu"),
                      width: 40,
                      height: 40,
                    );
                  },
                  placeholder: getImgPath("ic_default_menu"),
                  fit: BoxFit.fill,
                  image: icon ?? "",
                  width: 30.0,
                  height: 30.0,
                ),
              ),
              textStyle(label, color: ResColors.black_34, fontSize: 11.0)
            ],
          ),
        ),
        Visibility(
          visible: count > 0,
          child: Positioned(
            top: 15,
            right: 15,
            child: Container(
              width: w(32),
              height: h(32),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ResColors.app_main, shape: BoxShape.circle),
              child: Text(
                count.toString(),
                style: TextStyle(
                    color: ResColors.white,
                    fontSize: sp(18),
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }

  _buildAppBar() {//logoTag
    return MyAppBar(
      backgroundColor: BaseConstants.getAppMainColor(context),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "方  舱",
            style: new TextStyle(color: ResColors.white, fontSize: 16),
          ),
//          _buildBottomVersion()
        ],
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  _buildBottomVersion() {
//    return FutureState(
//      future: PackageInfo.fromPlatform(),
//      successBuilder: (context, data) {
//        return Container(
//          padding: EdgeInsets.only(top: 5, bottom: 5,left: 5),
//          child: Text(
//            "v${data.data.version}",
//            style: TextStyle(color: ResColors.white, fontSize: sp(20)),
//          ),
//        );
//      },
//    );
  }
  ///
  /// 监听返回键，点击两下退出程序
  ///
  Future<bool> _onBackPressed() async {
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 2)) {
      print("点击时间");
      //两次点击间隔超过2秒则重新计时
      _lastPressedAt = DateTime.now();
      show("再按一次退出");
      return false;
    }
//    _timer.cancel();
    return true;
  }

  @override
  bool get wantKeepAlive => true;
}
