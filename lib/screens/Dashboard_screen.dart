import 'package:admin_project/screens/dashboard/band_profile.dart';
import 'package:admin_project/widgets/custom_text.dart';
import 'package:admin_project/screens/dashboard/events_management.dart';
import 'package:admin_project/screens/dashboard/songs_management.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selected = 0;
  List<Category> categories = [
    Category(name: "Song Management", index: 0, icon: Icons.music_note),
    Category(name: "Event Management", index: 1, icon: Icons.calendar_month),
    Category(name: "Band Profile", index: 2, icon: Icons.person)
  ];
  late double width,height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: header(),
          ),
          Divider(
            color: Colors.grey.shade700,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [for (var e in categories) item(e)],
                  ),
                  SizedBox(width: width * 0.1,),
                  if(selected == 0)...[
                    const Expanded(
                    child: SongsManagement(),
                  )]else if(selected == 1)...[
                    const Expanded(child: EventManagement())
                  ]else...[
                     Expanded(child: SingleChildScrollView(child: BandProfile()))
                  ]
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget item(
    Category item,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            selected = item.index;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              item.icon,
              color: (selected == item.index) ? Colors.yellow : Colors.white,
              size: 15,
            ),
            const SizedBox(
              width: 5,
            ),
            CustomText(
              text: item.name,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: (selected == item.index) ? Colors.yellow : Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Image(
              image: AssetImage("assets/app_icon.png"),
              width: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            CustomText(
              text: "UPRISE",
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
        Row(
          children: [
            const Icon(
              Icons.person,
              color: Colors.white,
            ),
            CustomText(text: "Riz"),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white,
            ),
          ],
        )
      ],
    );
  }
}

class Category {
  String name;
  int index;
  IconData icon;
  Category({required this.name, required this.index, required this.icon});
}