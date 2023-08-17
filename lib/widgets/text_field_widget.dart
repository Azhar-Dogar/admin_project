import 'package:admin_project/extras/colors.dart';
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
    this.isEditable = true,
    this.secureText,
    this.showBorder = false,
    this.prefixWidget,
    this.fontSize,
    this.backColor,
    this.onSubmitted,
    this.height,
    this.icon,

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
  Icon? icon;
  bool isEditable;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            readOnly: isEditable,
            obscureText: secureText ?? false,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 5,left: 5),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: CColors.borderColor,width: 1)),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: CColors.borderColor,width: 1)),
              //contentPadding: EdgeInsets.zero,
              hintText: hint,
              border: InputBorder.none,
              prefixIcon: icon,
              // isDense: true,
              hintStyle: TextStyle(fontSize: 16,color: Colors.grey.shade500)),
            ),
          ),
        suffix??Container()
      ],
    );
  }
}
