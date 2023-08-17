import 'dart:html';
import 'dart:typed_data';

import 'package:admin_project/extras/functions.dart';
import 'package:admin_project/providers/event_provider.dart';
import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../widgets/custom_text.dart';

class EventManagement extends StatefulWidget {
  const EventManagement({super.key});

  @override
  State<EventManagement> createState() => _EventManagementState();
}

class _EventManagementState extends State<EventManagement> {
  TextEditingController controller = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController venue = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  late double width, height;
  late EventProvider eventProvider;
  Uint8List? imageBytes;
  String posterUrl = "";
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Consumer<EventProvider>(
        builder: (BuildContext context, value, Widget? child) {
      eventProvider = value;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          header(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Colors.grey.shade800,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
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
    });
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
                textColor: Colors.black,
                background: CColors.primary,
                borderColor: Colors.black,
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
    File? imageFile;
    return StatefulBuilder(builder:
        (BuildContext context, void Function(void Function()) _setState) {
      return SingleChildScrollView(
        child: AlertDialog(
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
                          onPressed: () async {
                            FilePickerResult? file = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (file != null) {
                              _setState(() {
                                imageBytes = file.files.first.bytes!;
                                imageFile = File(file.files.first.bytes!,
                                    file.files.first.name);
                              });
                            }
                          },
                          textColor: Colors.black,
                          background: CColors.primary,
                          borderColor: Colors.black,
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
                        ),
                        if (imageBytes != null) ...[showImage(_setState)]
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
                          Expanded(child: textField("Name", name)),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(child: textField("Venue", venue)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: textField(
                                  "Start date and time", controller,
                                  isDate: true,
                                  hint: "Select start sate and time",
                                  onPressed: () {})),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: textField("End date and time", controller,
                                  isDate: true,
                                  hint: "Select end date and time",
                                  onPressed: () {})),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textField("Description", description),
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
                      ButtonWidget(
                        background: Colors.black,
                        textColor: CColors.primary,
                        borderColor: CColors.primary,
                        buttonName: "Cancel",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ButtonWidget(
                        background: CColors.primary,
                        textColor: Colors.black,
                        borderColor: CColors.primary,
                        buttonName: "Save",
                        onPressed: () async {
                          if(name.text.trim().isEmpty){
                            Functions.showSnackBar(context, "please enter event name");
                          }
                          else {
                            Functions.showLoaderDialog(context);
                            DateTime now = DateTime.now();
                            if (imageBytes != null) {
                              String url = await eventProvider.uploadAudioWeb(
                                  imageBytes!, "eventImages", imageFile!.name,
                                  context,
                                  contentType: "png");
                              _setState(() {
                                posterUrl = url;
                              });
                            }
                            await eventProvider.addEvent(
                                name.text, venue.text, now, now, posterUrl);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }},
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
        ),
      );
    });
  }

  Widget textField(String name, TextEditingController controller,
      {String? hint, bool? isDate, void Function()? onPressed}) {
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: IconButton(
                            onPressed: onPressed,
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
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

  Widget showImage(void Function(void Function()) _setState) {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 5),
        width: width * 0.1,
        height: height * 0.15,
        child: Image.memory(
          imageBytes!,
          fit: BoxFit.cover,
        ),
      ),
      Positioned(
        right: 1,
        top: 1,
        child: IconButton(
            onPressed: () {
              _setState(() {
                imageBytes = null;
              });
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: CColors.borderColor,
            )),
      )
    ]);
  }
}
