import 'package:admin_project/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';
import '../../widgets/text_field_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController c1 = TextEditingController();
  TextEditingController c2 = TextEditingController();
  TextEditingController c3 = TextEditingController();
  TextEditingController c4 = TextEditingController();
  TextEditingController c5 = TextEditingController();
  TextEditingController c6 = TextEditingController();
  bool isEdit = false;
  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.white30),
        color: Colors.white12,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: "Profile",
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 20,
              ),
              ButtonWidget(
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {isEdit = !isEdit;},
                buttonName: "",
                background: Colors.white12,
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, top: 15, right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 5),
                          CustomText(
                            text: "Avatar",
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const ClipOval(
                              child: Icon(
                                Icons.person,
                                size: 120,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Account Information",
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            const SizedBox(height: 40),
                            fieldRow(c1,c2, "Username","Email ID","Username","Email"),
                            const SizedBox(height: 20,),
                            fieldRow(c3,c4, "Mobile Number","Facebook","Enter your mobile number","Facebook"),
                            const SizedBox(height: 20,),
                            fieldRow(c5,c6, "Twitter","Instagram","Twitter","Instagram"),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget fieldRow(TextEditingController c1, TextEditingController c2, String header1, String header2, String hint1, String hint2) {
    return Row(
      children: [
        fieldWidget(c1, header1, hint1),
        const SizedBox(width: 20),
        fieldWidget(c2, header2, hint2),
      ],
    );
  }

  Widget fieldWidget(TextEditingController c1, String header, String hint) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: header,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 15,
          ),
          const SizedBox(
            height: 10,
          ),
          TextFieldWidget(
            height: 20,
            controller: c1,
            hint: hint,
          ),
        ],
      ),
    );
  }
}
