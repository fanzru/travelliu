import 'package:flutter/material.dart';
import 'package:mobile/screen/test_screen/test_screen.dart';

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
          body: TabBarView(children: [TestScreen(), TestScreen()]),
        ));
  }
}
