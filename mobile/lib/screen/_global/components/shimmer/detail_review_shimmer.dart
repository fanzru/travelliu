import 'package:flutter/material.dart';
import 'package:mobile/screen/_global/components/shimmer/shimmer_container.dart';

class ShimmerDetailReview extends StatelessWidget {
  const ShimmerDetailReview({Key? key}) : super(key: key);
  final double textHeight = 10;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ShimmerContainer(
          height: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      ),
                    ),
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
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(
                      width: MediaQuery.of(context).size.width * .7,
                      height: textHeight,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .6,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .9,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .9,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .8,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      width: MediaQuery.of(context).size.width * .6,
                      height: textHeight,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .9,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ShimmerContainer(
                      height: textHeight,
                      width: MediaQuery.of(context).size.width * .9,
                    ),
                  ],
                )
              ],
            ))
      ],
    );
  }
}
