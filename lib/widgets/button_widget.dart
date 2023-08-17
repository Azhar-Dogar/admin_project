import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, required this.buttonName,  this.icon,this.onPressed});
  String buttonName;
  Icon? icon;
  void Function()? onPressed;
  @override
  late double width, height;
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height * 0.06,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.yellow),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 5),
          child: Row(
            children: [
              icon??const SizedBox(),
              CustomText(
                text: buttonName,
                color: Colors.black,
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
