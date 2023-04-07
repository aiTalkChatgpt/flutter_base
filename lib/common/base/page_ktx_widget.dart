import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/common/base/widget/my_app_bar.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/upload/update_apk.dart';
import 'package:flutter_base/entry/feed_list_bean.dart';
import 'package:flutter_base/entry/key_value_back.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/res/res_font.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'base_function.dart';
import 'common_widget.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2/22/22 8:06 PM
///     desc   : 列表公共组件
///     version: v1.0
/// </pre>
///

///
/// 列表内容样式 单条整行
/// isVisible 是否显示
/// isBold    内容是否加粗
///
abstract class BaseStatelessWidget extends StatelessWidget {}

abstract class BaseStatefulWidget extends StatefulWidget {}

abstract class BaseState<T extends StatefulWidget> extends State {}

buildContentItemSingle(String hint, String content,
    {Color contentColor = ResColors.black, Color hintColor = ResColors.gray_99,
      padding: const EdgeInsets.only(left: 10, top: 10),
      bool isVisible = true, bool isBold = false, double fontSize, double hintWidth = 80.0,Function onClickBack,int maxLines = 3}) {
  bool isShowArrow = ""!=content && "无"!=content;
  return Visibility(
    visible: isVisible,
    child: null!=onClickBack ? InkWell(
      onTap: (){
        if(null!=onClickBack)
          onClickBack();
      },
      child: Container(
        width: ScreenUtil().screenWidth,
        padding: padding,
        child: Row(children: <Widget>[
          Container(
            width: hintWidth,
            child: textStyle(
              hint,
              fontSize: null!=fontSize?fontSize-1:ResSize.text_13,
              isTextAlignLeft: true,
              color: hintColor,
            ),),
          Expanded(child: Padding(
            padding: EdgeInsets.only(left: 10),
            child: textStyle(
                filterNull(content),
                fontSize: fontSize ?? ResSize.text_14,
                isTextAlignLeft: true,
                color: isShowArrow?ResColors.material_blue_500:contentColor,
                maxLines: maxLines,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal
            ),
          ),),
          if(isShowArrow)
            Container(
                margin: EdgeInsets.only(right: 10),
                width: 15,
                height: 15,
                child: Image(image: AssetImage(getImgPath("ic_arrow_right_blue"))))
        ],),
      ),
    ):Container(
      width: ScreenUtil().screenWidth,
      padding: padding,
      child: Row(children: <Widget>[
        Container(
          width: hintWidth,
          child: textStyle(
            hint,
            fontSize: null!=fontSize?fontSize-1:ResSize.text_13,
            isTextAlignLeft: true,
            color: hintColor,
          ),),
        Expanded(child: Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onLongPress: (){
              Clipboard.setData(ClipboardData(text: content));
              show("复制成功");
            },
            child: textStyle(
              filterNull(content),
              fontSize: fontSize ?? ResSize.text_14,
              isTextAlignLeft: true,
              maxLines: maxLines,
              color: contentColor,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal
          ),),
        ),)
      ],),
    ),
  );
}

///
/// 列表内容样式 单条整行
/// isVisible 是否显示
/// isBold    内容是否加粗
///
buildContentItemWhiteSingle(String hint, String content,
    {Color contentColor = ResColors.white, Color hintColor = ResColors.white,
      padding: const EdgeInsets.only(left: 10, top: 5),
      bool isVisible = true, bool isBold = false, double fontSize, double hintWidth = 80.0}) {
  return Visibility(
    visible: isVisible,
    child: Container(
      width: ScreenUtil().screenWidth,
      padding: padding,
      child: Row(children: <Widget>[
        Container(
          width: hintWidth,
          child: textStyle(
            hint,
            fontSize: fontSize ?? ResSize.text_14,
            isTextAlignLeft: true,
            color: hintColor,
          ),),
        Expanded(child: textStyle(
            filterNull(content),
            fontSize: fontSize ?? ResSize.text_14,
            isTextAlignLeft: true,
            color: contentColor,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal
        ),)
      ],),
    ),
  );
}
///
/// 列表内容样式 两条
/// isShowOne 第一条是否显示
/// isShowTwo 第二条是否显示
/// hintWidth 提示文字宽度
///
buildContentItemTwoRow(String hint, String content, String hint2,
    String content2,
    {Color contentColor = ResColors.black, padding: const EdgeInsets.only(
        left: 10, top: 5),
      bool isShowOne = true, bool isShowTwo = true, num hintWidth = 80.0}) {
  return Container(
    width: ScreenUtil().screenWidth,
    padding: padding,
    child: Row(
      children: <Widget>[
        Visibility(
          visible: isShowOne,
          child: Expanded(child: Row(children: <Widget>[
            Container(
              width: hintWidth,
              child: textStyle(
                hint,
                fontSize: ResSize.text_13,
                isTextAlignLeft: true,
                color: ResColors.gray_99,
              ),),
            Expanded(child: textStyle(
              filterNull(content),
              fontSize: ResSize.text_14,
              isTextAlignLeft: true,
              color: contentColor,
            ),)
          ],),),
        ),
        Visibility(visible: isShowOne, child: Container(width: 10,)),
        Visibility(visible: isShowTwo, child:
        Expanded(child: Row(children: <Widget>[
          Container(
            width: hintWidth,
            child: textStyle(
              hint2,
              fontSize: ResSize.text_13,
              isTextAlignLeft: true,
              color: ResColors.gray_99,
            ),),
          Expanded(child: textStyle(
            filterNull(content2),
            fontSize: ResSize.text_14,
            isTextAlignLeft: true,
            color: contentColor,
          ),)
        ],),),)
      ],
    ),
  );
}

///
/// 列表标题样式
/// endWidget 放置右边角标
/// startHint 前置标签文字 不为空显示
///
buildItemTitle(String title, String hint, {Widget endWidget, String startHint,
  Color startColor = ResColors.material_deepPurple_600, bool isPaddingLeft10 = false,
  double titleMaxWidth = 160.0,double hintMaxWidth = 100.0}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Visibility(
        visible: null != startHint && "" != startHint,
        child: Container(
          margin: EdgeInsets.only(right: 4),
          padding: EdgeInsets.only(left: 3, top: 1, right: 3, bottom: 1),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all( //圆角
                Radius.circular(3.0),
              ),
              border: Border.all(color: startColor, width: 1),
              shape: BoxShape.rectangle,
              color: ResColors.white),
          child: textStyle(startHint, fontSize: 9.0, color: startColor),
        ),
      ),
      Expanded(child: Row(
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxWidth: titleMaxWidth),
            margin: EdgeInsets.only(left: isPaddingLeft10 ? 10 : 0),
            child: textStyle(
              filterNull(title),
              fontSize: ResSize.text_16,
              fontWeight: FontWeight.bold,
              maxLines: 1,
              isTextAlignLeft: true,
            ),),
          Visibility(
            visible: null != hint && hint != "",
            child: Container(
              constraints: BoxConstraints(maxWidth: hintMaxWidth),
              padding: EdgeInsets.only(left: 10), child: textStyle("[$hint]",
                fontSize: ResSize.text_11,
                isTextAlignLeft: true,
                maxLines: 1,
                color: ResColors.gray_99),),
          )
        ],
      ),),
      null != endWidget ? endWidget : Text("")
    ],
  );
}

buildListViewDivider({double height =1.0,double margin =10.0,Color color = ResColors.gray_f1}) {
  return Container(
    color: color,
    height: height,
    margin: EdgeInsets.only(left: margin, right: margin),
  );
}


abstract class BaseFunctionState<T extends StatefulWidget> extends State {

  String getAppBarRightButtonText();

  Function onClickAppBarRightButton();

  Function onClickFloatingActionButton();

  Color backgroundColor();

  Widget buildTopLayout();

  Widget buildBottomLayout();

  ///
  /// 统一基类bar按钮
  ///
  Widget buildAppBarRightButton(){
    return Visibility(
      child: InkWell(
        onTap: onClickAppBarRightButton(),
        child: Container(
          margin: EdgeInsets.only(left: 5, top: 16, right: 5, bottom: 16),
          padding: EdgeInsets.only(left: 8, right: 8, bottom: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: ResColors.white),
          child: Text(
            getAppBarRightButtonText(),
            style: TextStyle(fontSize: 12, color: BaseConstants.getAppMainColor(context)),
          ),
        ),
      ),
      visible: getAppBarRightButtonText()!=null && getAppBarRightButtonText()!="",
    );
  }

  ///
  /// 统一基类悬浮按钮
  ///
  buildFloatingActionButton(){
    return Visibility(
      visible: null!=onClickFloatingActionButton(),
      child: FloatingActionButton(
        onPressed: onClickFloatingActionButton(),
        backgroundColor: BaseConstants.getAppMainColor(context),
        child: Icon(Icons.add),
      ),
    );
  }

}

///
/// 列表state
///
/// 标题栏目右侧按钮显示
/// 重写这两个方法 getAppBarRightButtonText()、onClickAppBarRightButton()
///
/// 右下角悬浮按钮显示
/// 重写该方法 onClickFloatingActionButton()
///
abstract class ListViewState<T extends StatefulWidget> extends BaseFunctionState<T> {

  int page = 1;
  int size = 15;
  bool isRefresh = true;
  BuildContext buildContext;
  bool isUseNewHeaderStyle = true;
  bool isFirstRequest = true;
  bool isCanShowEmpty = true;
  EasyRefreshController controller;

  @override
  void initState() {
    super.initState();
    controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    initProvider(context);
    if(null==buildContext){
      getDataByNet(isRefresh, page, size);
    }
    buildContext = context;

    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: ""!=getTitle()?MyAppBar(
          backgroundColor: BaseConstants.getAppMainColor(context),
          title: Text(
            getTitle(),
            style: new TextStyle(
                color: ResColors.white, fontSize: ResSize.text_16),
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            buildAppBarRightButton()
          ],
        ):null,
        body: _buildBodyView(),
        floatingActionButton: buildFloatingActionButton());
  }

  ///
  /// 容器内容
  /// 包含有数据、无数据
  ///
  _buildBodyView(){
    bool isShowNullData = null==buildList();
    bool isShowEmptyData = null!=buildList() && buildList().isEmpty;
    if(isFirstRequest && isShowNullData){
      isFirstRequest = false;
      return Center(child: textStyle(""),);
    }
    if(isShowNullData && isCanShowEmpty){
      return buildReLoadView(context,(){
        isRefresh = true;
        page = 1;
        getDataByNet(isRefresh,page,size);
      });
    }else if(isShowEmptyData && isCanShowEmpty){
      return  buildEmptyView();
    }else{
      return _buildHasDataBodyView();
    }
  }

  ///
  /// 有数据的容器内容
  ///
  _buildHasDataBodyView(){
    return Column(children: <Widget>[
      if(null!=buildTopLayout())buildTopLayout(),
      Expanded(
        child: isUsePage()?EasyRefresh(
            enableControlFinishRefresh: false,
            enableControlFinishLoad: true,
            controller: controller,
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 1),
              itemCount: buildList().length,
              itemBuilder: (context, index) {
                return buildListItemView(buildList()[index],index);
              },
              separatorBuilder: (context, index) => buildListViewDivider(),
            ),
//                header: BezierHourGlassHeader(backgroundColor: ResColors.app_main),
            header: isUseNewHeaderStyle?BezierCircleHeader(backgroundColor: BaseConstants.getAppMainColor(context)):RefreshHeader(),
            footer: RefreshFooter(),
            onRefresh: isUseRefresh() ? () {
              isRefresh = true;
              page = 1;
              return getDataByNet(isRefresh,page,size);
            } : null,
            onLoad: () {
              isRefresh = false;
              page++;
              return getDataByNet(isRefresh,page,size);
            })
            :ListView.separated(
          padding: const EdgeInsets.only(top: 1),
          itemCount: buildList().length,
          itemBuilder: (context, index) {
            return buildListItemView(buildList()[index],index);
          },
          separatorBuilder: (context, index) => buildListViewDivider(),
        ),
      ),
      if(null!=buildBottomLayout())buildBottomLayout(),
    ],);

  }

  ///初始化请求
  initProvider(BuildContext context);

  ///请求接口数据
  getDataByNet(bool isRefresh,int page,int size);

  ///每条数据样式
  Widget buildListItemView(Object object,int index);

  ///标题
  String getTitle();

  ///列表数组
  List buildList();

  ///是否使用分页
  bool isUsePage();

  ///是否使用刷新
  bool isUseRefresh(){
    return true;
  }

  ///标题右侧按钮
  @override
  String getAppBarRightButtonText() {
    return "";
  }

  ///右侧按钮点击事件
  @override
  Function onClickAppBarRightButton() {
    return null;
  }

  ///右下角悬浮按钮
  @override
  Function onClickFloatingActionButton() {
    return null;
  }

  @override
  Color backgroundColor() {
    return ResColors.white;
  }

  ///顶部区域
  @override
  Widget buildTopLayout() {
    return null;
  }

  ///底部区域
  @override
  Widget buildBottomLayout() {
    return null;
  }

}

///
/// 详情带分页数据state
///
/// 标题栏目右侧按钮显示
/// 重写这两个方法 getAppBarRightButtonText()、onClickAppBarRightButton()
///
/// 右下角悬浮按钮显示
/// 重写该方法 onClickFloatingActionButton()
///
abstract class DetailPagingViewState<T extends StatefulWidget> extends BaseFunctionState<T> {

  int page = 1;
  int size = 15;
  bool isRefresh = true;
  BuildContext buildContext;
  bool isFirstRequest = true;
  bool isDrawViewFinish = false;
  bool isUseListDivider = true;
  EasyRefreshController controller;

  @override
  void initState() {
    super.initState();
    isDrawViewFinish = false;
    isFirstRequest = true;
    controller = EasyRefreshController();
  }

  @override
  Widget build(BuildContext context) {
    initProvider(context);
    if(null==buildContext){
      getDataByNet(isRefresh, page, size);
    }
    buildContext = context;

    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: ""!=getTitle()?MyAppBar(
          backgroundColor: BaseConstants.getAppMainColor(context),
          title: Text(
            getTitle(),
            style: new TextStyle(
                color: ResColors.white, fontSize: ResSize.text_16),
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            buildAppBarRightButton()
          ],
        ):null,
        body: _buildBodyView(),
        floatingActionButton: buildFloatingActionButton());
  }

  ///
  /// 容器内容
  /// 包含有数据、无数据
  ///
  _buildBodyView(){
    bool isShowNullData = null==buildList();
    bool isShowEmptyData = null!=buildList() && buildList().isEmpty;
    if(isFirstRequest && isShowNullData){
      isFirstRequest = false;
      return Center(child: textStyle(""),);
    }
    if(isShowNullData){
      return buildReLoadView(context,(){
        isRefresh = true;
        page = 1;
        getDataByNet(isRefresh,page,size);
      });
    }else if(isShowEmptyData && isNeedShowEmpty()){
      return  buildEmptyView();
    }else{
      return _buildHasDataBodyView();
    }
  }

  ///
  /// 有数据的容器内容
  ///
  _buildHasDataBodyView() {
    return Column(children: [
      Expanded(child: EasyRefresh(
          enableControlFinishRefresh: false,
          enableControlFinishLoad: true,
          controller: controller,
          header: BezierCircleHeader(backgroundColor: BaseConstants.getAppMainColor(context)),
          footer: RefreshFooter(),
          onRefresh: () {
            isDrawViewFinish = true;
            isRefresh = true;
            page = 1;
            return getDataByNet(isRefresh, page, size);
          },
          onLoad: () {
            isDrawViewFinish = true;
            if(isNeedLoadMore()){
              isRefresh = false;
              page++;
              return getDataByNet(isRefresh, page, size);
            }else {
              return null;
            }
          },
          child: SingleChildScrollView(child:
          Column(children: <Widget>[
            if(null != buildTopLayout())buildTopLayout() else Container(height: 10,),
            buildCardWidgetView(buildListViewTitle(), ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 1),
              itemCount: buildList().length,
              itemBuilder: (context, index) {
                return buildListItemView(buildList()[index], index);
              },
              separatorBuilder: (context, index) => buildListViewDivider(height: isUseListDivider?1:0),
            )),
            if(null != buildBottomScrollLayout())buildBottomScrollLayout(),
            if(null != buildApproveLayout())buildApproveLayout(),
          ],),
          ))),
      if(null != buildBottomLayout())buildBottomLayout(),
    ],);
  }

  ///初始化请求
  initProvider(BuildContext context);

  ///请求接口数据
  getDataByNet(bool isRefresh,int page,int size);

  ///每条数据样式
  Widget buildListItemView(Object object,int index);

  ///标题
  String getTitle();

  ///列表数组
  List buildList();

  ///标题右侧按钮
  @override
  String getAppBarRightButtonText() {
    return "";
  }

  ///右侧按钮点击事件
  @override
  Function onClickAppBarRightButton() {
    return null;
  }

  ///右下角悬浮按钮
  @override
  Function onClickFloatingActionButton() {
    return null;
  }

  @override
  Color backgroundColor() {
    return ResColors.gray_f1;
  }

  ///顶部区域
  @override
  Widget buildTopLayout() {
    return null;
  }

  ///底部区域
  @override
  Widget buildBottomLayout() {
    return null;
  }

  ///底部跟随滑动view
  Widget buildBottomScrollLayout(){
    return null;
  }

  ///底部跟随滑动审批进度
  Widget buildApproveLayout(){
    return null;
  }

  ///列表标题
  String buildListViewTitle() {
    return "";
  }

  ///是否需要加载更多
  bool isNeedLoadMore(){
    return true;
  }

  ///页面是否需要展示空
  bool isNeedShowEmpty(){
    return true;
  }
}

///
/// 详情state
///
/// 标题栏目右侧按钮显示
/// 重写这两个方法 getAppBarRightButtonText()、onClickAppBarRightButton()
///
/// 右下角悬浮按钮显示
/// 重写该方法 onClickFloatingActionButton()
///
abstract class DetailViewState<T extends StatefulWidget> extends BaseFunctionState<T> {

  BuildContext buildContext;
  List<Widget> widgets = [];
  //是否使用卡片样式
  bool isUseCardStyle = true;
  bool isFirstRequest = true;

  @override
  Widget build(BuildContext context) {
    initProvider(context);
    if(null==buildContext)
      getDataByNet();
    buildContext = context;
    widgets.clear();
    if(null!=buildList())
      buildList().forEach((element) {
        widgets.add(Column(
          children: <Widget>[
            buildListItemView(element),
            if(isUseCardStyle)
              Gaps.vGap10,
            if(!isUseCardStyle)
              buildListViewDivider()
          ],
        ));
      });
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: MyAppBar(
          backgroundColor: BaseConstants.getAppMainColor(context),
          title: Text(
            getTitle(),
            style: new TextStyle(
                color: ResColors.white, fontSize: ResSize.text_16),
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            buildAppBarRightButton()
          ],
        ),
        body: _buildBodyView(),
        floatingActionButton: buildFloatingActionButton());
  }

  ///
  /// 容器内容
  /// 包含有数据、无数据
  ///
  _buildBodyView(){
    bool isShowNullData = null==buildList();
    bool isShowEmptyData = null!=buildList() && buildList().isEmpty;
    if(isFirstRequest && isShowNullData){
      isFirstRequest = false;
      return Center(child: textStyle(""),);
    }
    if(isShowNullData){
      return  buildReLoadView(context,(){
        getDataByNet();
      });
    }else if(isShowEmptyData){
      return  buildEmptyView();
    }else{
      return Column(
        children: <Widget>[
          Expanded(child: SingleChildScrollView(
            child: Column(children: <Widget>[
              if(null!=buildTopLayout())buildTopLayout(),
              if(isUseCardStyle)Gaps.vGap10,
              Column(children: widgets,),
              if(null!=buildAttachmentLayout())buildAttachmentLayout(),
              if(null!=buildBottomScrollLayout())buildBottomScrollLayout(),
              if(null!=buildApproveLayout())buildApproveLayout(),
            ]),
          ),),
          if(null!=buildBottomLayout())buildBottomLayout(),
        ],
      ) ;
    }
  }
  ///初始化请求
  initProvider(BuildContext context);

  ///请求接口数据
  getDataByNet();

  ///每条数据样式
  Widget buildListItemView(Object object);

  ///标题
  String getTitle();

  ///列表数组
  List buildList();

  ///标题右侧按钮
  @override
  String getAppBarRightButtonText() {
    return "";
  }

  ///右侧按钮点击事件
  @override
  Function onClickAppBarRightButton() {
    return null;
  }

  ///右下角悬浮按钮
  @override
  Function onClickFloatingActionButton() {
    return null;
  }

  @override
  Color backgroundColor() {
    return isUseCardStyle?ResColors.gray_f1:ResColors.white;
  }

  ///顶部区域
  @override
  Widget buildTopLayout() {
    return null;
  }

  ///底部区域
  @override
  Widget buildBottomLayout() {
    return null;
  }

  ///底部跟随滑动view
  Widget buildBottomScrollLayout(){
    return null;
  }

  ///底部跟随滑动审批进度
  Widget buildApproveLayout(){
    return null;
  }

  /// 附件布局
  Widget buildAttachmentLayout(){
    return null;
  }

  getFileType(String fileUrl) {
    if(null == fileUrl) return -1;
    var split = fileUrl.split(".");
    String endStr = split[split.length - 1];
    switch (endStr) {
      case "jpg":
      case "png":
        return 0;
      default:
        return -1;
    }
  }

  /// 附件
  Widget buildAttachment(String fileUrl) {
    double mWidth = 300;
    double mHeight = 270;
    return Container(
        width: mWidth,
        height: mHeight,
        margin: EdgeInsets.only(right: 3),
        child: Visibility(
            child: GestureDetector(
              onTap: () {
                openFileByUrl(context, fileUrl);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  imageErrorBuilder: (c, e, s) {
                    return Image.asset(
                      getImgPath("icon_image_failed"),
                      width: mWidth,
                      height: mHeight,
                    );
                  },
                  placeholder: getImgPath("ic_defaut_image"),
                  image: BaseApi.baseImgUrl + fileUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ))
    );
  }

}

///
/// 包含头的state
///
/// 标题栏目右侧按钮显示
/// 重写这两个方法 getAppBarRightButtonText()、onClickAppBarRightButton()
///
/// 右下角悬浮按钮显示
/// 重写该方法 onClickFloatingActionButton()
///
abstract class AppBarViewState<T extends StatefulWidget> extends BaseFunctionState<T> {

  BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: MyAppBar(
          backgroundColor: BaseConstants.getAppMainColor(context),
          title: Text(
            getTitle(),
            style: new TextStyle(
                color: ResColors.white, fontSize: ResSize.text_16),
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            buildAppBarRightButton()
          ],
        ),
        body: buildBody(),
        floatingActionButton: Visibility(
          visible: null!=onClickFloatingActionButton(),
          child: FloatingActionButton(
            onPressed: onClickFloatingActionButton(),
            backgroundColor: BaseConstants.getAppMainColor(context),
            child: Icon(Icons.add),
          ),
        ));
  }

  ///标题
  String getTitle();

  ///内容
  Widget buildBody();

  ///标题右侧按钮
  @override
  String getAppBarRightButtonText() {
    return "";
  }

  ///右侧按钮点击事件
  @override
  Function onClickAppBarRightButton() {
    return null;
  }

  ///右下角悬浮按钮
  @override
  Function onClickFloatingActionButton() {
    return null;
  }

  @override
  Color backgroundColor() {
    return ResColors.white;
  }

  ///顶部区域
  @override
  Widget buildTopLayout() {
    return null;
  }

  ///底部区域
  @override
  Widget buildBottomLayout() {
    return null;
  }
}


///
/// 带有切换tab的的state
///
/// 标题栏目右侧按钮显示
/// 重写这两个方法 getAppBarRightButtonText()、onClickAppBarRightButton()
///
/// 右下角悬浮按钮显示
/// 重写该方法 onClickFloatingActionButton()
///
abstract class TabState<T extends StatefulWidget> extends BaseFunctionState<T> with SingleTickerProviderStateMixin{

  BuildContext buildContext;
  TabController controller;//tab控制器
  int currentIndex = 0; //选中下标

  @override
  void initState() {
    super.initState();
    controller = TabController(length: buildTabs().length, vsync: this);
    controller.addListener(() => onTabChanged(controller.index));
  }

  @override
  Widget build(BuildContext context) {
    if(null==buildContext)
      initProvider(context);
    buildContext = context;
    return Scaffold(
        backgroundColor: backgroundColor(),
        appBar: MyAppBar(
          backgroundColor: BaseConstants.getAppMainColor(context),
          title: Text(
            getTitle(),
            style: new TextStyle(
                color: ResColors.white, fontSize: ResSize.text_16),
          ),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            Visibility(
              child: InkWell(
                onTap: onClickAppBarRightButton(),
                child: Container(
                  margin: EdgeInsets.only(left: 5, top: 16, right: 5, bottom: 16),
                  padding: EdgeInsets.only(left: 8, right: 8, bottom: 2),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: ResColors.white),
                  child: Text(
                    getAppBarRightButtonText(),
                    style: TextStyle(fontSize: 12, color: BaseConstants.getAppMainColor(context)),
                  ),
                ),
              ),
              visible: getAppBarRightButtonText()!=null && getAppBarRightButtonText()!="",
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            buildTabLBar(buildTabs(),context,controller: controller),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: buildFragments(),
              ),
            ),
          ],
        ),
        floatingActionButton: Visibility(
          visible: null!=onClickFloatingActionButton(),
          child: FloatingActionButton(
            onPressed: onClickFloatingActionButton(),
            backgroundColor: BaseConstants.getAppMainColor(context),
            child: Icon(Icons.add),
          ),
        ));
  }

  ///初始化请求
  initProvider(BuildContext context){

  }

  ///标题
  String getTitle();

  ///fragment
  List<Widget> buildFragments();

  ///tabs
  List<String> buildTabs();

  ///标题右侧按钮
  @override
  String getAppBarRightButtonText() {
    return "";
  }

  ///右侧按钮点击事件
  @override
  Function onClickAppBarRightButton() {
    return null;
  }

  ///右下角悬浮按钮
  @override
  Function onClickFloatingActionButton() {
    return null;
  }

  @override
  Color backgroundColor() {
    return ResColors.white;
  }

  ///顶部区域
  @override
  Widget buildTopLayout() {
    return null;
  }

  ///底部区域
  @override
  Widget buildBottomLayout() {
    return null;
  }

  ///tab切换
  onTabChanged(currentIndex){
    this.currentIndex = currentIndex;
  }

}
buildItemWithHintBg(String label, String value,{hintColor = ResColors.black_34,double  top = 10.0,double  bottom = 10.0}) {
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10, top: top, bottom: bottom),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        if (label != null && label != '')
          Container(
            width: 100.0,
            child: Text(
              label,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
            ),
          ),
        Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 14.0,color: hintColor),
                ),
              ),
            )),
      ],
    ),
  );
}


///
/// 新闻流卡片
/// 图片+内容的卡片
///
buildNewsCardView(BuildContext context,NewsFeedBean bean,{double radius = 10.0}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: ResColors.white,
        boxShadow: [
          if(radius!=0.0)
            BoxShadow(
              color: boxShadowColor, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius:blurRadius, // 阴影模糊层度
              spreadRadius: spreadRadius,
            )
        ]),
    padding: EdgeInsets.only(top: 15, bottom: 15),
    margin: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if(bean?.title?.isNotEmpty ?? false)
          Padding(
            padding: EdgeInsets.only(left: 10,right: 0),
            child: textStyle(bean.title,isTextAlignLeft: true,fontWeight: FontWeight.bold,fontSize: ResSize.text_18,maxLines: 1),
          ),
        if(bean?.content?.isNotEmpty ?? false)
          Padding(
            padding: EdgeInsets.only(left: 10,right: 0,top: 10),
            child: textStyle(bean.content,isTextAlignLeft: true,fontSize: ResSize.text_14,color: ResColors.color_7B7B7B,maxLines: 2),
          ),
        if(null!=bean.fileUrls && bean.fileUrls.isNotEmpty)
          Gaps.vGap15,
        if(null!=bean.fileUrls && bean.fileUrls.isNotEmpty)
          buildMaxThreeFileView(bean.fileUrls,context),
        Gaps.vGap15,
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle(bean.dateTime,color: ResColors.color_AAAAAA,fontSize: ResSize.text_12),
              if(bean.isShowBrowse)
              Row(children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.only(right: 3),
                  child: Image.asset(
                    getImgPath("ic_eye"),
                  ),),
                textStyle(bean?.browseCount?.toString(),color: ResColors.color_AAAAAA,fontSize: ResSize.text_12)
              ],),
            ],),)
      ],
    ),
  );
}


///
/// 新闻流卡片
/// 图片+内容的卡片
///
double blurRadius = 8.0;
double spreadRadius = 2.0;
Color boxShadowColor = ResColors.color_80E5E5E5;
buildNewsRightImageCardView(BuildContext context,NewsFeedBean bean,{double radius = 10.0}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: ResColors.white,
        boxShadow: [
          if(radius!=0.0)
            BoxShadow(
              color: boxShadowColor, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius:blurRadius, // 阴影模糊层度
              spreadRadius: spreadRadius,
            )
        ]),
    padding: EdgeInsets.only(top: 15, bottom: 15),
    margin: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(bean?.title?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 0),
                  child: textStyle(bean.title,isTextAlignLeft: true,fontWeight: FontWeight.bold,fontSize: ResSize.text_18,maxLines: 1),
                ),
              if(bean?.content?.isNotEmpty ?? false)
                Padding(
                  padding: EdgeInsets.only(left: 10,right: 0,top: 10),
                  child: textStyle(bean.content,isTextAlignLeft: true,fontSize: ResSize.text_14,color: ResColors.color_7B7B7B,maxLines: 2),
                ),
            ],)),
            if(null!=bean.fileUrls && bean.fileUrls.isNotEmpty)
              buildMaxThreeFileSingleView(bean.fileUrls[0],context)
        ],),
        Gaps.vGap15,
        Padding(
          padding: EdgeInsets.only(left: 10,right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textStyle(bean.dateTime,color: ResColors.color_AAAAAA,fontSize: ResSize.text_12),
              if(bean.isShowBrowse)
              Row(children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.only(right: 3),
                  child: Image.asset(
                    getImgPath("ic_eye"),
                  ),),
                textStyle(bean?.browseCount?.toString(),color: ResColors.color_AAAAAA,fontSize: ResSize.text_12)
              ],),
            ],),)
      ],
    ),
  );
}
buildNewsRightImageNoBrowseCardView(BuildContext context,NewsFeedBean bean,{double radius = 10.0}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: ResColors.white,
        boxShadow: [
          if(radius!=0.0)
            BoxShadow(
              color: boxShadowColor, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius:blurRadius, // 阴影模糊层度
              spreadRadius: spreadRadius,
            )
        ]),
    padding: EdgeInsets.only(top: 15, bottom: 15),
    margin: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(bean?.title?.isNotEmpty ?? false)
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 0),
                    child: textStyle(bean.title,isTextAlignLeft: true,fontWeight: FontWeight.bold,fontSize: ResSize.text_18,maxLines: 1),
                  ),
                if(bean?.content?.isNotEmpty ?? false)
                  Padding(
                    padding: EdgeInsets.only(left: 10,right: 0,top: 10),
                    child: textStyle(bean.content,isTextAlignLeft: true,fontSize: ResSize.text_14,color: ResColors.color_7B7B7B,maxLines: 2),
                  ),
              ],)),
            if(null!=bean.fileUrls && bean.fileUrls.isNotEmpty)
              buildMaxThreeFileSingleView(bean.fileUrls[0],context)
          ],),
      ],
    ),
  );
}
///
/// 业务流卡片
/// 头像
/// 标题
/// 内容区域
/// 附件区域 包含图片、视频、附件
/// 审批状态栏
///
buildWorkCardView(BuildContext context,BaseFeedBean bean,{double radius = 10.0,double hintWidth = 80.0}){
  List<Widget> widgets = [];
  bean.contentList.forEach((element) {
    if(null==element.files){
      widgets.add(buildContentItemSingle(element.key, element.value,
          fontSize: ResSize.text_14,onClickBack: element.onClickFunction,maxLines: element.maxLines ?? 3,
          contentColor: element.valueColor ?? ResColors.black,hintWidth: hintWidth));
    } else{
      if(element.files.length == 1){
        widgets.add(buildTitleImageSingle(element.key, element.files[0].fileUrl, context,hintWidth: hintWidth,bottom: 0,imgBgColor: element.imgBgColor));
      }else{
        widgets.add(buildContentItemSingle(element.key, "", fontSize: ResSize.text_13,hintWidth: hintWidth));
        widgets.add(Gaps.vGap10);
        widgets.add(buildMaxThreeFileView(element.files, context));
      }
    }
  });
  bool isShowBottomDivider = bean?.fileUrls?.isEmpty ?? true;
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: ResColors.white,
        boxShadow: [
          if(radius!=0.0)
            BoxShadow(
              color: boxShadowColor, //底色,阴影颜色
              offset: Offset(0, 0), //阴影位置,从什么位置开始
              blurRadius:blurRadius, // 阴影模糊层度
              spreadRadius: spreadRadius,
            )
        ]),
    padding: EdgeInsets.only(top: 0, bottom: 15),
    margin: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if(bean.isShowAvatar)
          Gaps.vGap15,
        if(bean.isShowAvatar)
          buildAvatarNameDeptView(context,bean.avatar,bean.name,bean.deptName),
        Gaps.vGap15,
        if(bean?.title?.isNotEmpty ?? false)
          Padding(
            padding: EdgeInsets.only(left: 10,right: 0),
            child: textStyle(bean?.title,isTextAlignLeft: true,fontWeight: FontWeight.bold,fontSize: ResSize.text_18),
          ),
        Column(
          children: widgets,
        ),
        if(bean?.fileUrls?.isNotEmpty ?? false)
          Gaps.vGap15,
        if(bean?.fileUrls?.isNotEmpty ?? false)
          buildMaxThreeFileView(bean.fileUrls,context),
        if(bean.isShowBottomApprove)
          Gaps.vGap15,
        if(bean.isShowBottomApprove)
          buildListViewDivider(margin: 10.0),
        if(bean.isShowBottomApprove)
          Gaps.vGap15,
        if(bean.isShowBottomApprove)
          Padding(
            padding: EdgeInsets.only(left: 10,right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                textStyle(bean.dateTime,color: ResColors.color_AAAAAA,fontSize: ResSize.text_12),
//                printLog(bean.statusColor),
                buildStatusTextView(bean.statusName,bean.statusColor),
              ],),)
      ],
    ),
  );
}

///
/// 头像 名称 职位 布局
///
buildAvatarNameDeptView(BuildContext context,String url,String name,String deptName){
  return Row(children: [
    Gaps.hGap10,
    buildCircleAvatar(url, context,width: 40.0),
    Gaps.hGap5,
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textStyle(name,fontWeight: FontWeight.bold,fontSize: ResSize.text_12,color: ResColors.color_333333,isTextAlignLeft: true),
        Gaps.vGap5,
        textStyle(deptName,fontSize: ResSize.text_11,color: ResColors.color_7B7B7B,isTextAlignLeft: true),
      ],)
  ],);
}

///
/// 审批状态文字
///
buildStatusTextView(String text,String status){
  Color statusTextColor=ResColors.material_red_600;
  switch (status ?? "red") {
    case "purple" :
      statusTextColor = ResColors.material_deepPurple_600;
      break;
    case "red" :
      statusTextColor = ResColors.material_red_600;
      break;
    case "green" :
      statusTextColor = ResColors.color_12ADA9;
      break;
    case "blue" :
      statusTextColor = ResColors.color_4180FF;
      break;
    case "brown" :
      statusTextColor = ResColors.material_brown_600;
      break;
    case "black" :
      statusTextColor = ResColors.black;
      break;
  }

  return textStyle(text,fontSize: ResSize.text_12,color: statusTextColor,isTextAlignLeft: true);
}

///
/// 横向三个图片或者视频或者附件样式
///
buildMaxThreeFileView(List<MultiFileBean> fileBeans,BuildContext context,{double imageWidth=110,double imageHeight=80,bool isShowOne = false}){
  List<Widget> imageWidgets = [];
  fileBeans.forEach((element) {
    if(isShowOne && imageWidgets.length>0)
      return;
    if(fileBeans.length >2)
      imageWidgets.add(Expanded(child: buildMaxThreeFileSingleView(element,context,imageHeight: imageHeight,imageWidth: imageWidth)));
    else
      imageWidgets.add(buildMaxThreeFileSingleView(element,context,imageHeight: imageHeight,imageWidth: imageWidth));
  });
  return Container(
    margin: EdgeInsets.only(left: 8,right: 7),
    child: Row(children:imageWidgets,),);
}
///
/// 横向三个图片或者视频或者附件中一个单独样式
///
buildMaxThreeFileSingleView(MultiFileBean fileBean,BuildContext context,{double imageWidth=100,double imageHeight=80}){
  String endFileName = "file";
  if(null!=fileBean.fileUrl && ""!=fileBean.fileUrl) {
    var split = fileBean.fileUrl.split(".");
    if(split[split.length - 1].length < 5)
      endFileName = split[split.length - 1];
  }
  return Container(
      width: imageWidth,
      height: imageHeight,
      margin: EdgeInsets.only(right: 3),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          Visibility(
              visible: fileBean.type != 2,
              child: GestureDetector(
                onTap: (){
                  openFileByUrl(context, fileBean.fileUrl,isUseBaseUrl: false,isForceImage: true);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (c,e,s){
                      return Image.asset(
                        getImgPath("icon_image_failed"),
                        width: imageWidth,
                        height: imageWidth,
                      );
                    },
                    placeholder: getImgPath("ic_defaut_image"),
                    image: fileBean.fileUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          Visibility(
              visible: fileBean.type == 2,
              child: GestureDetector(
                onTap: (){
                  openFileByUrl(context, fileBean.fileUrl,isUseBaseUrl: false);
                },
                child: buildTextCardView(endFileName,getFileBgColorByUrl(fileBean.fileUrl)),
              )),
          Visibility(
              visible: fileBean.type == 1,
              child: Positioned(
                width: 30,
                height: 30,
                child: Container(
                  child: Image.asset(
                    getImgPath("ic_play_video"),
                  ),),
              )),
          Visibility(
              visible: fileBean.type == 2,
              child: Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    padding: EdgeInsets.only(left: 2,right: 2),
                    decoration: BoxDecoration(
                        color:ResColors.gray_7f,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                    alignment: Alignment.center,
                    child: textStyle(getEndNameByUrl(fileBean.fileUrl),fontSize: ResSize.text_12,color: ResColors.black_34,maxLines: 1),)))
        ],
      ));
}

///
/// 单个图片+描述
/// 有圆角背景
///
buildTitleFileSingle(String label, String value,String imgUrl,BuildContext context,
    {hintColor = ResColors.black_34,double  top = 10.0,double  bottom = 10.0}){
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10, top: top, bottom: bottom),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        if (label != null && label != '')
          Container(
            width: 100.0,
            child: Text(
              label,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
            ),
          ),
        Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: Color(0xfff5f5f5),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(children: [
                  Expanded(child: textStyle(value,fontSize: 14.0,color:Colors.black87 ,maxLines: 2,isTextAlignLeft: true)),
                  Gaps.hGap5,
                  buildNetImageView(imgUrl, context,isIntoBigImagePage: true)
                ],),
              ),
            )),
      ],
    ),
  );
}
///
/// 单个图片没描述
/// 无圆角背景
///
buildTitleImageSingle(String label,String imgUrl,BuildContext context,
    {hintColor = ResColors.black_34,double  top = 10.0,double  bottom = 10.0, hintWidth = 100.0,Color imgBgColor}){
  return Container(
    padding: EdgeInsets.only(left: 10, right: 10, top: top, bottom: bottom),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        if (label != null && label != '')
          Container(
            width: hintWidth,
            child: Text(
              label,
              style: TextStyle(fontSize: ResSize.text_13, color: ResColors.gray_99),
            ),
          ),
        Gaps.hGap10,
        buildNetImageView(imgUrl, context,isIntoBigImagePage: true,defaultImg: "icon_image_failed",imgBgColor: imgBgColor),
      ],
    ),
  );
}
///
/// 卡片标题+内容
/// title 标题
/// list 内容数组
///
buildTitleContentCard(String title, List<KeyValueBack> list,{double radius = 10.0,double hintWidth = 100.0,BuildContext context}) {
  List<Widget> widgets = [];
  list.forEach((element) {
    if(null==element.files){
      widgets.add(buildContentItemSingle(element.key, element.value,
          fontSize: ResSize.text_14,onClickBack: element.onClickFunction,maxLines: element.maxLines ?? 3,
          contentColor: element.valueColor ?? ResColors.black,hintWidth: hintWidth));
    } else{
      if(element.files.length == 1){
        widgets.add(buildTitleImageSingle(element.key, element.files[0].fileUrl, context,hintWidth: hintWidth,imgBgColor: element.imgBgColor));
      }else{
        widgets.add(buildContentItemSingle(element.key, "", fontSize: ResSize.text_14,hintWidth: hintWidth));
        widgets.add(Gaps.vGap10);
        widgets.add(buildMaxThreeFileView(element.files, context));
      }
    }
  });
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: ResColors.white,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor, //底色,阴影颜色
            offset: Offset(0, 0), //阴影位置,从什么位置开始
            blurRadius:blurRadius, // 阴影模糊层度
            spreadRadius: spreadRadius,
          )
        ]),
    padding: EdgeInsets.only(top: 15, bottom: 15),
    margin: EdgeInsets.only(left: 5, right: 5),
    child: Column(
      children: <Widget>[
        buildItemTitle(title, "", isPaddingLeft10: true),
        Gaps.vGap5,
        Column(
          children: widgets,
        ),
      ],
    ),
  );
}

///
///圆角卡片
///
buildCardWidgetView(String cardTitle,Widget widget,{double marginBottom = 0.0,Widget endWidget}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: ResColors.white,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor, //底色,阴影颜色
            offset: Offset(0, 0), //阴影位置,从什么位置开始
            blurRadius:blurRadius, // 阴影模糊层度
            spreadRadius: spreadRadius,
          )
        ]),
    padding: EdgeInsets.only(top: 15, bottom: 15),
    margin: EdgeInsets.only(left: 5, right: 5,bottom: marginBottom),
    child: Column(
      children: <Widget>[
        buildItemTitle(cardTitle, "", isPaddingLeft10: true,endWidget: endWidget),
        Gaps.vGap5,
        widget,
      ],
    ),
  );
}


