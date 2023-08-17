import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    required this.controller,
    required this.hint,
    this.textInputType,
    this.suffix,
    this.onChanged,
    this.maxLines = 1,
    this.secureText,
    this.showBorder = false,
    this.prefixWidget,
    this.fontSize,
    this.backColor,
    this.onSubmitted,
    this.height,
    Key? key,
  }) : super(key: key);
  void Function(String)? onChanged;
  void Function(String)? onSubmitted;
  TextEditingController controller;
  TextInputType? textInputType;
  String hint;
  double? height;
  int maxLines;
  bool? secureText;
  bool showBorder;
  Color? backColor;
  Widget? suffix;
  Widget? prefixWidget;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefixWidget != null)
          Row(
            children: [
              prefixWidget!,
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        Expanded(
          child: TextField(
            keyboardType: textInputType,
            inputFormatters: [
              if(textInputType == TextInputType.phone)...[
                FilteringTextInputFormatter.allow(RegExp(r'^\+?\d*')),
              ],
            ],
            style: TextStyle(color: Colors.grey.shade400),
            onSubmitted: onSubmitted,
            onChanged: onChanged,
            controller: controller,
            maxLines: maxLines,
            obscureText: secureText ?? false,
            decoration: InputDecoration(
              //contentPadding: EdgeInsets.zero,
              hintText: hint,
              border: InputBorder.none,
              // isDense: true,
              hintStyle: TextStyle(fontSize: 16,color: Colors.grey.shade500)),
            ),
          ),
        suffix??Container()
      ],
    );
  }
}
