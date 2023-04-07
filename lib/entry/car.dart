import 'package:flutter/cupertino.dart';

class Car {
  int id;
  String brand = "一个必然的";
  String type = "1";
  String newText = "一个newType";
  String endText = "一个endText";
  bool start;

  Car({@required this.brand, this.type, this.start = false,this.newText,this.endText});
//
//  bool toggleCompleted() {
//    return !completed;
//  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['brand'] = brand;
    map['type'] = type;
    map['endText'] = endText;
    map['newText'] = newText;
    map['start'] = start == true ? 1 : 0;
    return map;
  }

  //  Extract a Task from a MAP object
  Car.fromMapObject(Map<String, dynamic> map) {
    this.id = map['id'];
    this.newText = map['newText'];
    this.brand = map['brand'];
    this.type = map['type'];
    this.endText = map['endText'];
    this.start = map['start'] == 1 ? true : false;
  }
}