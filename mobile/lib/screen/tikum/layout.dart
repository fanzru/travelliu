import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/screen/test_screen/test_screen.dart';
import 'package:mobile/screen/tikum/global_tikum.dart';
import 'package:mobile/screen/tikum/my_tikum.dart';

class TikumLayout extends StatefulWidget {
  TikumLayout({Key? key}) : super(key: key);

  @override
  State<TikumLayout> createState() => _TikumLayoutState();
}

class _TikumLayoutState extends State<TikumLayout> {
  late Future<SecureProfile> futureProfile;

  @override
  void initState() {
    futureProfile = SecureProfile.getStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: plusFloatingBuilder(futureProfile),
          appBar: AppBar(
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                TabBar(indicatorColor: Colors.black26, tabs: [
                  Tab(
                    text: "Global Tikum",
                  ),
                  Tab(
                    text: "My Tikum",
                  )
                ])
              ],
            ),
          ),
          body: TabBarView(children: [GlobalTikum(), MyTikum()]),
        ));
  }
}

FutureBuilder<SecureProfile> plusFloatingBuilder(Future<SecureProfile> future) {
  return FutureBuilder<SecureProfile>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Kalau misalkan logged in
          if (snapshot.data!.getLoggedInStatus()) {
            return FloatingActionButton(
              child: const Icon(Icons.add),
              heroTag: "Buat Review",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const TestScreen();
                }));
              },
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            );
          }
        }
        return const SizedBox.shrink();
      });
}
