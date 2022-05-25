import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/review/form_review_screen.dart';
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
  late Future<SecureProfile> futureProfile;

  @override
  void initState() {
    futureReview = getAllReview();
    futureProfile = SecureProfile.getStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: plusFloatingBuilder(futureProfile),
        body: Navigator(
          key: _navKey,
          onGenerateRoute: (_) => MaterialPageRoute(builder: (_) {
            return reviewBuilder(futureReview);
          }),
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
                  return const FormReview();
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

FutureBuilder<List<Review>> reviewBuilder(Future<List<Review>> future) {
  return FutureBuilder<List<Review>>(
    future: future,
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
        return const Center(child: Text("Error when fetching all reviews"));
      }
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
