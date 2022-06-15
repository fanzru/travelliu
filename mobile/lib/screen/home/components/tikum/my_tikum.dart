import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/model/tikum.dart';
import 'package:mobile/screen/home/components/profile/not_loggedin.dart';
import 'package:mobile/api/tikum.dart';
import 'package:mobile/screen/home/components/tikum/mytikum_card.dart';

class MyTikum extends StatefulWidget {
  MyTikum({Key? key}) : super(key: key);

  @override
  State<MyTikum> createState() => _MyTikumState();
}

class _MyTikumState extends State<MyTikum> {
  late Future<SecureProfile> futureProfile;

  @override
  void initState() {
    futureProfile = SecureProfile.getStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
  late Future<List<TikumProfile>> futureTikumProfile;
  void initState() {
    futureTikumProfile = getMyTikum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TikumProfile>>(
      future: futureTikumProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              for (var data in snapshot.data!)
                MyTikumCard(
                  tikum: data,
                )
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error when fetching all reviews"));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
