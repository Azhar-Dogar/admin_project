import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'package:admin_project/extras/colors.dart';
import 'package:admin_project/extras/functions.dart';
import 'package:admin_project/providers/song_provider.dart';
import 'package:http/http.dart' as http;
import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SongsManagement extends StatefulWidget {
  const SongsManagement({super.key});

  @override
  State<SongsManagement> createState() => _SongsManagementState();
}

class _SongsManagementState extends State<SongsManagement> {
  TextEditingController title = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController searchController = TextEditingController();
  late double width, height;
  Uint8List? fileBytes;
  Uint8List? imageBytes;
  String selectedValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Provider.of<SongProvider>(context,listen: false).getGenre();
  }
  late SongProvider songProvider;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Consumer<SongProvider>(
      builder: (BuildContext context, value, Widget? child) {
      songProvider = value;
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
      );}
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
                      controller: searchController,
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
    if(selectedValue == ""){
    selectedValue = songProvider.genreModel!.genre.first;}
    File? tempFile;
    File? imageFile;
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) _setState) {
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
                      ButtonWidget(buttonName: "Upload poster",onPressed: () async {
                        FilePickerResult? file = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        if(file !=null){
                          _setState((){
                            imageBytes = file.files.first.bytes!;
                            imageFile = File(file.files.first.bytes!, "");
                          });
                        }

                      },),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: "upload only .jpeg's,.png's and .gif's images",
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                      if(imageBytes != null)...[
                      showImage(_setState)]
                    ],
                  ),
                  Column(
                    children: [
                      ButtonWidget(
                        buttonName: "Upload song",
                        onPressed: () async {
                          FilePickerResult? file = await FilePicker.platform
                              .pickFiles(type: FileType.audio);
                          if (file != null) {
                            _setState(() {
                              tempFile = File(file.files.first.bytes!, "first");
                              print(tempFile);
                              fileBytes = file.files.first.bytes;
                              title.text = file.files.first.name.split(".").first;
                            });
                            //  print("file name");
                            //  print(file.files.first.name);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomText(
                        text: "Upload only .mp3 and .wav songs",
                        color: Colors.grey.shade400,
                        fontSize: 10,
                      ),
                      if (fileBytes != null) ...[
                        showMusic(_setState)
                      ]
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
                        Expanded(child: textField("Title", title)),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: textField("City", city, onChanged: (v) {
                          autoCompleteCity(v);
                        })),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    dropDown(_setState),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonWidget(background: Colors.black,buttonName: "Cancel",),
                    const SizedBox(
                      width: 10,
                    ),
                    ButtonWidget(buttonName: "Save",onPressed: () async {
                      if(fileBytes != null){
                        Functions.showLoaderDialog(context);
                      String url = await songProvider.uploadAudioWeb(fileBytes!, "songs", context);
                      songProvider.uploadSong(title.text, city.text,selectedValue,"", url);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      }else{
                         Functions.showSnackBar(context, "Please pick a song");
                      }},)
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      );}
    );
  }
  Widget showMusic(void Function(void Function()) _setState){
    return Stack(
      children: [
        Container(
        margin: const EdgeInsets.only(top: 5),
        width: width * 0.1,
        height: height * 0.15,
        color: Colors.yellow,
        child: const Icon(Icons.music_video_outlined),
      ),
      Positioned(
          top: 1,
          right: 1,
          child: IconButton(onPressed:(){
            _setState((){
              fileBytes = null;
            });
          }, icon: Icon(Icons.cancel_outlined,color: CColors.borderColor,)))
      ]
    );
  }
 Widget showImage(void Function(void Function()) _setState){
    return Stack(
      children: [Container(
        margin: const EdgeInsets.only(top: 5),
        width: width * 0.1,
        height: height * 0.15,
        child: Image.memory(imageBytes!,fit: BoxFit.cover,),
      ),
      Positioned(
        right: 1,
        top: 1,
        child: IconButton(onPressed:(){
          _setState((){
            imageBytes = null;
          });
        }, icon: Icon(Icons.cancel_outlined,color: CColors.borderColor,)),
      )
      ]
    );
 }
  Widget textField(String name, TextEditingController controller,
      {void Function(String)? onChanged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: name),
        const SizedBox(height: 5,),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade500),
                color: Colors.black),
            child: TextFieldWidget(
                onChanged: onChanged,
                controller: controller,
                hint: "Enter ${name.toLowerCase()}"))
      ],
    );
  }

 Widget dropDown(void Function(void Function()) _setState){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Genre",fontSize: 16,fontWeight: FontWeight.w600,),
        const SizedBox(height: 5,),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all(color: CColors.borderColor),color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: TextStyle(color: CColors.borderColor),
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        _setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: songProvider.genreModel!.genre
                          .map<DropdownMenuItem<String>>(
                            (value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
 }
  Future<List<String>> autoCompleteCity(String input) async {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=(cities)&key=AIzaSyCNNmfTGsBatXy77JEAcjxuHCR2WSxVhvg'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final predictions = data['predictions'] as List<dynamic>;
      List<String> citySuggestions = [];
      for (var prediction in predictions) {
        citySuggestions.add(prediction['description']);
      }
      return citySuggestions;
    } else {
      throw Exception('Failed to load city suggestions');
    }
  }
}
