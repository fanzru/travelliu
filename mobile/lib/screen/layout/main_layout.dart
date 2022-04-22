import 'package:flutter/material.dart';
import 'package:mobile/screen/myprofile/my_profile.dart';
import 'package:mobile/screen/profile/profile_controller.dart';
import 'package:mobile/screen/test_screen/test_screen.dart';
import 'package:mobile/screen/timeline/timeline.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int bottomItemIdx = 0;
  Widget currentScreen = const Timeline();

  @override
  void initState() {
    super.initState();
  }

  void changeBottomIdx(int idx) {
    setState(() {
      bottomItemIdx = idx;
      switch (idx) {
        case 0:
          {
            currentScreen = const Timeline();
          }
          break;

        case 1:
          {
            currentScreen = TestScreen();
          }
          break;

        case 2:
          {
            currentScreen = MyProfile();
          }
          break;

        case 3:
          {
            currentScreen = ProfilePage();
          }
          break;
      }
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
                icon: Icon(Icons.border_color_outlined),
                label: "Review",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people_outlined), label: "Tikum"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline_rounded), label: "Profil"),
            ]),
        body: SafeArea(
          child: currentScreen,
        ));
  }
}
