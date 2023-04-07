import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/entry/key_value.dart';

class RadioFormItemWidget extends StatelessWidget {
  final String label;
  final dynamic value;
  final List<KeyValue> options;
  final Function onChanged;

  const RadioFormItemWidget({
    Key key,
    this.label,
    this.value,
    this.onChanged,
    this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10, right: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          if (label != null && label != '')
            Container(
              width: 100.0,
              child: Text(
                label,
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
            ),
          Expanded(
            child: Container(
                height: 40,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    color: Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(4.0)),
                child: Wrap(
                  children: options
                      .map((e) => Container(
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Radio(
                                    value: e.value,
                                    groupValue: value,
                                    onChanged: onChanged,
                                    visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                                  ),
                                ),
                                WidgetSpan(
                                    child: GestureDetector(
                                  onTap: () {
                                    onChanged(e.value);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Text(
                                      e.key ?? '',
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ))
                              ]),
                            ),
                          ))
                      .toList(),
                )),
//                child: Wrap(
//                  children: options
//                      .map((e) => Container(
//                    width: 80,
//                    child: Row(
//                      children: <Widget>[
//                        Radio(
//                          value: e.value,
//                          groupValue: value,
//                          onChanged: onChanged,
//                        ),
//                        GestureDetector(
//                          onTap: () {
//                            onChanged(e.value);
//                          },
//                          child: Text(
//                            e.key ?? '',
//                            style: TextStyle(fontSize: 14.0),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ))
//                      .toList(),
//                )),
          ),
        ],
      ),
    );
  }
}
