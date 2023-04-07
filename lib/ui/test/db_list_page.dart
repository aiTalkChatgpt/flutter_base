import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/common_widget.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/entry/car.dart';
import 'package:flutter_base/provide/DbProvider.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';

///
/// <pre>
///     author : SZYC
///     e-mail : 
///     time   : 3/3/22 3:25 PM
///     desc   : 
///     version: v1.0
/// </pre>
///
class DbListPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return DbListState();
  }

}
class DbListState extends ListViewState<DbListPage>{

  DbProvider _provider;

  @override
  List buildList() {
    List<Car> list = Provider.of<DbProvider>(context).carList ?? [];
    return list;
  }

  @override
  Widget buildListItemView(Object object, int index) {
    Car car = object;
    return Padding(padding: EdgeInsets.only(left: 10,right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Gaps.vGap10,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textStyle("id:${car.id.toString()}"),
          RoundedDivButton("删除",onTap: (){
            _provider.deleteCar(context, car);
            _provider.getCarList();
          },width: 80,height: 40,fontSize: 14,)
        ],),
      textStyle(car.newText),
      textStyle(car.brand),
      textStyle(car.endText),
    ],),);
  }

  @override
  getDataByNet(bool isRefresh, int page, int size) {
    _provider.getCarList();
  }

  @override
  String getTitle() {
    return "数据库测试";
  }

  @override
  initProvider(BuildContext context) {
    _provider = Provider.of<DbProvider>(context);
  }

  @override
  bool isUsePage() {
    return true;
  }

  @override
  Function onClickFloatingActionButton() {
    return (){
      _provider.addCar(Car(brand: "新增"));
      _provider.getCarList();

    };
  }
}