import 'package:admin_project/dialog/add_event.dart';
import 'package:admin_project/providers/event_provider.dart';
import 'package:admin_project/widgets/button_widget.dart';
import 'package:admin_project/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../extras/colors.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/event_widget.dart';

class EventManagement extends StatefulWidget {
  const EventManagement({
    super.key,
  });

  @override
  State<EventManagement> createState() => _EventManagementState();
}

class _EventManagementState extends State<EventManagement> {
  TextEditingController search = TextEditingController();

  var format = DateFormat("dd/MM/yyyy hh:mm a");

  late double width, height;
  late EventProvider eventProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Consumer<EventProvider>(
        builder: (BuildContext context, value, Widget? child) {
      eventProvider = value;
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          header(),
          Container(
            margin: const EdgeInsets.only(top: 10),
            color: Colors.grey.shade800,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomText(
                      text: "Poster",
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Event",
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      text: "Venue",
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      text: "Start and End Date",
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Start Time",
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: CustomText(
                      text: "Actions",
                      fontWeight: FontWeight.w500,
                      textAlign: TextAlign.center,
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
                child: (eventProvider.events.isEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "No Records Found",
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      )
                    : eventList(),
              ),
            ),
          )
        ],
      );
    });
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomText(
              text: "Your Events",
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
                            controller: search, hint: "Search Events"))
                  ],
                ),
              ),
            ),
            SizedBox(
              width: width * 0.02,
            ),
            ButtonWidget(
                textColor: Colors.black,
                background: CColors.primary,
                borderColor: Colors.black,
                onPressed: () {
                  showDialog(context: context, builder: (_) => AddEvent());
                },
                buttonName: "Create Event",
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Colors.black,
                ))
          ],
        )
      ],
    );
  }

  Widget eventList() {
    return ListView.builder(
        itemCount: eventProvider.events.length,
        itemBuilder: (BuildContext context, index) {
          return EventWidget(
            event: eventProvider.events[index],
            key: Key(eventProvider.events[index].id!),
          );
        });
  }
}
