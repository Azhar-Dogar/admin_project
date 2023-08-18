import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {super.key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.textAlign = TextAlign.start,});

  String text;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize,
          color: color ?? Colors.white,
          fontWeight: fontWeight),
    );
  }
}
