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
                onPressed: () {
                  showDialog(context: context, builder: (_) => eventDialogue());
                },
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

  Widget eventDialogue() {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      backgroundColor: Colors.grey.shade900,
      content: SizedBox(
        width: width * 0.45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Create Event",
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
            const Divider(),
            SizedBox(
              height: height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    ButtonWidget(
                      buttonName: "Upload poster",
                      icon: const Icon(
                        Icons.upload,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: "upload only .jpeg's,.png's and .gif's images",
                      color: Colors.grey.shade400,
                      fontSize: 10,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              height: height * 0.05,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: textField("Name")),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(child: textField("Venue")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: textField("Start date and time",
                              isDate: true,
                              hint: "Select start sate and time")),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: textField("End date and time",
                              isDate: true, hint: "Select end date and time")),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textField("Description"),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
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
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: CustomText(
                        text: "Save",
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }

  Widget textField(String name, {String? hint, bool? isDate}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: name),
        Container(
            margin: const EdgeInsets.only(top: 4),
            height: height * 0.06,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                color: Colors.black),
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextFieldWidget(
                          controller: controller,
                          hint: hint ?? "Enter ${name.toLowerCase()}")),
                  if (isDate == true) ...[
                    Row(
                      children: [
                        Container(
                          width: 1,
                          color: Colors.grey.shade500,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.0),
                          child: Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            ))
      ],
    );
  }
}
