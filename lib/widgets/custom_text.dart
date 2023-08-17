
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
   CustomText({super.key,required this.text,this.fontSize,this.fontWeight,this.color});
String text;
double? fontSize;
FontWeight? fontWeight;
Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(fontSize: fontSize,color: color ?? Colors.white,fontWeight: fontWeight),);
  }
}
