import 'package:flutter/material.dart';
import 'package:mobile/api/review.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/_global/components/shimmer/detail_review_shimmer.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/screen/review_detail/components/review_detail.dart';
import 'package:mobile/utils/show_snackbar.dart';

class ReviewDetailScreenArguments {
  final int id;
  ReviewDetailScreenArguments({required this.id});
}

class ReviewDetailScreen extends StatelessWidget {
  static String routeName = "/review-detail";

  ReviewDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments
        as ReviewDetailScreenArguments;
    var id = arg.id;
    Future<Review> futureReview = getReviewById(id);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Review"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: FutureBuilder<Review>(
          future: futureReview,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ReviewDetail(data: snapshot.data!);
            }
            if (snapshot.hasError) {
              return const _GagalDetailReview();
            }
            return const ShimmerDetailReview();
          },
        ),
      ),
    );
  }
}

class _GagalDetailReview extends StatelessWidget {
  const _GagalDetailReview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Gagal dalam mengambil review"),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Back to timeline",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
