


import 'key_value_back.dart';

///common
///
/// <pre>
///     author : pengMaster
///     e-mail : pengMaster
///     time   : 2019/11/7 3:14 PM
///     desc   : 
///     version: 1.0
/// </pre>
///
class FeedListBean{
   String type;
   Object bean;

   FeedListBean(this.type, this.bean);
}

String imageDC1 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fdpic.tiankong.com%2Fr9%2F57%2FQJ6116762261.jpg%3Fx-oss-process%3Dstyle%2Fshow&refer=http%3A%2F%2Fdpic.tiankong.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649234878&t=c550f04aea67d30e68fddff5954fca5a";

String imageDYB1 = "https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/zhidao/wh%3D450%2C600/sign=ab92bdc3f01f3a295a9dddcaac159007/500fd9f9d72a605902ebfd072834349b033bba37.jpg";
String imageDYB2 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fp5.itc.cn%2Fq_70%2Fimages03%2F20210722%2F6a2f2f8dad884f129eee52550e0bfb97.jpeg&refer=http%3A%2F%2Fp5.itc.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649228504&t=930dfcc1c779f0c7d759c1992afbe296";
String imageDYB3 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Ffile16.zk71.com%2FFile%2FCorpEditInsertImages%2F2017%2F07%2F17%2F0_zszyhs168_20170717120624.jpg&refer=http%3A%2F%2Ffile16.zk71.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649228555&t=61d0b8c292d8a6d5283fb8152c2a84a5";

//String image1 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic.jj20.com%2Fup%2Fallimg%2F1111%2F06101Q10J2%2F1P610110J2-9.jpg&refer=http%3A%2F%2Fpic.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647915592&t=7d8c7af40340c6c234bbe944ac96a97f";
//String image2 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1111%2F03021Q40245%2F1P302140245-1-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647915921&t=7722b1d24e48a8eb85f6c0f6f10bf154";
//String image3 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.jj20.com%2Fup%2Fallimg%2F1114%2F101520094J6%2F201015094J6-4-1200.jpg&refer=http%3A%2F%2Fimg.jj20.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1647915943&t=fc2dfb8674573b76d2348db9d9b67d56";

String image4 = "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimagepphcloud.thepaper.cn%2Fpph%2Fimage%2F128%2F1%2F901.jpg&refer=http%3A%2F%2Fimagepphcloud.thepaper.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649231063&t=2fa2f04e4e33ab7cb3b54b6545b18a03";


class BaseFeedBean{

   String title;
   String name;
   String avatar;
   String deptName;

   String content;
   List<KeyValueBack> contentList=[];

   List<MultiFileBean> fileUrls = [];

   String dateTime ;
   String statusName ;
   String status;
   String statusColor;

   ///布局状态
   //是否展示用户信息
   bool isShowAvatar = true;
   //是否展示底部审批状态
   bool isShowBottomApprove = true;

   Object object;

   BaseFeedBean(this.isShowAvatar, this.isShowBottomApprove,{this.fileUrls});
}

class NewsFeedBean extends BaseFeedBean{

   int browseCount = 20;
   String routerUrl;
   bool isShowBrowse = true;

  NewsFeedBean(bool isShowAvatar, bool isShowBottomApprove,{List<MultiFileBean> fileUrls}) : super(isShowAvatar, isShowBottomApprove,fileUrls: fileUrls);

}

class MultiFileBean{
   int type=0;//0图片 1视频 2文件
   String fileUrl;//文件地址
   String routerUrl;//跳转地址

   MultiFileBean(this.type, this.fileUrl,{this.routerUrl});
}