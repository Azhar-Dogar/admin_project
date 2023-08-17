import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/custom_text.dart';

class EventManagement extends StatefulWidget {
  const EventManagement({super.key});

  @override
  State<EventManagement> createState() => _EventManagementState();
}

class _EventManagementState extends State<EventManagement> {
  TextEditingController controller = TextEditingController();
  @override
  late double width, height;
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        header(),
        Container(
          margin: const EdgeInsets.only(top: 10),
          color: Colors.grey.shade800,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Poster",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Event",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Venue",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Start and End Date",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Start Time",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Actions",
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Colors.grey.shade900,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "No Records Found",
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomText(
              text: "Your Events",
              color: Colors.yellow,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: width * 0.16,
              height: height * 0.06,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    Expanded(
                        child: TextFieldWidget(
                            controller: controller, hint: "Search Events"))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            ButtonWidget(
                buttonName: "Create Event",
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                ))
          ],
        )
      ],
    );
  }
}
