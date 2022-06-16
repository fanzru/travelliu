import 'package:flutter/material.dart';
import 'package:mobile/screen/_global/components/shimmer/shimmer_container.dart';

class ShimmerProfile extends StatelessWidget {
  const ShimmerProfile({Key? key}) : super(key: key);

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
              child: const ShimmerContainer(
                width: 50,
                height: 50,
              )),
        ),
        ShimmerContainer(
          width: MediaQuery.of(context).size.width * .4,
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
                    const ShimmerContainer(width: 50),
                    const SizedBox(height: 5),
                    ShimmerContainer(
                        width: MediaQuery.of(context).size.width * .3)
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
                    const ShimmerContainer(width: 50),
                    const SizedBox(height: 5),
                    ShimmerContainer(
                        width: MediaQuery.of(context).size.width * .3)
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
