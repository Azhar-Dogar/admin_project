import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../extras/colors.dart';

class BandProfile extends StatefulWidget {
  const BandProfile({super.key});

  @override
  State<BandProfile> createState() => _BandProfileState();
}

class _BandProfileState extends State<BandProfile> {
  late double width, height;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Band Profile",
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        bandInfo(),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: "Band Members",
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),

            ButtonWidget(
                textColor: Colors.black, background: CColors.primary, borderColor: Colors.black,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => bandDialogue());
                },
                buttonName: "Add Band Member",
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                ))
          ],
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.grey.shade900),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: CustomText(
                text: "R",
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            )),
        CustomText(
          text: "Riz",
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
        SizedBox(
          height: height * 0.05,
        ),
        CustomText(
          text: "Gallery",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(
          height: height * 0.01,
        ),
        Container(
          color: Colors.grey.shade900,
          width: width * 0.1,
          height: height * 0.2,
          child: const Icon(
            Icons.add_circle_outline,
            color: Colors.white,
          ),
        )
      ],
    );
  }
  Widget editDialogue(){
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      backgroundColor: Colors.grey.shade800,
      content: SizedBox(
        width: width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "About",
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextFieldWidget(
                    maxLines: 3,
                    controller: controller,
                    hint: "Enter Description",),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3),
                        child: CustomText(
                          text: "cancel",
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration( color: Colors.yellow,borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: CustomText(text: "Update",color: Colors.black,),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  Widget bandDialogue(){
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      backgroundColor: Colors.grey.shade800,
      content: SizedBox(
        width: width * 0.45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Brand Invite",
                    color: Colors.yellow,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Divider(),
            SizedBox(
              height: height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextFieldWidget(
                      controller: controller,
                      hint: "Search for band members",),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.yellow),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 3),
                        child: CustomText(
                          text: "cancel",
                          color: Colors.yellow,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Container(
                    decoration: BoxDecoration( color: Colors.yellow,borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                      child: CustomText(text: "Invite",color: Colors.black,),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  Widget bandInfo() {
    return Row(
      children: [
        Container(
          height: height * 0.25,
          width: width * 0.2,
          color: Colors.grey.shade900,
          child: Icon(
            Icons.architecture_rounded,
            color: Colors.grey.shade600,
            size: 60,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
            height: height * 0.25,
            color: Colors.grey.shade900,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Bandyo",
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      CustomText(
                        text: "joined 08/10/23",
                        color: Colors.grey,
                      ),
                      CustomText(
                        text: "About",
                        color: Colors.grey,
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: (){
                      showDialog(context: context, builder: (_)=>editDialogue());
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
