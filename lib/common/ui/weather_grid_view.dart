import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/base/dialog_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/common/widget/weather/bg/weather_bg.dart';
import 'package:flutter_base/common/widget/weather/utils/weather_type.dart';
import 'package:flutter_base/provide/CommonProvider.dart';
import 'package:flutter_base/res/index_res.dart';
import 'package:flutter_base/res/res_colors.dart';


/// 已宫格的形式展示多样的天气效果
/// 同时，支持切换列数
class WeatherGridViewWidget extends StatefulWidget {
  @override
  _GridViewWidgetState createState() => _GridViewWidgetState();
}

class _GridViewWidgetState extends State<WeatherGridViewWidget> {
  int _count = 2;
  int weatherBgIndex = 0;
  CommonProvider commonProvider;

  @override
  Widget build(BuildContext context) {

    if(0 == weatherBgIndex)
      weatherBgIndex =  BaseConstants.getWeatherBgIndex(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: BaseConstants.getAppMainColor(context),
          title: Center(child: textStyle("主题切换",color: ResColors.white,fontSize: ResSize.text_16),),
          actions: [
            PopupMenuButton<int>(
              itemBuilder: (context) {
                return <PopupMenuEntry<int>>[
                  ...[1, 2, 3, 4, 5,]
                      .map((e) => PopupMenuItem<int>(
                            value: e,
                            child: Text("$e"),
                          ))
                      .toList(),
                ];
              },
              onSelected: (count) {
                setState(() {
                  _count = count;
                });
              },
            )
          ],
        ),
        body: Container(
          child: GridView.count(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            crossAxisCount: _count,
            childAspectRatio: 2,
            children: WeatherType.values
                .map((e) => GridItemWidget(
                      weatherType: e,
                      weatherBgIndex: weatherBgIndex,
                      refresh: (v){
                        showConfirmDialog(context, (){
                          setState(() {
                            weatherBgIndex = v;
                          });
                          BaseConstants.setWeatherBgIndex(v,context);
                          SystemNavigator.pop();
                        },message: "切换主题需要退出应用，确认执行？");
                      },
                      count: _count,
                    ))
                .toList(),
          ),
        ));
  }
}

class GridItemWidget extends StatelessWidget {
  final WeatherType weatherType;
  final int count;
  Function refresh;
  int weatherBgIndex =0;

  GridItemWidget({Key key, this.weatherType, this.count,this.refresh,this.weatherBgIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var radius = 20.0 - 2 * count;
    return Card(
      elevation: 6,
      margin: EdgeInsets.only(left: 4,bottom: 4,right: 4,top: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: InkWell(
        onTap: (){
          refresh(weatherType.index);
        },
        child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius+1),
            border: Border.all(width:weatherBgIndex == weatherType.index?1:0,color: ResColors.red_e2)
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius))),
          child: Stack(
            children: [
              WeatherBg(
                weatherType: weatherType,
                width: MediaQuery.of(context).size.width / count,
                height: MediaQuery.of(context).size.width / count,
              ),
              Center(
                child: Text(
                  WeatherUtil.getWeatherDesc(weatherType),
                  style: TextStyle(
                      color: Colors.white, fontSize: 30 / count, fontWeight: FontWeight.bold),
                ),
              ),
              if(weatherBgIndex == weatherType.index)
                Positioned(
                    bottom: 5,
                    right: 3,
                    child: Icon(Icons.check_circle,color: ResColors.red_e2,size: 15,))
            ],
          ),
        ),
      ),),
    );
  }
}
