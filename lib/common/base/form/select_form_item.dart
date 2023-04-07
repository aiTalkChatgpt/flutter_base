import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/entry/key_value.dart';

import 'form-item.dart';


class SelectFormItemWidget extends StatelessWidget {
  final String label;
  final dynamic value;
  final String hintText;
  final List<KeyValue> options;
  final Function onChanged;
  final Function onEditChange;
  final Function onClickBack;
  final bool isShowQueryEdit;

  const SelectFormItemWidget(
      {Key key,
      this.label,
      this.value,
      this.isShowQueryEdit,
      this.onChanged,
      this.onClickBack,
      this.options,
      this.onEditChange,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var text;
    if (options != null && options.isNotEmpty) {
      if(options.length == 1){
        options.add(options[0]);
        text =
            (options.firstWhere((element) => element.value == value, orElse: () {
              return null;
            }))?.key;
        options.removeAt(1);
      }else{
        text =
            (options.firstWhere((element) => element.value == value, orElse: () {
              return null;
            }))?.key;
      }
    }

    return FormItemWidget(
      label: label,
      contentBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            if(null!=isShowQueryEdit && isShowQueryEdit==true){
              onClickBack();
            }
            var index = options.indexWhere((element) => element.value == value);
            BrnMultiDataPicker(
              context: context,
              title: '',
              delegate: Brn1RowDelegate(options,firstSelectedIndex: index),
              confirmClick: (list) {
                var selectValue = options[list[0]].value;
                if (selectValue != null && selectValue != value && onChanged != null) {
                  onChanged(selectValue);
                }
              },
            ).show();
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
                if (value == null || value == '' || text == null)
                  Text(
                    hintText ?? "请选择",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14.0, color: Color(0xffa4a4a4)),
                  )
                else
                  Expanded(child: Text(
                    null!=text?"$text" : "",
                    style: TextStyle(fontSize: 14.0),
                  )),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        );
      },
    );
  }
}


class Brn1RowDelegate implements BrnMultiDataPickerDelegate {
  int firstSelectedIndex = 0;
  int secondSelectedIndex = 0;
  int thirdSelectedIndex = 0;

  List<KeyValue> list = [];

  Brn1RowDelegate(this.list,{this.firstSelectedIndex = 0, this.secondSelectedIndex = 0});

  @override
  int numberOfComponent() {
    return 1;
  }

  @override
  int numberOfRowsInComponent(int component) {
    return list.length;
  }

  @override
  String titleForRowInComponent(int component, int index) {
    return list[index].key;
  }

  @override
  double rowHeightForComponent(int component) {
    return null;
  }

  @override
  selectRowInComponent(int component, int row) {
    if (0 == component) {
      firstSelectedIndex = row;
    } else if (1 == component) {
      secondSelectedIndex = row;
    } else {
      thirdSelectedIndex = row;
    }
  }

  @override
  int initSelectedRowForComponent(int component) {
    if (0 == component) {
      return firstSelectedIndex;
    }
    return 0;
  }
}
