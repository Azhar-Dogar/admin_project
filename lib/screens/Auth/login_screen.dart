import 'package:admin_project/extras/colors.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  late double width, height;
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: width * 0.5,
          decoration: BoxDecoration(border: Border.all(color:CColors.borderColor)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage("assets/app_icon.png"),
                      width: width * 0.07,
                    ),
                  ],
                ),
                CustomText(text: "Email or username",fontSize: 16,fontWeight: FontWeight.w600,),
                Container(
                    height: height * 0.06,
                    child: Center(child: TextFieldWidget(controller: emailController, hint: "Enter your email or username"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
