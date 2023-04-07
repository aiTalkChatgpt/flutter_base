import 'package:flutter/material.dart';
import 'package:flutter_base/utils/common_picker.dart';

import 'form-item.dart';

class NumberFormItemWidget extends StatelessWidget {
  final String label;
  final int value;
  final String hintText;
  final int maxValue;
  final int step;
  final Function onChanged;
  final double height;

  const NumberFormItemWidget(
      {Key key,
        this.label,
        this.value,
        this.onChanged,
        this.hintText,
        this.maxValue = 300,
        this.step = 1,
        this.height = 40.0
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return FormItemWidget(
      label: label,
      contentBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            var result = CommonPicker.showNumPicker(
                context: context, value: value, maxValue: maxValue, step: step);
            result.then((selectValue) {
              if (selectValue != null &&
                  selectValue != value &&
                  onChanged != null) {
                onChanged(selectValue);
              }
            });
          },
          child: Container(
            height: height,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 5, right: 5),
            decoration: BoxDecoration(
                color: Color(0xfff5f5f5),
                borderRadius: BorderRadius.circular(4.0)),
            child: (value == null ) ? Text(
              hintText ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0, color: Color(0xffa4a4a4)),
            ) : Text(
              value.toString() ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.0),
            ),
          ),
        );
      },
    );
  }
}
