import 'package:flutter/material.dart';
import 'package:mobile/api/tikum.dart';
import 'package:mobile/model/tikum.dart';
import 'package:mobile/screen/tikum/tikum_card.dart';

class GlobalTikum extends StatefulWidget {
  GlobalTikum({Key? key}) : super(key: key);

  @override
  State<GlobalTikum> createState() => _GlobalTikumState();
}

class _GlobalTikumState extends State<GlobalTikum> {
  late Future<List<Tikum>> futureTikum;

  @override
  void initState() {
    futureTikum = getAllTikum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tikum>>(
        future: futureTikum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var data in snapshot.data!)
                  TikumCard(
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
        });
  }
}
