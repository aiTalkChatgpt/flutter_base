import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/api/baseApi.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/res/res_font.dart';
import 'package:flutter_base/utils/dialog_utils.dart';
import 'package:image_picker/image_picker.dart';

import 'base_function.dart';


///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 5/8/22 5:34 PM
///     desc   : 图片扩展类
///     version: v1.0
/// </pre>
///
// ignore: camel_case_types, must_be_immutable
class buildAddPhotoView extends StatefulWidget {

  final Function backFunction;
  int maxCount = 3;
  String label = "拍照留痕：";
  List<PhotoFileBean> initPathList;
  Color hintColor;
  Color imgBgColor;
  bool isShowAdd = true;

  buildAddPhotoView(this.backFunction, {this.maxCount,this.label,this.initPathList,this.hintColor,this.isShowAdd,this.imgBgColor});

  @override
  State<StatefulWidget> createState() {
    return AddPhotoViewState();
  }
}

class AddPhotoViewState extends State<buildAddPhotoView> {

  final ImagePicker _picker = ImagePicker();
  List<PhotoFileBean> pathList = [];
  List<Widget> photoWidgets = [];

  @override
  void initState() {
    super.initState();

    pathList.clear();
    photoWidgets.clear();

    if(null!=widget.initPathList){
      widget.initPathList.forEach((element) {
        pathList.add(element);
      });
      widget.initPathList.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    if(null==widget.isShowAdd){
      widget.isShowAdd =true;
    }

    photoWidgets.clear();

    for(int i=0;i<pathList.length;i++){
      photoWidgets.add(_buildFileImageView(i));
    }

    printLog("pathList:${pathList.length}");
    return _buildTakePhotoTextView();
  }

  _buildTakePhotoTextView(){
    return Row(
      children: [
        Container(
          width: 110,
          padding: EdgeInsets.only(left: 10),
          child: textStyle(widget.label,
              isTextAlignLeft: true,
              color: widget.hintColor??Colors.black87,
              fontSize: ResSize.text_14),
        ),
        Row(children: photoWidgets,),
        if(widget.isShowAdd)
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: InkWell(
            onTap: () {
              _showChooseImageDialog();
            },
            child: Image.asset(
              getImgPath("ic_add_empty"),
              width: 50,
              height: 50,
            ),
          ),),
      ],
    );
  }

  _buildFileImageView(int position) {
    PhotoFileBean fileBean =pathList[position];
    bool isNet = pathList[position].isNetData;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 8, top: 8),
          child: InkWell(
            onTap: () {
              previewImage(context, isNet?BaseApi.BASE_URL+fileBean.filePath:fileBean.filePath, isLocationImage: !isNet,bgColor: widget.imgBgColor);
            },
            child: fileBean.isNetData?Image.network(
              BaseApi.BASE_URL + fileBean.filePath,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
              errorBuilder: (c, e, s) {
                return Image.asset(
                  getImgPath("icon_image_failed"),
                  width: 50,
                  height: 50,
                );
              },
            ):Image.file(
              File(fileBean.filePath),
              fit: BoxFit.cover,
              width: 50,
              height: 50,
            ),
          ),
        ),
        if(widget.isShowAdd)
        Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              onTap: () {
                pathList.removeAt(position);
                setState(() {});
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20, bottom: 20),
                child: Image.asset(
                  getImgPath("ic_close_black"),
                  fit: BoxFit.cover,
                  width: 12,
                  height: 12,
                ),
              ),
            ))
      ],
    );
  }

  void _showChooseImageDialog() {
    DialogUtils.showBottomSheet(
      context,
      [
        CupertinoActionSheetAction(
          child: Text('拍照'),
          onPressed: () {
            _chooseImageByLocal(true);
            pop(context);
          },
        ),
        CupertinoActionSheetAction(
          child: Text('相册'),
          onPressed: () {
            _chooseImageByLocal(false);
            pop(context);
          },
        )
      ],
      title: '选择照片',
    );
  }

  ///从本地选取图片
  void _chooseImageByLocal(bool isCamera) async {
    try {
      PickedFile imageFile = await _picker.getImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery,
          maxWidth: 1920,
          maxHeight: 1080,
          imageQuality: 30);
      if (null == imageFile) {
        show("图片格式问题，请换一张");
        return;
      }
      try {
        int size = await File(imageFile.path).length();
        printLog("选择图片大小：${size / 1024}k");

      }catch (e) {
      }
      if(pathList.length < widget.maxCount){
        pathList.add(PhotoFileBean(getEndNameByUrl(imageFile.path), imageFile.path,isNetData: false));
        photoWidgets.clear();
        for(int i=0;i<pathList.length;i++){
          photoWidgets.add(_buildFileImageView(i));
        }
        widget.backFunction(pathList);
        setState(() {});
      }else{
        show("最多添加${widget.maxCount}张图片");
      }

    } catch (e) {
      printLog("$e");
    }
  }
}

class PhotoFileBean{
  String fileName;
  String filePath;
  bool isNetData = false;

  PhotoFileBean(this.fileName, this.filePath,{this.isNetData});
}