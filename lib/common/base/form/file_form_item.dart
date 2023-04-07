import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/common_widget.dart';
import 'package:flutter_base/utils/string_utils.dart';

import '../../../../common/base/base_function.dart';
import 'form-item.dart';

class FileFormItemWidget extends StatefulWidget {
  final String label;
  final String fileType;
  final String defualtImage;
  final String defaultImagePath;
  final dynamic value;
  final String hintText;
  final Function onChanged;

  FileFormItemWidget(
      {Key key,
      this.label,
      this.fileType,
      this.value,
      this.defualtImage,
      this.defaultImagePath,
      this.onChanged,
      this.hintText});

  @override
  State<StatefulWidget> createState() {
    return FileFormItemState(label,value,hintText,onChanged,defualtImage,defaultImagePath,fileType);
  }

}

class FileFormItemState extends State<FileFormItemWidget>{

  final String label;
  String fileType = "file";
  String defualtImage = "ic_defaut_file";
  dynamic value;
  final String hintText;
  final Function onChanged;
  final String defaultImagePath;
  List<String> filePaths;
  String imagePath = "";

  FileFormItemState(this.label, this.value, this.hintText, this.onChanged,this.defualtImage,this.defaultImagePath,this.fileType);

  @override
  Widget build(BuildContext context) {
    List<String> filePaths;
    String fileName;

    printLog("defaultImagePath:$defaultImagePath");
    return FormItemWidget(
      label: label,
      contentBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FileType type = FileType.any;
            if(fileType == "image"){
              type = FileType.image;
            }
            FilePicker.getFilePath(type: type).then((filePath) => {
              if(filePath.contains("/")){
                filePaths = filePath.split("/"),
                fileName = filePaths[filePaths.length-1]
              },
              setState((){
                if(fileType == "image"){
                  imagePath = filePath;
                }
                value =fileName;
              }),
              onChanged(filePath)
            });
          },
          child: Container(
            height: 40.0,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(4.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (value == null || value == '')
                  Text(
                    hintText ?? "请选择",
                    style: TextStyle(fontSize: 14.0, color: Color(0xffa4a4a4)),
                  )
                else
                  Expanded(
                    child: Text(
                      value ?? "",
                      style: TextStyle(fontSize: 14.0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                null!=defaultImagePath && ""!=defaultImagePath?buildNetImageView(defaultImagePath, context,imageWidth: 20,isIntoBigImagePage: true):
                null==imagePath || imagePath == ""?
                Image(width: 20,height: 20, image: AssetImage(getImgPath(defualtImage ?? "ic_defaut_file"))):
                Image.file(File(imagePath),width: 20,height: 20,),
              ],
            ),
          ),
        );
      },
    );
  }

}
