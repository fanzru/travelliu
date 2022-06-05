import 'package:flutter/material.dart';
import 'package:mobile/screen/tikum/layout.dart';
import 'package:mobile/screen/timeline/timeline.dart';
import 'package:mobile/screen/profile/profile_controller.dart';

import '../myprofile/my_profile.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int bottomItemIdx = 0;

  // Ini harus sesuai dengan urutan index bottom navigation barnya ya
  final List<Widget> _screen = <Widget>[
    const Timeline(),
    TikumLayout(),
    //MyProfile()
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  void changeBottomIdx(int idx) {
    setState(() {
      bottomItemIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Travelliu"),
          backgroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black26,
            currentIndex: bottomItemIdx,
            onTap: changeBottomIdx,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.format_align_center_outlined),
                label: "Timeline",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outlined), label: "Tikum"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded), label: "Profil"),
            ]),
        body: SafeArea(
          child: _screen[bottomItemIdx],
        ));
  }
}
