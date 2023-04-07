import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/widget/html_page.dart';
import 'package:flutter_base/common/base/widget/webview_page.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_vertical_marquee/flutter_vertical_marquee.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail :
///     time   : 2020/11/30 12:34 PM
///     desc   : 通知
///     version: v1.0
/// </pre>
///
class ScrollTextBean{
  String title;
  String content;
  String url;
  bool isOpenUrl;
  Function onTap;

  ScrollTextBean(this.title, this.content, this.url, this.isOpenUrl, {this.onTap});
}
// ignore: must_be_immutable
class ScrollText extends StatefulWidget {

  List<ScrollTextBean> noticeList;

  ScrollText(this.noticeList);

  @override
  State<StatefulWidget> createState() {
    return ScrollTextState(noticeList);
  }
}

class ScrollTextState extends State<ScrollText>
    with AutomaticKeepAliveClientMixin {

  List<ScrollTextBean> noticeList;

  ScrollTextState(this.noticeList);

  MarqueeController controller = MarqueeController();


  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<String> noticeItems = [];
    noticeItems.clear();
    noticeList.forEach((element) {
      noticeItems.add(element.title);
    });

    if(noticeItems.length == 0) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(left: 10, top: 3, bottom: 3, right: 10),
      height: 30,
      child: InkWell(
        onTap: () {
          ScrollTextBean noticeBean = noticeList[controller.position];
          if(noticeBean.onTap != null){
            noticeBean.onTap();
          }else{
            if(noticeBean.isOpenUrl){
              navigateTo(context, WebViewPage(noticeBean.url));
            }else{
              navigateTo(context, HtmlPage(noticeBean.content));
            }
          }
        },
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(getImgPath("ic_speaker")),
              width: 20,
              height: 20,
            ),
            Expanded(
                child: Marquee(
                  controller: controller,
                  textList: noticeItems, // your text list
                  fontSize: 13.0, // text size
                  scrollDuration: Duration(seconds: 1), // every scroll duration
                  stopDuration: Duration(seconds: 3), //every stop duration
                  tapToNext: false, // tap to next
                  textColor: ResColors.black_34, // text color
                )
            ),
          ],
        ),
      ),
    );
  }

}
