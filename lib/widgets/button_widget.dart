import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, this.buttonName,  this.icon,this.onPressed, this.background});
  String? buttonName;
  Icon? icon;
  Color? background;
  void Function()? onPressed;
  @override
  late double width, height;
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        decoration: BoxDecoration(border: Border.all(color: Colors.lightGreenAccent),borderRadius: BorderRadius.circular(16),color: background ?? Colors.lightGreenAccent),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
          child: Row(
            children: [
              icon??const SizedBox(),
              CustomText(
                text: buttonName!,
                color: background==Colors.black?Colors.lightGreenAccent:Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
