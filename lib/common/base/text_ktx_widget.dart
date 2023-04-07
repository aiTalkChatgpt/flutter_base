import 'package:flutter/material.dart';
import 'package:flutter_base/res/res_colors.dart';
import 'package:flutter_base/res/res_font.dart';

///
/// <pre>
///     author : pengMaster
///     e-mail : 
///     time   : 2/22/22 8:06 PM
///     desc   : 文字公共组件
///     version: v1.0
/// </pre>
///

Widget textStyle(String text,
    {bool isFontSize12 = false,
      bool isTextAlignLeft = false,
      textAlign: TextAlign.center,
      fontSize: ResSize.text_default,
      FontStyle fontStyle,
      FontWeight fontWeight,
      bool isExpanded = false, // 自动伸缩 打包有问题 别用
      int flex = 1,
      AlignmentGeometry alignment, // 对齐方式
      color: ResColors.text_black, int maxLines = 99}) {
  final _text = Text(
    text ?? '',
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: isTextAlignLeft ? TextAlign.left : textAlign,
    style: TextStyle(
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      fontSize: isFontSize12 ? 12 : fontSize,
      color: color,
    ),
  );

  final alignText = (alignment != null
      ? Align(
    alignment: alignment,
    child: _text,
  )
      : _text);

  if (isExpanded) {
    return Expanded(child: alignText, flex: flex);
  }

  return alignText;
}

/// [discard] 注意该方法已过时, 推荐使用 textStyle
Expanded expadTextStyle(String text,
    {bool isFontSize12 = false,
      bool isTextAlignLeft = false,
      TextAlign textAlign = TextAlign.center,
      fontSize: ResSize.text_default,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: ResColors.text_black}) =>
    Expanded(
      child: textStyle(text,
          textAlign: textAlign,
          fontSize: fontSize,
          color: color,
          fontStyle: fontStyle,
          fontWeight: fontWeight,
          isFontSize12: isFontSize12,
          isTextAlignLeft: isTextAlignLeft),
    );