import 'dart:async';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/api/result_data.dart';
import 'package:flutter_base/common/app.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/widget/confirm_login_window.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/utils/date_util.dart';
import 'package:flutter_base/utils/device_util.dart';
import 'package:flutter_base/utils/dialog_utils.dart';
import 'package:flutter_base/utils/log_util.dart';
import 'package:flutter_base/utils/sp_util.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'baseApi.dart';
import 'code.dart';
import 'common_result.dart';

///
/// <pre>
///     author : Wp
///     e-mail : 神州友创
///     time   : 2019/7/7 8:35 PM
///     desc   : 网络请求工具类
///     version: 1.0
/// </pre>
///

var dio = new Dio();

///
/// 请求地址
/// 请求参数
/// token
/// 响应结果
///
class NetBean{
  String url;
  String params;
  String token;
  String response;
  String time;

  NetBean(this.url, this.params, this.token, this.response,this.time);
}

class NetUtils {
  static Function netTimeOutBack;

  static Map<String,NetBean> netMap = HashMap();

  static void init(HttpOptionsModel options) {
    dio.options.baseUrl = options.baseUrl;
    dio.options.connectTimeout = options.connectTimeout;
    dio.options.receiveTimeout = options.receiveTimeout;
    dio.options.headers = options.headers;
  }

  ///
  /// 网络超时需要退出到登录 各个组件自己回调
  ///
  static void setNetTimeOutBack(Function netTimeOutBackListener){
    netTimeOutBack = netTimeOutBackListener;
  }


  static Future<ResultData> get(String url, {CancelToken cancelToken, bool loading = false}) async {
    Response response;
    try {
      if(loading == true) {
        EasyLoading.show(status: '请求发送中...');
      }
      if (null == cancelToken) {
        cancelToken = CancelToken();
      }
      response = await dio.get(BaseApi.BASE_URL + url, cancelToken: cancelToken);
      EasyLoading.dismiss();
    } on DioError catch (e) {
      EasyLoading.dismiss();
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = -2; //NETWORK_TIMEOUT
      }
      netMap["${App.topStackWidget}-$url"] = NetBean(url, null, SpUtil.getString(SpUtil.token), response.toString(),DateUtil.getNowDateByYYYYMMDDHHMMSS());
      LogUtil.iNet(url, response.toString(), params: "\ntoken:${SpUtil.getString(SpUtil.token)}",baseUrl: BaseApi.BASE_URL);
      printLog("抛出异常：${e.message}\n");
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message),
          false,
          errorResponse.statusCode,
          0);
    }
    netMap["${App.topStackWidget}-$url"] = NetBean(url, null, SpUtil.getString(SpUtil.token), response.toString(),DateUtil.getNowDateByYYYYMMDDHHMMSS());
    LogUtil.iNet(url, response.toString(),params: "get-token:${SpUtil.getString(SpUtil.token)}",baseUrl: BaseApi.BASE_URL);
    // 过滤器
    CommonResult result = new CommonResult.fromJson(response.data);
    //1成功,0失败
    if (result.code == 200) {
      return new ResultData(result.data, true, result.code, result.total,
          msg: result.msg);
    } //token过期去登录
    else if (result.code == 401) {
      try {
        DialogUtils.showWindow(App.context, ConfirmLoginWindow(() {
          SpUtil.remove(SpUtil.token);
          SpUtil.remove(SpUtil.login);
          BaseConstants.isBaseLogin = false;
          BaseConstants.token = null;
          dio.options.headers.remove("Authorization");
          dio.options.headers.remove("X-Access-Token");
          SpUtil.putBool(SpUtil.isLogin, false);
          App.pop(App.context);
          if(null!=netTimeOutBack)
            netTimeOutBack();
        }));
      } catch (e) {
        printLog("进入catch");
      }
    } else {
      return new ResultData(result.data, false, result.code, result.total,
          msg: result.msg);
    }
  }

  static Future<ResultData> post(String url, Map<String, dynamic> params,
      {CancelToken cancelToken, bool loading = false,bool isUseBaseUrl = true}) async {
    Response response;
    try {
      if(loading == true) {
        EasyLoading.show(status: '请求发送中...');
      }
      if (null == cancelToken) {
        cancelToken = CancelToken();
      }
      response = await dio.post(isUseBaseUrl ? BaseApi.BASE_URL + url : url,
          data: params, cancelToken: cancelToken);
      EasyLoading.dismiss();
    } on DioError catch (e) {
      EasyLoading.dismiss();
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = -2; //NETWORK_TIMEOUT
      }
      netMap["${App.topStackWidget}-$url"] = NetBean(url, params.toString(), SpUtil.getString(SpUtil.token), response.toString(),DateUtil.getNowDateByYYYYMMDDHHMMSS());
      LogUtil.iNet(url, response.toString(), params: params.toString()+"\ntoken:${SpUtil.getString(SpUtil.token)}",baseUrl: isUseBaseUrl?BaseApi.BASE_URL:"");
      printLog("抛出异常：${e.message}\n");
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message),
          false,
          errorResponse.statusCode,
          0);
    }
    netMap["${App.topStackWidget}-$url"] = NetBean(url, params.toString(), SpUtil.getString(SpUtil.token), response.toString(),DateUtil.getNowDateByYYYYMMDDHHMMSS());
    LogUtil.iNet(url, response.toString(), params: params.toString()+"\npost-token:${SpUtil.getString(SpUtil.token)}",baseUrl: isUseBaseUrl?BaseApi.BASE_URL:"");
    // 过滤器
    CommonResult result = new CommonResult.fromJson(response.data);
    //1成功,0失败
    if (result.code == 200) {
      return new ResultData(result.data, true, result.code, result.total,
          msg: result.msg);
    }
    //token过期去登录
    else if (result.code == 401) {
      printLog("进入401");
      try {
        DialogUtils.showSingleWindow(App.context, ConfirmLoginWindow(() {
          DialogUtils.isShowWindow  = false;
          SpUtil.remove(SpUtil.token);
          SpUtil.remove(SpUtil.login);
//          BaseConstants.login = null;
          BaseConstants.isBaseLogin = false;
          BaseConstants.token = null;
          dio.options.headers.remove("Authorization");
          SpUtil.putBool(SpUtil.isLogin, false);
          App.pop(App.context);
          if(null!=netTimeOutBack)
            netTimeOutBack();
        }));
      } catch (e) {}
    } else {
      return new ResultData(result.data, false, result.code, result.total,
          msg: result.msg);
    }
  }

  ///下载文件
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      printLog('downloadFile success---------${response.data}');
    } on DioError catch (e) {
      printLog('downloadFile error---------$e');
    }
    return response.data;
  }

  ///取消网络请求
  void cancelRequests(CancelToken token) {
    token.cancel();
  }

  static Future<ResultData> uploadFile(String url, String filePath,
      {CancelToken cancelToken, String uploadFilePath = "",Map<String,dynamic> requestMap}) async {
    print(
        "\n--------------------------------------------请求start--------------------------------------------\n\n");
    print("请求url：${BaseApi.BASE_URL + url}\n");
    print("请求token：${dio.options.headers["Authorization"]}\n");
    print("请求token：${dio.options.headers["X-Access-Token"]}\n");
    print("请求参数：$filePath\n");

    Map<String,dynamic> fileMap = {
      "filePath": uploadFilePath,
      "file": await MultipartFile.fromFile(filePath),
    };
    if(null !=requestMap){
      fileMap.addAll(requestMap);
    }
    var formData = FormData.fromMap(fileMap);
    Response response;
    Map();
    try {
      if (null == cancelToken) {
        cancelToken = CancelToken();
      }
      Map<String, String> map = new Map();
      map["Content-Type"] = "multipart/form-data";
      //options: new Options(contentType:"multipart/form-data",headers: map),
      response = await dio.post(BaseApi.BASE_URL + url,
          data: formData, cancelToken: cancelToken);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = -2; //NETWORK_TIMEOUT
      }
      print("抛出异常：${e.message}\n");
      print(
          "\n--------------------------------------------请求end--------------------------------------------\n\n");
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message),
          false,
          errorResponse.statusCode,
          0);
    }
    print("请求结果：$response\n");
    print(
        "\n--------------------------------------------请求end--------------------------------------------\n\n");
    // 过滤器
    CommonResult result = new CommonResult.fromJson(response.data);
    //1成功,0失败
    if (result.code == 200) {
      return new ResultData(result.data, true, result.code, result.total,
          msg: result.msg);
    } else {
      return new ResultData(result.data, false, result.code, result.total,
          msg: result.msg);
    }
  }

  static Future<ResultData> uploadAvatar(
      String url, String filePath,
      {CancelToken cancelToken,String uploadFilePath =""}) async {
    print(
        "\n--------------------------------------------请求start--------------------------------------------\n\n");
    print("请求url：${BaseApi.BASE_URL + url}\n");
    print("请求token：${dio.options.headers["Authorization"]}\n");
    print("请求参数：$filePath\n");

    var formData = FormData.fromMap({
      "avatarfile": await MultipartFile.fromFile(filePath),
    });
    Response response;
    try {
      if (null == cancelToken) {
        cancelToken = CancelToken();
      }
      Map<String, String> map = new Map();
      map["Content-Type"] = "multipart/form-data";
      //options: new Options(contentType:"multipart/form-data",headers: map),
      response = await dio.post(BaseApi.BASE_URL + url,
          data: formData, cancelToken: cancelToken);
    } on DioError catch (e) {
      Response errorResponse;
      if (e.response != null) {
        errorResponse = e.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        errorResponse.statusCode = -2; //NETWORK_TIMEOUT
      }
      print("抛出异常：${e.message}\n");
      print(
          "\n--------------------------------------------请求end--------------------------------------------\n\n");
      return new ResultData(
          Code.errorHandleFunction(errorResponse.statusCode, e.message),
          false,
          errorResponse.statusCode,
          0);
    }
    print("请求结果：$response\n");
    print(
        "\n--------------------------------------------请求end--------------------------------------------\n\n");
    // 过滤器
    CommonResult result = new CommonResult.fromJson(response.data);
    //1成功,0失败
    if (result.code == 200) {
      return new ResultData(result.data, true, result.code, result.total,
          msg: result.msg);
    } else {
      return new ResultData(result.data, false, result.code, result.total,
          msg: result.msg);
    }
  }

  ///
  /// 上报本地版本
  /// 友创测试包使用
  ///
  static void postVersionByNet(String packageName,String buildNumber) async{
    if(BaseConstants.isYCApp){
      String deviceId = await DeviceUtil.getDeviceUniqueId();
      var request = {
        "apkPackageName":packageName,
        "versionNumber":buildNumber,
        "equNumber":deviceId,
      };
      await NetUtils.post(BaseApi.postVersion, request,isUseBaseUrl: false);
    }
  }
}

class UrlBuilder {
  var url = "";

  var and = '&';

  UrlBuilder(this.url);

  void get() {
    url += '?';
  }

  void addParam(String k, dynamic v) {
    if (url.endsWith('?')) {
      url += '$k=$v';
    } else {
      url += '&$k=$v';
    }
  }

  String build() {
    return url;
  }
}

class HttpOptionsModel {
  var baseUrl = "";
  var connectTimeout = 300000;
  var receiveTimeout = 300000;
  Map<String, dynamic> headers;

  HttpOptionsModel(this.baseUrl,
      {this.connectTimeout = 300000, this.receiveTimeout = 300000, this.headers});
}
