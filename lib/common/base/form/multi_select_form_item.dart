import 'package:flutter/material.dart';
import 'package:flutter_base/common/BaseConstants.dart';
import 'package:flutter_base/common/base/base_function.dart';
import 'package:flutter_base/entry/key_value.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/utils/common_picker.dart';

import '../../../export.dart';

class MultiSelectFormItemWidget extends StatelessWidget {
  final String label;
  final List<dynamic> value;
  final String hintText;
  final List<KeyValue> options;
  final Function onChanged;

  const MultiSelectFormItemWidget(
      {Key key,
      this.label,
      this.value,
      this.onChanged,
      this.options,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<KeyValue> selectedList = options.where((element) => value.contains(element.value)).toList();
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (label != null && label != '')
            Container(
              width: 100.0,
              padding: EdgeInsets.only(top: 10),
              child: Text(
                label,
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
            ),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                //新选择方式
                List<BrnMultiSelectBottomPickerItem> items = [];
                options.forEach((element) {
                  items.add(BrnMultiSelectBottomPickerItem(element.value ?? "",element.key ?? "",isChecked: value.contains(element.value)));
                });
                BrnMultiSelectListPicker.show(
                  context,
                  items: items,
                  pickerTitleConfig: BrnPickerTitleConfig(titleContent: ""),
                  onSubmit: (List<BrnMultiSelectBottomPickerItem> data) {
                    List<dynamic> result = [];
                    data.forEach((element) {
                      result.add(element.code);
                    });
                    if (onChanged != null) {
                      onChanged(result);
                    }
                    Navigator.of(context).pop(result);
                  },
                );
                //老的选择方式
//                var result = CommonPicker.showMultiPicker(
//                    context: context, options: options, value: value);
//                result.then((selectValue) {
//                  if (selectValue != null &&
//                      onChanged != null) {
//                    onChanged(selectValue);
//                  }
//                });
              },
              child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Color(0xfff5f5f5),
                      borderRadius: BorderRadius.circular(4.0)),
                  child: (value == null || value.length == 0)
                      ? Row(children: [
                        Expanded(child: Text(
                          hintText ?? "请选择",
                          style: TextStyle(
                              fontSize: 14.0, color: Color(0xffa4a4a4)),
                        )),
                    Icon(Icons.keyboard_arrow_down)
                  ],)
                      : Row(children: [
                    Expanded(child: Wrap(
                        spacing: 5,
                        runSpacing: 5,
                        children: selectedList
                            .map((item) => Container(
                            padding: EdgeInsets.only(
                                top: 2, bottom: 2, left: 4, right: 4),
                            decoration: BoxDecoration(
                                color: BaseConstants.getAppMainColor(context).withAlpha(30),
                                borderRadius: BorderRadius.circular(14.0)),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                      text: item.key,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black87)),
                                  WidgetSpan(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (onChanged != null) {
                                            value.remove(item.value);
                                            onChanged(value);
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Icon(
                                            Icons.cancel,
                                            size: 14.0,
                                            color: BaseConstants.getAppMainColor(context).withAlpha(120),
                                          ),
                                        ),
                                      ))
                                ]),
                              ),
                            )))
                            .toList())),
                    Icon(Icons.keyboard_arrow_down)
                  ],)),
            ),
          ),
        ],
      ),
    );
  }
}
