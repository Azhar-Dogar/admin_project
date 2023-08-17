import 'dart:typed_data';

import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SongsManagement extends StatefulWidget {
  const SongsManagement({super.key});

  @override
  State<SongsManagement> createState() => _SongsManagementState();
}

class _SongsManagementState extends State<SongsManagement> {
  TextEditingController controller = TextEditingController();
  late double width, height;
  @override
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
                  text: "Title",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Duration",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Genre",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Location",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Uploaded on",
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  text: "Live",
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
              text: "All Songs",
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
                      controller: controller,
                      hint: "Search Songs",
                      backColor: Colors.black,
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            ButtonWidget(
                onPressed: () {
                  showDialog(context: context, builder: (_) => songDialogue());
                },
                buttonName: "Upload Song",
                icon: const Icon(
                  Icons.upload,
                  color: Colors.black,
                )),
          ],
        )
      ],
    );
  }

  Widget songDialogue() {
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: "Upload Song",
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    ButtonWidget(buttonName: "Upload poster"),
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
                Column(
                  children: [
                    ButtonWidget(buttonName: "Upload song",onPressed: () async {
                     FilePickerResult? file = await FilePicker.platform.pickFiles(type: FileType.audio);
                     if(file != null){
                    uploadAudioWeb(file.files.first.bytes!, "songs", context);
                     print("file name");
                     print(file.files.first.name);
                    }},),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: "Upload only .mp3 and .wav songs",
                      color: Colors.grey.shade400,
                      fontSize: 10,
                    )
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: textField("Title")),
                      const SizedBox(width: 10,),
                      Expanded(child: textField("City")),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  textField("Genres"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
  Widget textField(String name){
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: name),
        Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade500),color: Colors.black),
            child: TextFieldWidget(controller: controller, hint: "Enter ${name.toLowerCase()}"))
      ],
    );
  }
  static Future<String> uploadAudioWeb(
      Uint8List file, String child, BuildContext context,
      {String contentType = "audio/mpeg"}) async {
    try {
      final firebaseStorage.FirebaseStorage storage =
          firebaseStorage.FirebaseStorage.instance;

      var reference = storage.ref().child(child);

      var r = await reference.putData(
          file, firebaseStorage.SettableMetadata(contentType: contentType));
      if (r.state == firebaseStorage.TaskState.success) {
        String url = await reference.getDownloadURL();
        return url;
      } else {
        throw PlatformException(code: "404", message: "No download link found");
      }
    } catch (e) {
      rethrow;
    }
  }
}
