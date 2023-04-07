import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/base/page_ktx_widget.dart';
import 'package:flutter_base/common/base/text_ktx_widget.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/res/res_font.dart';

import '../../export.dart';
import 'base_function.dart';


///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 5/18/22 11:29 AM
///     desc   : 图标
///     version: v1.0
/// </pre>
///


///
/// 多条折线图，单条适用
/// [
///  chartList:[],线数据
///  lineColor：线颜色
/// ]
///
buildLineChartView(List<LineChartList> pieChartList,BuildContext context,{bool isCurve = false}){
  if(isNullList(pieChartList)) return textStyle("");

  List<BrnPointsLine> lines = [];
  List<BrnDialItem> _xDialValue = [];
  double maxY = 0.0;
  double minY = 0.0;
  int maxSize = 0;
  List<BrnDialItem> yDialValues = [];
  Map _xDialMap = Map();

  pieChartList.forEach((element) {
    List<ChartList> chartList = element.chartList;
    List<BrnPointData> points = [];
    maxSize = max(maxSize,chartList.length);
    for (int index = 0; index < chartList.length; index++) {
      if(minY == 0.0)
        minY = double.tryParse(chartList[index].y1);
      maxY = max(double.tryParse(chartList[index].y1),maxY);
      minY = min(double.tryParse(chartList[index].y1),minY);
      points.add(BrnPointData(
          pointText: chartList[index].y1,
          x: index.toDouble(),
          y: double.tryParse(chartList[index].y1),
          lineTouchData: BrnLineTouchData(
              tipWindowSize: Size(80, 40),
              onTouch: () {
                return Container(
                  decoration: BoxDecoration(
                    color: Color(0xff0984F9),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all( 0),
                    child: textStyle("${string2int(chartList[index].y1)}个\n${chartList[index].x}",
                        color: ResColors.white,fontSize: ResSize.text_12,isTextAlignLeft: true),
                  ),);
              })));

      _xDialMap[index] = chartList[index].x;
    }

    //多条线
    lines.add( BrnPointsLine(
      isShowPointText: false,
      isShowXDial: true,
      lineWidth: 3,
      pointRadius: 4,
      isShowPoint: true,
      isCurve: isCurve,
      points: points,
      shaderColors: [element.lineColor.withOpacity(0.3), element.lineColor.withOpacity(0.01)],
      lineColor: element.lineColor,
    ));
  });

  //去除重复的x
  _xDialMap.forEach((key, value) {
    _xDialValue.add(BrnDialItem(
      dialText: value,
      dialTextStyle: TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
      value: key.toDouble(),
    ));
  });
  printLog("maxY:$maxY,minY:$minY,maxSize:$maxSize");
  //计算纵坐标轴距
  double dValue = (maxY-minY) / 6;
  for (int index = 0; index <= 6; index++) {
    yDialValues.add(BrnDialItem(
      dialText: '${(dValue + index * dValue).ceil()}个',
      dialTextStyle: TextStyle(fontSize: 11.0, color: Color(0xFF999999)),
      value: (dValue + index * dValue).ceilToDouble(),
    ));
  }

  return BrnBrokenLine(
    contentPadding: EdgeInsets.only(left: 30),
    showPointDashLine: true,
    yHintLineOffset: 45,
    isTipWindowAutoDismiss: false,
    isShowYHintLine: false,
    lines: lines,
    size: Size(maxSize * 55.0,
        MediaQuery.of(context).size.height / 5 * 1.6 + 20 * 2),
    isShowXHintLine: true,
    xDialValues: _xDialValue,
    xDialMin: 0,
    xDialMax: _xDialValue.length.toDouble(),
    yDialValues: yDialValues,
    yDialMin: 0,
    yDialMax: maxY + dValue,
    isHintLineSolid: false,
    isShowYDialText: true,
  );
}

///
/// 柱状图
///
buildBarChartView(List<LineChartList> pieChartList,{double barGroupSpace = 30.0}){
  if(isNullList(pieChartList)) return textStyle("");
  List<AxisItem> axisItemList = [];
  Map _xDialMap = Map();

  List<AxisItem> yAxis = [];

  double maxY = 1.0;
  List<BrnProgressBarBundle> barBundles = [];


  pieChartList.forEach((element) {

    List<BrnProgressBarItem> barList1 = [];

    element.chartList.forEach((element) {
      _xDialMap[element.x] = element.x;

      barList1.add(BrnProgressBarItem(text: element.x,value: double.tryParse(element.y1) ?? 0.0,
          selectedHintText:"${string2int(element.y1)}个\n${element.x}"));

      double value1 = double.tryParse(element.y1) ?? 0.0;
      maxY = maxValue(value1, maxY);
    });

    barBundles.add( BrnProgressBarBundle(barList: barList1, colors: [
      element.lineColor,
      element.lineColor.withOpacity(0.3)
    ]));

  });


  int diff = (maxY / 5.0).round();
  if(diff > 0){
    for(int i=0,y=0;i<maxY;i=i+diff,y++){
      yAxis.add(AxisItem(showText: (diff * (y+1)).toString() + "个"));
    }
  }

  _xDialMap.forEach((key, value) {
    axisItemList.add(AxisItem(showText: key));
  });

  return BrnProgressBarChart(
    barChartStyle: BarChartStyle.vertical,
    selectedHintTextBackgroundColor: Color(0xff0984F9),
    xAxis: ChartAxis(axisItemList: axisItemList),
    barBundleList: barBundles,
    yAxis: ChartAxis(axisItemList:yAxis),
    singleBarWidth: 30,
    barGroupSpace: barGroupSpace,
    barMaxValue: maxY,
    onBarItemClickInterceptor: (barBundleIndex, barBundle, barGroupIndex, barItem) {
      return true;
    },
  );
}

///
/// 饼状图
///
buildPieChart(List<ChartList> chartList,BrnDoughnutDataItem selectedItem,Function backFunction){
  if(isNullList(chartList)) return textStyle("");
  List colors = [
    ResColors.material_red_400,
    ResColors.material_purple_400,
    ResColors.material_indigo_400,
    ResColors.material_lightBlue_400,
    ResColors.material_teal_400,
    Color(0xff0984F9),
    ResColors.material_green_400,
    ResColors.material_yellow_400,
    ResColors.material_brown_400,
    ResColors.material_red_600,
    ResColors.material_purple_600,
    ResColors.material_indigo_600,
    ResColors.material_teal_600,
    ResColors.material_green_600,
    ResColors.material_yellow_600,
    ResColors.material_brown_600,
  ];
  Color color = ResColors.material_teal_400;
  List<BrnDoughnutDataItem> dataList = [];
  List<BrnDoughnutDataItem> labelList = [];
  List<Widget> widgets = [];
  for(var i=0;i<chartList.length;i++){
    ChartList bean = chartList[i];
    widgets.add(_buildPieChartLabelView(chartList[i],chartList[i].x));
    if(i < colors.length){
      color = colors[i];
    }
    dataList.add(BrnDoughnutDataItem(value: double.tryParse(bean.y1),title: "${bean.y1}%\n${bean.x}",color: color));
    labelList.add(BrnDoughnutDataItem(value: double.tryParse(bean.y1),title: "${bean.x}",color: color));
  }
  return Container(
    margin: EdgeInsets.only(left: 10,right: 10,top: 10),
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
        color: ResColors.white),
    width: screenDpW,
    padding: const EdgeInsets.only(right: 5.0, left: 12.0, top: 24, bottom: 12),
    child:Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: 5),
          child:  BrnDoughnutChart(
            padding: EdgeInsets.all(20),
            width: 200,
            height: 200,
            data: dataList,
            selectedItem: selectedItem,
            showTitleWhenSelected: true,
            selectCallback: (BrnDoughnutDataItem selectedItem) {
              backFunction(selectedItem);
            },
          ),
        ),
        DoughnutChartLegend(data: labelList, legendStyle: BrnDoughnutChartLegendStyle.wrap)
      ],
    ),
  );
}

Widget _buildPieChartLabelView(ChartList bean,String title){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Gaps.vGap10,
      Row(
        children: <Widget>[
          Container(height: 10,width: 10,color: ResColors.material_red_400,),
          Gaps.hGap3,
          textStyle("$title  ${bean.x}%",fontSize: ResSize.text_10),
        ],)
    ],);
}

maxValue(double value1,double value2){
  if(value1 > value2)
    return value1;
  else
    return value2;
}


// ------------------------------ 饼图 ------------------------------

getTempDoughnutChartData() {
  return [
    BrnDoughnutDataItem(value: 05, title: "任务一", color: getColor(0)),
    BrnDoughnutDataItem(value: 10, title: "任务二", color: getColor(1)),
    BrnDoughnutDataItem(value: 15, title: "任务三", color: getColor(2)),
    BrnDoughnutDataItem(value: 20, title: "任务四", color: getColor(3)),
    BrnDoughnutDataItem(value: 25, title: "任务四", color: getColor(4)),
    BrnDoughnutDataItem(value: 30, title: "任务四", color: getColor(5)),
    BrnDoughnutDataItem(value: 35, title: "任务四", color: getColor(6)),
  ];
}

buildDoughnutChartView(String title, List<BrnDoughnutDataItem> dataList) {
  if(isNullList(dataList)) return textStyle("");
  return buildCardWidgetView(
    title,
    Padding(
        padding: EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            BrnDoughnutChart(
              padding: EdgeInsets.all(50),
              width: 200,
              height: 200,
              data: dataList,
              showTitleWhenSelected: false,
            ),
            DoughnutChartLegend(data: dataList, legendStyle: BrnDoughnutChartLegendStyle.wrap),
          ],
        )),
  );
}

// ------------------------------ 折线图 ------------------------------

getTempBrokenLineData(int lineSize, int dataSize) {
  List<BrnPointsLine> lines = [];
  for (int i = 0; i < lineSize; i++) {
    List<BrnPointData> points = [];
    for (int j = 1; j <= dataSize; j++) {
      int value = Random().nextInt(120);
      points.add(BrnPointData(pointText: value.toString(), x: j.toDouble(), y: value.toDouble()));
    }
    lines.add(BrnPointsLine(
        isShowXDial: true,
        lineWidth: 3,
        pointRadius: 4,
        isShowPoint: true,
        isCurve: false,
        lineColor: getColor(i),
        points: points));
  }
  return lines;
}

getMonthXBrnDialItemData() {
  List<BrnDialItem> list = [];
  TextStyle textStyle = TextStyle(fontSize: 12.0, color: Color(0xFF999999));
  for (int i = 1; i <= 12; i++) {
    list.add(BrnDialItem(dialText: "$i月", dialTextStyle: textStyle, value: i.toDouble()));
  }
  return list;
}

getWeekXBrnDialItemData() {
  List<String> week = ["周一", "周二", "周三", "周四", "周五", "周六", "周日",];
  List<BrnDialItem> list = [];
  TextStyle textStyle = TextStyle(fontSize: 12.0, color: Color(0xFF999999));
  for (int i = 1; i <= week.length; i++) {
    list.add(BrnDialItem(dialText: week[i - 1], dialTextStyle: textStyle, value: i.toDouble()));
  }
  return list;
}

buildBrokenLineView(context, String title, List<BrnPointsLine> lines, List<BrnDialItem> xBrnDialItemList, int yBrnDialItemSize,{int extraWidth = 0}) {
  if(isNullList(lines)) return textStyle("");
  // Y 坐标刻度
  double maxValue = 0, minValue = 0, meanValue = 1;
  for (int i = 0; i < lines.length; i++) {
    List<BrnPointData> points = lines[i].points;
    for (int j = 0; j < points.length; j++) {
      BrnPointData point = points[j];
      if (point.y > maxValue) maxValue = point.y;
      if (point.y < minValue) minValue = point.y;
    }
  }
  meanValue = (maxValue - minValue) / yBrnDialItemSize;
  List<BrnDialItem> yBrnDialItemList = [];
  for (int i = 0; i <= yBrnDialItemSize; i++) {
    double currentValue = meanValue * i;
    yBrnDialItemList.add(BrnDialItem(
        dialText: currentValue.ceilToDouble().toInt().toString(),
        dialTextStyle: TextStyle(fontSize: 12.0, color: Color(0xFF999999)),
        value: currentValue.ceilToDouble()));
  }

  return buildCardWidgetView(
      title,
      Padding(
        padding: EdgeInsets.only(top: 15, bottom: 15),
        child: BrnBrokenLine(
          size: Size(MediaQuery.of(context).size.width - 50 * 2 + extraWidth,
              MediaQuery.of(context).size.height / 5 * 1.6 - 20 * 2),
          lines: lines,
          xDialMin: 1,
          xDialMax: xBrnDialItemList.length.toDouble(),
          xDialValues: xBrnDialItemList,
          isShowXHintLine: true,
          yDialMin: 0,
          yDialMax: maxValue,
          yDialValues: yBrnDialItemList,
          isShowYDialText: true,
          isHintLineSolid: false,
          showPointDashLine: false,
        ),
      ));
}

// ------------------------------ 柱状图 ------------------------------

getTempProgressBarData() {
  List<BrnProgressBarItem> list = [];
  list.add(BrnProgressBarItem(text: '日调度', value: 12, hintValue: 30));
  list.add(BrnProgressBarItem(text: '周调度', value: 15, hintValue: 30));
  list.add(BrnProgressBarItem(text: '月调度', value: 16, hintValue: 30));
  return list;
}


buildProgressBarView(String title, List<BrnProgressBarItem> dataList, int xBrnDialItemSize) {
  if(isNullList(dataList)) return textStyle("");
  // X 坐标刻度
  double maxValue = 0, meanValue = 1;
  dataList.forEach((element) {
    if (element.value > maxValue) maxValue = element.value;
    if (element?.hintValue ?? 0 > maxValue) maxValue = element.hintValue;
  });
  meanValue = maxValue / xBrnDialItemSize;
  List<AxisItem> xAxisItemList = [];
  for (int i = 0; i <= xBrnDialItemSize; i++) {
    double currentValue = meanValue * i;
    xAxisItemList.add(AxisItem(showText: currentValue.ceilToDouble().toInt().toString()));
  }
  // Y 坐标刻度
  List<AxisItem> yAxisItemList = [];
  dataList.forEach((element) {
    yAxisItemList.add(AxisItem(showText: interceptFixedLengthTextOther(element.text,6)));
  });
  ChartAxis chartAxis = ChartAxis(axisItemList: xAxisItemList);
  return buildCardWidgetView(
    title,
    BrnProgressBarChart(
      barChartStyle: BarChartStyle.horizontal,
      xAxis: chartAxis,
      yAxis: ChartAxis(axisItemList: yAxisItemList),
      singleBarWidth: 30,
      barMaxValue: maxValue,
      barBundleList: [
        BrnProgressBarBundle(
            barList: dataList, colors: [Color(0xff1545FD), Color(0xff0984F9)]),
      ],
    ),
  );
}

// ------------------------------ 颜色 ------------------------------

getColor(int position) {
  List colors = [
    ResColors.material_red_400,
    ResColors.material_purple_400,
    ResColors.material_indigo_400,
    ResColors.material_lightBlue_400,
    ResColors.material_teal_400,
    ResColors.material_green_400,
    ResColors.material_yellow_400,
    ResColors.material_brown_400,
    ResColors.material_red_600,
    ResColors.material_purple_600,
    ResColors.material_indigo_600,
    ResColors.material_teal_600,
    ResColors.material_green_600,
    ResColors.material_yellow_600,
    ResColors.material_brown_600,
  ];
  return colors[position % colors.length];
}


///
/// 折线图实体
///
class LineChartList{

  List<ChartList> chartList;
  Color lineColor = Color(0xff0984F9);

  LineChartList(this.chartList, this.lineColor);
}

/// x : "2020-12"
/// y1 : "0"

class ChartList {
  String _x;
  String _y1;

  String get x => _x;
  String get y1 => _y1;

  ChartList({
    String x,
    String y1}){
    _x = x;
    _y1 = y1;
  }

  ChartList.fromJson(dynamic json) {
    _x = json["x"];
    _y1 = json["y1"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["x"] = _x;
    map["y1"] = _y1;
    return map;
  }

}
