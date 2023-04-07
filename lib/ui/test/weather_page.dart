import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/permission_ktx.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/common/widget/weather/bg/weather_bg.dart';
import 'package:flutter_base/common/widget/weather/utils/weather_type.dart';
import 'package:flutter_base/export.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/utils/device_util.dart';


///
/// <pre>
///     author : SZYC
///     e-mail :
///     time   : 3/22/22 5:26 PM
///     desc   :
///     version: v1.0
/// </pre>
///
class WeatherPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WeatherState();
  }
}
class WeatherState extends AppBarViewState{


  List<Widget> widgets = [];

  @override
  void initState() {
    super.initState();
    WeatherType.values.forEach((element) {
      widgets.add(Container(
        margin: EdgeInsets.only(left: 5,right: 5,top: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(44),
          border: Border.all(width: 1,color: ResColors.color_AAAAAA)
        ),
        child: Stack(children: [
          WeatherBg(
            weatherType: element,
            width: screenDpW,
            height: 100,
          )
        ],)));
    });

  }


  @override
  Widget buildBody() {
    return SingleChildScrollView(child: Column(children: widgets,),);
  }


  @override
  String getTitle() {
    return "天气";
  }

}