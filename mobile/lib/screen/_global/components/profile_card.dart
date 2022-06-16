import 'package:flutter/material.dart';
import 'package:mobile/model/profile.dart';
import "dart:math" as math;

import 'package:mobile/screen/_global/components/image_network.dart';

class ProfileCard extends StatelessWidget {
  final Profile data;
  // final GlobalKey<NavigatorState> navKey;
  final int randomForProfile = math.Random().nextInt(1000);

  ProfileCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          height: 100,
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: ImageNetworkWShimmer(
              link:
                  "https://www.thiswaifudoesnotexist.net/example-$randomForProfile.jpg",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          data.user.name.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
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
                    Text(data.totalReview.toString()),
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
                    Text(data.avgRating.toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
