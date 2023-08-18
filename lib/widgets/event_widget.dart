import 'package:admin_project/dialog/add_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/event_model.dart';
import 'custom_text.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({super.key, required this.event});

  final EventModel event;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      color: Colors.grey.shade800,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: Image(
                  image: NetworkImage(
                    event.posterUrl,
                  ),
                  height: 60,
                  width: 60,
                ),
              ),
            ),
            Expanded(
              child: CustomText(
                text: event.name,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: CustomText(
                text: event.venue,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
              ),
            ),
            Builder(builder: (context) {
              var startDate = DateFormat("dd/MM/yyy").format(event.startDate);
              var endDate = DateFormat("dd/MM/yyy").format(event.endDate);
              return Expanded(
                flex: 3,
                child: CustomText(
                  text: "$startDate - $endDate",
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              );
            }),
            Builder(builder: (context) {
              var startTime = DateFormat("hh:mm a").format(event.startDate);
              return Expanded(
                child: CustomText(
                  text: startTime,
                  fontWeight: FontWeight.w500,
                  textAlign: TextAlign.center,
                ),
              );
            }),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(context: context, builder: (_)=> AddEvent(eventModel: event,));
                    },
                    color: Colors.white,
                    icon: Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("events")
                          .doc(event.id)
                          .delete();
                    },
                    color: Colors.white,
                    icon: Icon(Icons.delete),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
