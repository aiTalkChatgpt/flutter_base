import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/entry/key_value.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerWidget extends StatefulWidget {
  final int value;
  final double height;
  final int maxValue;
  final int step;

  const NumberPickerWidget(
      {Key key,
      this.value,
      this.maxValue = 300,
      this.height = 300.0,
      this.step = 1})
      : super(key: key);
  @override
  _NumberPickerState createState() => _NumberPickerState();
}

class _NumberPickerState extends State<NumberPickerWidget> {
  int selectedValue;
  var buttonTextStyle =
      TextStyle(color: Colors.black87, fontWeight: FontWeight.w600);

  @override
  void initState() {
    super.initState();
    selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    NumberPicker picker = NumberPicker.integer(
      initialValue: selectedValue,
      minValue: 0,
      maxValue: widget.maxValue,
      step: widget.step,
      onChanged: (value) => setState(() {
        selectedValue = value;
      }),
      textStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
      selectedTextStyle: TextStyle(fontSize: 14.0, color: Colors.black87),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(), bottom: BorderSide()),
      ),
    );

    return Container(
      color: Colors.grey,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '取消',
                    style: buttonTextStyle,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(selectedValue);
                  },
                  child: Text(
                    '确定',
                    style: buttonTextStyle,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      if (selectedValue > widget.step) {
                        selectedValue -= widget.step;
                        if (selectedValue < 1) selectedValue = 1;
                        picker.animateInt(selectedValue);
                      }
                    },
                  ),
                  picker,
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      if (selectedValue < widget.maxValue) {
                        selectedValue += widget.step;
                        if (selectedValue > widget.maxValue)
                          selectedValue = widget.maxValue;
                        picker.animateInt(selectedValue);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultiPickerWidget extends StatefulWidget {
  final List<dynamic> value;
  final List<KeyValue> options;
  final double height;

  const MultiPickerWidget(
      {Key key, this.options, this.value, this.height = 300.0})
      : super(key: key);

  @override
  _MultiPickerWidgetState createState() => _MultiPickerWidgetState();
}

class _MultiPickerWidgetState extends State<MultiPickerWidget> {

  List<dynamic> selected = [];
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if(widget.value !=null && widget.value.length > 0) {
      setState(() {
        selected = widget.value;
      });
    }
  }
  var buttonTextStyle = TextStyle(color: Colors.black87, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: widget.height,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    '取消',
                    style: buttonTextStyle,
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(selected);
                  },
                  child: Text(
                    '确定',
                    style: buttonTextStyle,
                  ),
                )
              ],
            ),
          ),
          Expanded(child: _buildOptions()),
        ],
      ),
    );
  }

  _buildOptions() {
    return Container(
      color: Colors.white,
      child: ListView(
        children: widget.options.map((item) => CheckboxListTile(
            value: selected.contains(item.value),
            onChanged: (value){
              setState(() {
                if(value) {
                  selected.add(item.value);
                } else {
                  selected.remove(item.value);
                }
              });
            },
            title: Text(
              item.key ?? '',
              style: TextStyle(fontSize: 14.0),
            ),
            controlAffinity: ListTileControlAffinity.leading)).toList(),
      ),
    );
  }
}

class CommonPicker {
  List<KeyValue> mOptions = [];

  static showPicker(
      {BuildContext context,
      List<KeyValue> options,
      dynamic value,
      bool isShowQueryEdit,
      double height = 300.0,
      Function onEditChange}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          var buttonTextStyle =
              TextStyle(color: Colors.black87, fontWeight: FontWeight.w600);
          int index = (options.map((e) => e.value)).toList().indexOf(value);
          var controller =
              FixedExtentScrollController(initialItem: index == -1 ? 0 : index);
          return Container(
            color: Colors.grey,
            height: height,
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.grey[200],
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          '取消',
                          style: buttonTextStyle,
                        ),
                      ),
                      Visibility(
                        visible: null!=isShowQueryEdit && isShowQueryEdit == true,
                        child: Container(
                          width: 100,
                          child: TextField(
                            style: TextStyle(fontSize: 12),
                            keyboardType: TextInputType.text,
                            maxLines: 5,
                            minLines: 1,
                            onChanged: (value){
                              onEditChange(value);
                            },
                            decoration: InputDecoration(
                              hintText: "请输入名称搜索",
                              contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              isDense: false,
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          print(options[controller.selectedItem]
                              .value
                              .runtimeType);
                          Navigator.of(context)
                              .pop(options[controller.selectedItem].value);
                        },
                        child: Text(
                          '确定',
                          style: buttonTextStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: CupertinoPicker(
                    scrollController: controller,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    itemExtent: 32.0,
                    onSelectedItemChanged: (index) {
                      print(index);
                    },
                    children: options
                        .map((item) => Text(
                              item.key,
                              style: TextStyle(fontSize: 16.0),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static showMultiPicker(
      {BuildContext context,
      List<KeyValue> options,
      List<dynamic> value,
      double height = 300.0}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return MultiPickerWidget(options: options, value: value, height: height,);
        });
  }

  static showNumPicker(
      {BuildContext context,
      int value,
      double height = 300.0,
      int maxValue = 300,
      int step = 1}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return NumberPickerWidget(
            value: value,
            height: height,
            maxValue: maxValue,
            step: step,
          );
        });
  }
}
