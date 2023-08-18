import 'dart:typed_data';

import 'package:admin_project/model/event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebaseStorage;
import 'package:flutter/services.dart';

class EventProvider extends ChangeNotifier {
  EventProvider() {
    getEvents();
  }

  List<EventModel> events = [];
  CollectionReference ref = FirebaseFirestore.instance.collection("events");

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

  addEvent(String name, String venue, DateTime startDate, DateTime endDate,
      String posterUrl, String description, [String? id]) async {
    var doc = FirebaseFirestore.instance.collection("events").doc(id);
    await doc.set(
      EventModel(
              name: name,
              venue: venue,
              startDate: startDate,
              posterUrl: posterUrl,
              endDate: endDate,
              description: description,
              id: doc.id)
          .toMap(),
    );
  }

  getEvents() {
    FirebaseFirestore.instance.collection("events").snapshots().listen((event) {
      events = [];
      for (var element in event.docs) {
        events.add(EventModel.fromMap(element.data()));
      }
      notifyListeners();
    });
  }
}
