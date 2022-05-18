import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/timeline/timeline_card.dart';

import '../../api/review.dart';
import "dart:math" as math;

final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfile();
}

class _MyProfile extends State<MyProfile> {
  late Future<List<Review>> futureReview;
  final int randomForProfile = math.Random().nextInt(1000);
  @override
  void initState() {
    futureReview = getAllReview();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navKey,
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) {
          return FutureBuilder<List<Review>>(
            future: futureReview,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 100,
                        bottom: 30,
                      ),
                      height: 86,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          "https://www.thiswaifudoesnotexist.net/example-$randomForProfile.jpg",
                          width: 86,
                          height: 86,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Ananda Affan Fattahila",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("Total Review"),
                                const Text("100"),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 20,
                            ),
                            child: Column(
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                const Text("Rataan Rating"),
                                const Text("100"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
        },
      ),
    );
  }
}
