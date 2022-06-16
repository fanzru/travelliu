import 'package:flutter/material.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/model/profile.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/_global/components/profile_card.dart';
import 'package:mobile/screen/_global/components/shimmer/profile_shimmer.dart';
import 'package:mobile/screen/_global/components/shimmer/review_shimmer.dart';
import 'package:mobile/screen/home/components/profile/myprofile/card_profile.dart';
import 'package:mobile/screen/home/home_screen.dart';

import 'package:mobile/utils/show_snackbar.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          _ProfileSection(),
          const _ReviewSection(),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final Future<Profile> futureProfile = getMyProfileById();
  _ProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleLogout() async {
      try {
        showDialog(
            context: context,
            builder: (context) => const Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(),
                  ),
                ));
        await userLogout();
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
        ShowSnackBar(context, "Logout berhasil");
      } catch (err) {
        Navigator.pop(context);
        ShowSnackBar(context, err.toString());
      }
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Colors.red,
              ),
              onPressed: _handleLogout,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    "logout ",
                  ),
                  Icon(
                    Icons.logout_outlined,
                    size: 15.0,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        FutureBuilder<Profile>(
          future: futureProfile,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ProfileCard(data: snapshot.data!);
            }

            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: const Center(child: ShimmerProfile()),
            );
          },
        ),
      ],
    );
  }
}

class _ReviewSection extends StatefulWidget {
  const _ReviewSection({Key? key}) : super(key: key);

  @override
  State<_ReviewSection> createState() => __ReviewSectionState();
}

class __ReviewSectionState extends State<_ReviewSection> {
  Future<List<ReviewProfile>> futureReview = getMyReviewById();

  void refreshList() {
    setState(() {
      futureReview = getMyReviewById();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewProfile>>(
      future: futureReview,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: SizedBox(
                width: 350,
                child: Column(
                  children: const [
                    Text(
                      "Oops.. kamu masih belum membagikan apapun",
                      textAlign: TextAlign.center,
                    ),
                    Text("Bagikan cerita perjalananmu sekarang!")
                  ],
                ),
              ),
            );
          }

          return Column(
            children: [
              for (var data in snapshot.data!)
                MyReviewCard(
                  data: data,
                  refreshParent: refreshList,
                )
            ],
          );
        }
        return Center(
            child: Column(
          children: [for (int i = 0; i < 5; i++) const ShimmerReview()],
        ));
      },
    );
  }
}
