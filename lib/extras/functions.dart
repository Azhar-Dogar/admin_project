import 'package:admin_project/extras/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Functions{
  static showSnackBar(BuildContext context, String message, {Color? color}) {
    color ??= CColors.primary;
    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        message,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showLoaderDialog(BuildContext context, {String text = 'Loading'}) {
    AlertDialog alert = AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [CircularProgressIndicator()],
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



  static Future<void> deleteFile(String url) async {
    try {
      final Reference fileRefFromUrl = FirebaseStorage.instance.refFromURL(url);

      await FirebaseStorage.instance.ref(fileRefFromUrl.fullPath).delete();

      print('File deleted successfully!');
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

}