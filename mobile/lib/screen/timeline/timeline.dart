import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/timeline/timeline_card.dart';

import '../../api/review.dart';
import '../test_screen/test_screen.dart';

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late Future<List<Review>> futureReview;

  @override
  void initState() {
    futureReview = getAllReview();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          heroTag: "Buat Review",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const TestScreen();
            }));
          },
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Navigator(
          key: _navKey,
          onGenerateRoute: (_) => MaterialPageRoute(builder: (_) {
            return FutureBuilder<List<Review>>(
              future: futureReview,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      for (var data in snapshot.data!)
                        TimelineCard(
                          data: data,
                          navKey: _navKey,
                        )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text("Error when fetching all reviews"));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }),
        ));
  }
}
