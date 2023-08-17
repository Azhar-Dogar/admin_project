import 'package:admin_project/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/button_widget.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(text: "Profile", fontWeight: FontWeight.w700, color: Colors.white, fontSize: 20,),
              ButtonWidget(icon: const Icon(Icons.edit, color: Colors.white,), onPressed: (){},buttonName: "",background: Colors.black54,),

            ],
          ),

        ],
      ),
    );
  }
}
