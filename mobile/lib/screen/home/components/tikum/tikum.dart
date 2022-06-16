import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/screen/form_tikum/form_tikum_screen.dart';
import 'package:mobile/screen/test_screen/test_screen.dart';
import 'package:mobile/screen/home/components/tikum/global_tikum.dart';
import 'package:mobile/screen/home/components/tikum/my_tikum.dart';

class TikumLayout extends StatelessWidget {
  const TikumLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: const _FloatingActionButtonTikum(),
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
      ),
    );
  }
}

class _FloatingActionButtonTikum extends StatefulWidget {
  const _FloatingActionButtonTikum({Key? key}) : super(key: key);

  @override
  State<_FloatingActionButtonTikum> createState() =>
      __FloatingActionButtonTikumState();
}

class __FloatingActionButtonTikumState
    extends State<_FloatingActionButtonTikum> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoggedIn();
  }

  void _checkLoggedIn() async {
    var profile = await SecureProfile.getStorage();
    setState(() {
      isLoggedIn = profile.getLoggedInStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return !isLoggedIn
        ? const SizedBox.shrink()
        : FloatingActionButton(
            child: const Icon(Icons.add),
            heroTag: "Buat Review",
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const FormTikumScreen();
              }));
            },
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          );
  }
}
