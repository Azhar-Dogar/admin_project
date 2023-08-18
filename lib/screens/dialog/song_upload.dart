import 'dart:convert';
import 'dart:typed_data';
import 'dart:html';
import 'package:admin_project/model/song_model.dart';
import 'package:admin_project/providers/song_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../extras/colors.dart';
import '../../extras/functions.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/custom_text.dart';
import 'package:http/http.dart' as http;
import '../../widgets/text_field_widget.dart';

class SongUpload extends StatefulWidget {
  const SongUpload({Key? key, this.model, required this.songProvider})
      : super(key: key);

  final SongModel? model;
  final SongProvider songProvider;

  @override
  _SongUploadState createState() => _SongUploadState();
}

class _SongUploadState extends State<SongUpload> {
  late double width, height;

  TextEditingController title = TextEditingController();
  TextEditingController city = TextEditingController();

  File? tempFile;
  File? imageFile;

  Uint8List? fileBytes;
  Uint8List? imageBytes;

  String selectedValue = "";
  String songUrl = "";
  String posterUrl = "";

  SongModel? model;

  @override
  void initState() {
    super.initState();

    if (widget.model != null) {
      model = widget.model;
    }
    if (widget.model == null) {
      if (selectedValue == "") {
        selectedValue = widget.songProvider.genreModel!.genre.first;
      }
    } else {
      selectedValue = widget.model!.genre;
      title.text = widget.model!.title;
      city.text = widget.model!.city;
    }
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

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
                    text: widget.model == null ? "Upload Song" : "Edit Song",
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
                    ),
                  )
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
                    ButtonWidget(
                      background: CColors.primary,
                      textColor: Colors.black,
                      borderColor: CColors.primary,
                      buttonName: "Upload poster",
                      onPressed: () async {
                        FilePickerResult? file = await FilePicker.platform
                            .pickFiles(type: FileType.image);
                        if (file != null) {
                          setState(() {
                            imageBytes = file.files.first.bytes!;
                            imageFile = File(
                                file.files.first.bytes!, file.files.first.name);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: "upload only .jpeg's,.png's and .gif's images",
                      color: Colors.grey.shade400,
                      fontSize: 10,
                    ),
                    if (imageBytes != null || widget.model != null) ...[
                      showImage()
                    ]
                  ],
                ),
                Column(
                  children: [
                    ButtonWidget(
                      background: CColors.primary,
                      textColor: Colors.black,
                      borderColor: CColors.primary,
                      buttonName: "Upload song",
                      onPressed: () async {
                        FilePickerResult? file = await FilePicker.platform
                            .pickFiles(type: FileType.audio);

                        if (file != null) {
                          setState(() {
                            tempFile = File(
                                file.files.first.bytes!, file.files.first.name);
                            fileBytes = file.files.first.bytes;
                            title.text = file.files.first.name.split(".").first;
                          });
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
                    if (fileBytes != null || widget.model != null) ...[
                      showMusic()
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
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  dropDown(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    textColor: CColors.primary,
                    borderColor: CColors.primary,
                    background: Colors.black,
                    buttonName: "Cancel",
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
                      if (fileBytes == null) {
                        Functions.showSnackBar(
                            context, "Please upload song first");
                        return;
                      }

                      await getAudioDuration();

                      if (imageBytes == null) {
                        Functions.showSnackBar(
                            context, "Please upload image first");
                        return;
                      }

                      if (title.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "Please enter image name first");
                        return;
                      }
                      if (city.text.isEmpty) {
                        Functions.showSnackBar(
                            context, "Please enter city name first");
                        return;
                      }
                      if (selectedValue.isEmpty) {
                        Functions.showSnackBar(
                            context, "Please select genre first");
                        return;
                      }

                      Functions.showLoaderDialog(context);
                      if (fileBytes != null) {
                        String url = await widget.songProvider.uploadAudioWeb(
                            fileBytes!, "songs", tempFile!.name, context);
                        setState(() {
                          songUrl = url;
                        });
                      }
                      if (imageBytes != null) {
                        // ignore: use_build_context_synchronously
                        String url = await widget.songProvider.uploadAudioWeb(
                            imageBytes!, "images", imageFile!.name, context,
                            contentType: "png");
                        setState(() {
                          posterUrl = url;
                        });
                      }
                      if (songUrl != "" || posterUrl != "") {
                        widget.songProvider.uploadSong(title.text, city.text,
                            selectedValue, posterUrl, songUrl);
                        setState(() {
                          setState(() {
                            title.clear();
                            city.clear();
                            selectedValue == "";
                            fileBytes == null;
                            imageBytes == null;
                          });
                        });
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } else {
                        Functions.showSnackBar(context, "Please pick a song");
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
  }

  Widget showMusic() {
    return Stack(children: [
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
        child: IconButton(
          onPressed: () {
            setState(() {
              fileBytes = null;
            });
          },
          icon: Icon(
            Icons.cancel_outlined,
            color: CColors.borderColor,
          ),
        ),
      )
    ]);
  }

  Widget showImage() {
    return Stack(children: [
      Container(
        margin: const EdgeInsets.only(top: 5),
        width: width * 0.1,
        height: height * 0.15,
        child: widget.model == null
            ? Image.memory(
                imageBytes!,
                fit: BoxFit.cover,
              )
            : Image(
                image: NetworkImage(widget.model!.posterUrl),
                fit: BoxFit.cover,
              ),
      ),
      Positioned(
        right: 1,
        top: 1,
        child: IconButton(
            onPressed: () {
              if (widget.model == null && imageBytes != null) {
                setState(() {
                  imageBytes = null;
                });
              } else {

                if (imageBytes != null) {
                  setState(() {
                    imageBytes = null;
                  });
                }  else{

                  Functions.deleteFile(widget.model!.posterUrl);
                }

              }
            },
            icon: Icon(
              Icons.cancel_outlined,
              color: CColors.borderColor,
            )),
      )
    ]);
  }

  Widget dropDown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: "Genre",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: CColors.borderColor),
                    color: Colors.black),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: TextStyle(color: CColors.borderColor),
                      value: selectedValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: widget.songProvider.genreModel!.genre
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

  Widget textField(String name, TextEditingController controller,
      {void Function(String)? onChanged}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: name),
        const SizedBox(
          height: 5,
        ),
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


  Future<void> getAudioDuration() async {
    AudioPlayer audioPlayer = AudioPlayer();

    await audioPlayer.setAudioSource(MyJABytesSource(fileBytes!));
    // await audioPlayer.play();

    print("HEHEHHEH");
    Duration? total = audioPlayer.duration;
    print(total?.inSeconds);
    print("HEHEHHEH");


  }
}

class MyJABytesSource extends StreamAudioSource {
  final Uint8List _buffer;

  MyJABytesSource(this._buffer) : super(tag: 'MyAudioSource');

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    return StreamAudioResponse(
      sourceLength: _buffer.length,
      contentLength: (end ?? _buffer.length) - (start ?? 0),
      offset: start ?? 0,
      stream: Stream.fromIterable([_buffer.sublist(start ?? 0, end)]),
      contentType: 'audio/wav',
    );
  }
}
