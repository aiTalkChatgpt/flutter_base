import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

///
/// 兼容iOS 和 Android 的 打开URL
///
///
class UrlUtils {
  /// 打开系统电话页面
  static void tel(String phone) async {
    if (phone.isNotEmpty) {
      var url = "tel:" + phone;
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: '手机号不能为空');
    }
  }

  static void http(String path) async {
    if (path.isNotEmpty) {
      var url = "";
      if (path.startsWith("http:")) {
        url += path;
      } else {
        url = "http:" + path;
      }
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: '网址不能为空');
    }
  }

  static void sms(String message) async {
    if (message.isNotEmpty) {
      var url = "sms:" + message;
      await launch(url);
    } else {
      Fluttertoast.showToast(msg: '短信内容不能为空');
    }
  }

//  Scheme	Action
//  http:<URL> , https:<URL>, e.g. http://flutter.dev	Open URL in the default browser
//  mailto:<email address>?subject=<subject>&body=<body>, e.g.
//  mailto:smith@example.org?subject=News&body=New%20plugin	Create email to in the default email app
//  tel:<phone number>, e.g. tel:+1 555 010 999	Make a phone call to using the default phone app
//  sms:<phone number>, e.g. sms:5550101234	Send an SMS message to using the default messaging app
}
