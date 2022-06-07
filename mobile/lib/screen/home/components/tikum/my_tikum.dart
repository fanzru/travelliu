import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/model/tikum.dart';
import 'package:mobile/screen/home/components/profile/not_loggedin.dart';
import 'package:mobile/api/tikum.dart';

class MyTikum extends StatefulWidget {
  MyTikum({Key? key}) : super(key: key);

  @override
  State<MyTikum> createState() => _MyTikumState();
}

class _MyTikumState extends State<MyTikum> {
  late Future<SecureProfile> futureProfile;
  late Future<List<TikumProfile>> futureTikumProfile;

  @override
  void initState() {
    futureProfile = SecureProfile.getStorage();
    futureTikumProfile = getMyTikum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<SecureProfile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.getLoggedInStatus()) {
              return MyTikumList();
            }
          }
          return NotLoggedIn();
        },
      ),
    );
  }
}

// TODO: Affan ngerjain ini ya untuk ngerender listnya
class MyTikumList extends StatefulWidget {
  MyTikumList({Key? key}) : super(key: key);

  @override
  State<MyTikumList> createState() => _MyTikumListState();
}

class _MyTikumListState extends State<MyTikumList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container());
  }
}
