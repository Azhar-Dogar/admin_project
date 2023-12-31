import 'dart:typed_data';

import 'package:admin_project/model/genre_model.dart';
import 'package:admin_project/model/song_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter/services.dart';

import '../model/post_model.dart';

class SongProvider extends ChangeNotifier {
  GenreModel? genreModel;
  List<SongModel> songs = [];

  getSongs() {
    FirebaseFirestore.instance.collection("Songs").snapshots().listen((event) {
      songs = [];
      for (var element in event.docs) {
        songs.add(SongModel.fromMap(element.data()));
      }
      notifyListeners();
    });
  }

  getGenre() async {
    FirebaseFirestore.instance.collection("genre").snapshots().listen((event) {
      print(event.docs.first.data());
      genreModel = GenreModel.fromMap(event.docs.first.data());
      print(genreModel?.genre.length);
    });
    print(genreModel?.genre.length);
  }

  Future<String> uploadAudioWeb(
      Uint8List file, String child, String name, BuildContext context,
      {String contentType = "audio/mp3"}) async {
    try {
      final firebaseStorage.FirebaseStorage storage =
          firebaseStorage.FirebaseStorage.instance;

      var reference = storage.ref().child(child).child(name);

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
    var doc2 = FirebaseFirestore.instance.collection("feed").doc(doc.id);
    var model = SongModel(
      id: doc.id,
      title: title,
      city: city,
      createdAt: now,
      genre: genre,
      posterUrl: posterUrl,
      songUrl: songUrl,
      bandId: FirebaseAuth.instance.currentUser!.uid,
      updatedAt: now,);
    await doc.set(
        model.toMap());

    var feed = PostModel(
      id: doc2.id,
      bandId: FirebaseAuth.instance.currentUser!.uid,
      song: model.toMap(),
      event: null,
    );
    doc2.set(feed.toMap());
  }

  updateSong(SongModel model) {
    FirebaseFirestore.instance
        .collection("Songs")
        .doc(model.id)
        .update(model.toMap());
  }


  deleteSong(String id) {
    FirebaseFirestore.instance
        .collection("Songs")
        .doc(id).delete();
  }


}
