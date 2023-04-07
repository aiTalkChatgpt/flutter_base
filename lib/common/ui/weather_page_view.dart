import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/widget/weather/bg/weather_bg.dart';
import 'package:flutter_base/common/widget/weather/utils/weather_type.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 普通的 ViewPager 展示样式
// ignore: must_be_immutable
class WeatherViewWidget extends StatelessWidget {

  double width = 0;
  double height = 0;
  int initIndex;
  PageController controller;
  bool isScroll = false;

  WeatherViewWidget({this.width, this.height,this.initIndex});

  @override
  Widget build(BuildContext context) {

    if(width == 0) width = ScreenUtil().screenWidth;
    if(height == 0) height = ScreenUtil().screenHeight;
    if(initIndex==null || 0==initIndex){
      initIndex = BaseConstants.getWeatherBgIndex(context);
    }

    controller = PageController(initialPage: initIndex);

    return Container(
      height: height,
      child: GestureDetector(
        onHorizontalDragDown: (v){
          isScroll = true;
        },
        child: PageView.builder(
          onPageChanged: (index){
            if(isScroll){
              BaseConstants.setWeatherBgIndex(index,context);
              isScroll = false;
            }
          },
          controller: controller,
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return WeatherBg(
              weatherType: WeatherType.values[index],
              width: width,
              height: height,
            );
          },
          itemCount: WeatherType.values.length,
        ),),
    );
  }

  animateToWeatherIndex(int index){
    if(null!=controller){
      if (controller.hasClients)
        controller.animateToPage(index, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut,);
    }
  }
}

