import 'package:admin_project/extras/colors.dart';
import 'package:admin_project/extras/functions.dart';
import 'package:admin_project/screens/Dashboard_screen.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:utility_extensions/utility_extensions.dart';

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
          decoration:
              BoxDecoration(border: Border.all(color: CColors.borderColor)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 75.0, vertical: 20),
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
                CustomText(
                  text: "Email or username",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: height * 0.06,
                    child: Center(
                        child: TextFieldWidget(
                            controller: emailController,
                            hint: "Enter your email or username"))),
                const SizedBox(
                  height: 30,
                ),
                CustomText(
                  text: "Password",
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: height * 0.06,
                  child: Center(
                    child: TextFieldWidget(
                      controller: passwordController,
                      hint: "Enter your password",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (v) {},
                        ),
                        CustomText(
                          text: "Remember me",
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        )
                      ],
                    ),
                    CustomText(
                      text: "Forgot Password?",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100,),
                  ),
                  onPressed: () {
                    if(!emailController.text.isValidEmail){
                      Functions.showSnackBar(context, "Please enter a valid email");
                    }else if(passwordController.text.length < 8){
                      Functions.showSnackBar(context, "Password should contain at least 8 characters.");
                    }else{
                      signin();
                    }
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  signin() {
    Functions.showLoaderDialog(context);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) {
      context.pushAndRemoveUntil(child: const DashBoardScreen());
    }).catchError((error) {
      context.pop();
      FirebaseAuthException exception = error;
      Functions.showSnackBar(context, exception.message ?? "");
    });
  }
}
