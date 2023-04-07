import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_filereader/flutter_filereader.dart';
import 'package:path_provider/path_provider.dart';

import '../base_function.dart';
import '../page_ktx_widget.dart';
import 'my_app_bar.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2021/7/12 11:11 AM
///     desc   : 
///     version: v1.0
/// </pre>
///
// ignore: must_be_immutable
class FileViewPage extends StatefulWidget{

  String filePath;

  FileViewPage(this.filePath);

  @override
  State<StatefulWidget> createState() {
    return FileViewState(filePath);
  }

}
class FileViewState extends State<FileViewPage>{

  String filePath;
  String localFilePath;

  FileViewState(this.filePath);

  @override
  void initState() {
    super.initState();
    downloadFileByNet(BaseApi.baseImgUrl+filePath);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:  _buildAppBar(),
      body: null==localFilePath || ""==localFilePath ? Center(child: Text("暂无数据"),) :FileReaderView(filePath: localFilePath,),
    );
  }

  _buildAppBar() {
    return MyAppBar(
      backgroundColor: BaseConstants.getAppMainColor(context),
      title: new Text(
        "附件查看",
        style: new TextStyle(color: ResColors.white, fontSize: 16),
      ),
      centerTitle: true,
      elevation: 4,
    );
  }


  Future downloadFileByNet(String url) async {
    EasyLoading.show(status: '文件加载中...');
    /// 创建存储文件
    Directory storageDir = await getExternalStorageDirectory();
    String storagePath = storageDir.path;
    var spit = url.split(".");
    File file = new File('$storagePath/goods-manager-temp_file.${spit[spit.length-1]}');
    printLog("file.path:${file.path}");
    printLog("file.path:${file.length()}");
    printLog("file.existsSync:${file.existsSync()}");
    if (!file.existsSync()) {
      // 不存在则创建
      file.createSync();
    }
    printLog("file.existsSync-end:${file.existsSync()}");
    try {
      /// 发起下载请求
      printLog("response.url:${url}");
      Response response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
          )
      );
      /// 读取文件
      file.writeAsBytesSync(response.data);
      localFilePath = file.path;
      printLog("localFilePath:${localFilePath}");
      setState(() {

      });
      EasyLoading.dismiss();
      return file;
    } catch (e) {
      EasyLoading.dismiss();
      return file;
    }
  }

}