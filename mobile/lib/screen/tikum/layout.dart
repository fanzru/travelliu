import 'package:flutter/material.dart';
import 'package:mobile/screen/test_screen/test_screen.dart';
import 'package:mobile/screen/tikum/global_tikum.dart';

class TikumLayout extends StatefulWidget {
  TikumLayout({Key? key}) : super(key: key);

  @override
  State<TikumLayout> createState() => _TikumLayoutState();
}

class _TikumLayoutState extends State<TikumLayout> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: FloatingActionButton(
            heroTag: "Buat Tikum",
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return TestScreen();
              }));
            },
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
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
          body: TabBarView(children: [GlobalTikum(), TestScreen()]),
        ));
  }
}
