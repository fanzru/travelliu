import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/timeline/timeline_card.dart';

import '../../api/review.dart';

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
    return SafeArea(
        child: FutureBuilder<List<Review>>(
      future: futureReview,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: [
              for (var data in snapshot.data!) TimelineCard(data: data)
            ],
          );
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error when fetching all reviews"));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
