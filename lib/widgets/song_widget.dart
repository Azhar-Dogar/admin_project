import 'package:admin_project/model/song_model.dart';
import 'package:admin_project/providers/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../extras/constants.dart';
import '../screens/dialog/song_upload.dart';

class SongWidget extends StatefulWidget {
  const SongWidget({Key? key, required this.model}) : super(key: key);

  final SongModel model;

  @override
  _SongWidgetState createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  late String url = widget.model.posterUrl;

  late SongModel model;

  @override
  void initState() {
    super.initState();
    model = widget.model;
    if (model.posterUrl.isEmpty) {
      url = Constants.demoCoverImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Image(
          image: NetworkImage(url),
          height: 40,
        )),
        Expanded(
          flex: 3,
          child: Text(
            model.title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const Expanded(
            child: Text(
          "01:00",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        )),
        Expanded(
            child: Text(
          model.genre,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        )),
        Expanded(
            child: Text(
          model.city,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        )),
        Expanded(
            child: Text(
          textAlign: TextAlign.center,
          DateFormat('MM/dd/yy').format(model.createdAt),
          style: const TextStyle(color: Colors.white),
        )),
        Expanded(
          child: Switch(
              value: model.isLive,
              onChanged: (val) {
                setState(() {
                  model.isLive = val;
                });
                Provider.of<SongProvider>(context, listen: false)
                    .updateSong(model);
              }),
        ),
        Expanded(
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  SongProvider songProvider = context.read<SongProvider>();

                  showDialog(
                    context: context,
                    builder: (_) => SongUpload(
                      model: widget.model,
                      songProvider: songProvider,
                    ),
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 10),
              InkWell(
                onTap: () {
                  Provider.of<SongProvider>(context, listen: false)
                      .deleteSong(model.id!);
                },
                child: const Icon(Icons.delete, color: Colors.white),
              )
            ],
          ),
        )
      ],
    );
  }
}
