import 'package:flutter/material.dart';
import 'package:flutter_base/utils/time_utils.dart';
import 'package:intl/intl.dart';

import 'form-item.dart';


class TimeFormItemWidget extends StatelessWidget {
  final String label;
  final dynamic value;
  final String hintText;
  final Function onChanged;
  final String format;

  const TimeFormItemWidget(
      {Key key,
      this.label,
      this.value,
      this.onChanged,
      this.hintText,
      this.format})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormItemWidget(
      label: label,
      contentBuilder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            TimeUtils.showBottomSheetTimePicker(context,
                    (selectTime, list) {
                  String time = DateFormat(format ?? "yyyy-MM-dd HH:mm:ss").format(selectTime);
                  if (time != null && time != value && onChanged != null) {
                    onChanged(time);
                  }
                }, format: format ?? "yyyy-MM-dd HH:mm:ss",currentTime: value);
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
                  Text(
                    value ?? "",
                    style: TextStyle(fontSize: 14.0),
                  ),
                Icon(Icons.keyboard_arrow_down),
              ],
            ),
          ),
        );
      },
    );
  }
}
