import 'package:flutter/material.dart';
import 'package:mobile/screen/_global/components/shimmer/shimmer_container.dart';

class ShimmerTikum extends StatelessWidget {
  const ShimmerTikum({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 15, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const ShimmerContainer(
                      width: 40,
                      height: 40,
                    )),
                const SizedBox(
                  width: 15,
                ),
                const ShimmerContainer(
                  width: 200,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const ShimmerContainer(
              width: 500,
            ),
            const SizedBox(
              height: 25,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerContainer(
                  width: 200,
                ),
                SizedBox(
                  height: 5,
                ),
                ShimmerContainer(
                  width: 400,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerContainer(
                  width: 200,
                ),
                SizedBox(
                  height: 5,
                ),
                ShimmerContainer(
                  width: 400,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      const Divider(
        color: Colors.black,
        height: 4,
      )
    ]);
  }
}
