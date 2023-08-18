import 'package:admin_project/extras/colors.dart';
import 'package:admin_project/providers/song_provider.dart';
import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../widgets/song_widget.dart';
import '../dialog/song_upload.dart';

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
  String songUrl = "";
  String posterUrl = "";

  @override
  void initState() {
    super.initState();
    Provider.of<SongProvider>(context, listen: false).getGenre();
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
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomText(
                      text: "Poster",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      textAlign: TextAlign.center,
                      text: "Title",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Duration",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Genre",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Location",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Uploaded on",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Live",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Actions",
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.grey.shade900,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: (songProvider.songs.isNotEmpty)
                    ? songsList()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "No Records Found",
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget songsList() {
    return ListView.separated(
      itemCount: songProvider.songs.length,
      itemBuilder: (BuildContext context, index) {
        return SongWidget(
          model: songProvider.songs[index],
          key: Key(songProvider.songs[index].id!),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 10);
      },
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
                background: CColors.primary,
                textColor: Colors.black,
                borderColor: CColors.primary,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) => SongUpload(
                            songProvider: songProvider,
                          ));
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
}
