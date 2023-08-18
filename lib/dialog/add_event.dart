import 'dart:html';
import 'dart:typed_data';

import 'package:admin_project/providers/event_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:provider/provider.dart';

import '../extras/colors.dart';
import '../extras/functions.dart';
import '../model/event_model.dart';
import '../widgets/button_widget.dart';
import '../widgets/custom_text.dart';
import '../widgets/text_field_widget.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({
    super.key,
    this.eventModel,
  });

  final EventModel? eventModel;

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController startTime = TextEditingController();
  TextEditingController endTime = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController venue = TextEditingController();
  TextEditingController description = TextEditingController();
  var format = DateFormat("dd/MM/yyyy hh:mm a");

  @override
  void initState() {
    if (widget.eventModel != null) {
      startTime.text = format.format(widget.eventModel!.startDate);
      endTime.text = format.format(widget.eventModel!.endDate);

      name.text = widget.eventModel!.name;
      venue.text = widget.eventModel!.venue;
      description.text = widget.eventModel!.description;
      posterUrl = widget.eventModel!.posterUrl;
    }
    super.initState();
  }

  Uint8List? imageBytes;
  String posterUrl = "";
  File? imageFile;

  late double width, height;

  late EventProvider eventProvider;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Consumer<EventProvider>(builder: (context, provider, child) {
      eventProvider = provider;
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
                        onPressed: () async {
                          FilePickerResult? file = await FilePicker.platform
                              .pickFiles(type: FileType.image);
                          if (file != null) {
                            setState(() {
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
                      if (imageBytes != null || posterUrl.isNotEmpty) ...[showImage()]
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
                            "Start date and time",
                            startTime,
                            isDate: true,
                            hint: "Select start sate and time",
                            onPressed: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
                                  context: context);

                              if (dateTime != null) {
                                startTime.text = format.format(dateTime);
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: textField(
                            "End date and time",
                            endTime,
                            isDate: true,
                            hint: "Select end date and time",
                            onPressed: () async {
                              DateTime? dateTime = await showOmniDateTimePicker(
                                  context: context);
                              if (dateTime != null) {
                                endTime.text = format.format(dateTime);
                              }
                            },
                          ),
                        ),
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
                        if (imageBytes == null && posterUrl.isEmpty) {
                          Functions.showSnackBar(
                              context, "Please select an image");
                        } else if (!validate(
                            [startTime, endTime, name, venue, description])) {
                          Functions.showSnackBar(
                              context, "Please fill all required fields");
                        } else {
                          Functions.showLoaderDialog(context);

                          if (imageBytes != null) {
                            String url = await eventProvider.uploadAudioWeb(
                              imageBytes!,
                              "eventImages",
                              imageFile!.name,
                              context,
                              contentType: "png",
                            );
                            posterUrl = url;
                          }
                          await eventProvider.addEvent(
                            name.text,
                            venue.text,
                            format.parse(startTime.text),
                            format.parse(endTime.text),
                            posterUrl,
                            description.text,
                          );



                          Navigator.pop(context);
                          Navigator.pop(context);
                        }
                      },
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
    });
  }

  Widget showImage() {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 5),
        width: width * 0.1,
        height: height * 0.15,
        child: imageBytes != null ? Image.memory(
          imageBytes!,
          fit: BoxFit.cover,
        ) : Image.network(posterUrl,           fit: BoxFit.cover,),
      ),
      Positioned(
        right: 1,
        top: 1,
        child: IconButton(
            onPressed: () {
              setState(() {
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
                      enabled: !(isDate ?? false),
                      hint: hint ?? "Enter ${name.toLowerCase()}",
                    ),
                  ),
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

  bool validate(List<TextEditingController> controllers) {
    for (var controller in controllers) {
      if (controller.text.trim().isEmpty) {
        return false;
      }
    }
    return true;
  }
}
