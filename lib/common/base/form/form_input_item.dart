import 'package:flutter/material.dart';

class FormInPutItemWidget extends StatelessWidget {
  final String label;
  final ValueChanged onChanged;
  final TextEditingController controller;
  final String hintText;
  final String suffixText;
  final Widget suffix;
  final Widget Function(BuildContext context) contentBuilder;
  final double height;

  const FormInPutItemWidget(
      {Key key,
      this.label,
      this.onChanged,
      this.controller,
      this.hintText,
      this.suffixText,
      this.suffix,
      this.contentBuilder,
      this.height = 40.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.0,
      padding: EdgeInsets.only(left: 10, right: 10),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          if (label != null && label != '')
            Container(
              height: 50.0,
              width: 100.0,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                label,
                style: TextStyle(fontSize: 14.0, color: Colors.black87),
              ),
            ),
          Expanded(
            child: contentBuilder != null
                ? contentBuilder(context)
                : Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 10, right: 10,top: 2,bottom: 2),
                    decoration: BoxDecoration(
                        color: Color(0xfff5f5f5),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: TextField(
                      maxLines: 5,
                      minLines: 1,
                      style: TextStyle(fontSize: 14.0),
                      controller: controller,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: hintText,
                          hintStyle: TextStyle(
                              fontSize: 14.0, color: Color(0xffa4a4a4))),
                    ),
                  ),
          ),
          if (suffix != null) suffix,
          if (suffix == null && suffixText != null)
            Text(
              suffixText,
              style: TextStyle(fontSize: 14.0),
            )
        ],
      ),
    );
  }
}
