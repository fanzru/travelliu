import 'package:flutter/material.dart';
import 'package:mobile/screen/_global/components/shimmer/shimmer_container.dart';

class ShimmerReview extends StatelessWidget {
  const ShimmerReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Row(
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
        ),
        const SizedBox(height: 10),
        ShimmerContainer(
          width: MediaQuery.of(context).size.width,
          height: 200,
        ),
        Container(
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                ShimmerContainer(
                  width: MediaQuery.of(context).size.width * .5,
                ),
                const SizedBox(height: 10),
                ShimmerContainer(
                  width: MediaQuery.of(context).size.width * .8,
                ),
                const SizedBox(height: 5),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [ShimmerContainer(width: 50)],
                )
              ],
            )),
        const Divider(
          color: Colors.black,
          height: 2.0,
          thickness: 1.0,
        )
      ],
    );
  }
}
