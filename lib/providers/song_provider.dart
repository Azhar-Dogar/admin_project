import 'dart:typed_data';

import 'package:admin_project/model/genre_model.dart';
import 'package:admin_project/model/song_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter/services.dart';
class SongProvider extends ChangeNotifier {
  GenreModel? genreModel;
  getGenre() async {
    FirebaseFirestore.instance.collection("genre").snapshots().listen((event) {
      print(event.docs.first.data());
     genreModel = GenreModel.fromMap(event.docs.first.data());
     print(genreModel?.genre.length);
    });
    print(genreModel?.genre.length);
  }
   Future<String> uploadAudioWeb(
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
  uploadSong(String title, String city, String genre, String posterUrl,
      String songUrl) async {
    DateTime now = DateTime.now();
    var doc = FirebaseFirestore.instance.collection("Songs").doc();
    await doc.set(
      SongModel(
             id: doc.id,
              title: title,
              city: city,
              createdAt: now,
              genre: genre,
              posterUrl: posterUrl,
              songUrl: songUrl,
              updatedAt: now)
          .toMap()
    );
  }
}