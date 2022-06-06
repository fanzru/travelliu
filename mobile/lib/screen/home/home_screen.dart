import 'package:flutter/material.dart';
import 'package:mobile/screen/home/components/profile/profile_controller.dart';
import 'package:mobile/screen/home/components/tikum/tikum.dart';
import 'package:mobile/screen/home/components/timeline/timeline.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> section = [
    const Timeline(),
    TikumLayout(),
    ProfileSection()
  ];
  var sectionidx = 0;

  @override
  void initState() {
    super.initState();
  }

  void changeBottomIdx(int idx) {
    setState(() {
      sectionidx = idx;
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
            currentIndex: sectionidx,
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
          child: section[sectionidx],
        ));
  }
}
