import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  bool isSec1 = true;
  bool isSec2 = true;
  bool isSec3 = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black26,
        border: Border.all(color: Colors.white, width: 0.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: "Change Password", color: Colors.lightGreenAccent,fontSize: 20,fontWeight: FontWeight.bold,),
                ButtonWidget(textColor: Colors.white, background: Colors.black26, borderColor: Colors.black26,buttonName: "", icon: const Icon(Icons.close, color: Colors.white,), onPressed: (){},),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
          height: 0.5,
            decoration: BoxDecoration(
              color: Colors.white30,
              border: Border.all(color: Colors.white, width: 0.5),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                CustomText(text: "Current password", color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white30,width: 0.5),
                  ),
                  child: TextFieldWidget(
                    controller: c1,
                    hint: 'Enter Your Current Password',
                    secureText: isSec1,
                    icon: const Icon(Icons.lock_open),
                    suffix: ButtonWidget(textColor: Colors.black, background: Colors.black, borderColor: Colors.black,buttonName: "",icon: isSec1? Icon(Icons.visibility, color: Colors.white,):Icon(Icons.visibility_off, color: Colors.white),
                      onPressed: (){setState(() {
                        isSec1 = !isSec1;
                      });},),),
                ),
                const SizedBox(height: 30,),
                CustomText(text: "New password", color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white30,width: 0.5),
                  ),
                  child: TextFieldWidget(
                    controller: c2,
                    hint: 'Enter Your New Password',
                    secureText: isSec2,
                    icon: const Icon(Icons.lock_open),
                    suffix: ButtonWidget(textColor: Colors.black, background: Colors.black, borderColor: Colors.black,buttonName: "",icon: isSec2? Icon(Icons.visibility, color: Colors.white,):Icon(Icons.visibility_off, color: Colors.white),
                      onPressed: (){setState(() {
                        isSec2 = !isSec2;
                      });},),),
                ),
                const SizedBox(height: 30,),
                CustomText(text: "Confirm new password", color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold,),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.white30,width: 0.5),
                  ),
                  child: TextFieldWidget(
                    controller: c3,
                    hint: 'Enter Your New Current Password Again',
                    secureText: isSec3,
                    icon: const Icon(Icons.lock_open),
                    suffix: ButtonWidget(textColor: Colors.black, background: Colors.black, borderColor: Colors.black,buttonName: "",icon: isSec3? Icon(Icons.visibility, color: Colors.white,):Icon(Icons.visibility_off, color: Colors.white),
                      onPressed: (){setState(() {
                        isSec3 = !isSec3;
                      });},),),
                ),
                const SizedBox(height: 30,),

              ],
            ),
          )

    ],
      ),
    );
  }
}
