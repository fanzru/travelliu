import 'package:flutter/material.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/_global/components/image_network.dart';
import "dart:math" as math;

import 'package:mobile/screen/review_detail/review_detail_screen.dart';
import 'package:mobile/utils/show_snackbar.dart';

// final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class MyReviewCard extends StatelessWidget {
  final int randomForProfile = math.Random().nextInt(1000);
  final ReviewProfile data;
  Function? refreshParent;
  MyReviewCard({Key? key, required this.data, this.refreshParent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleDelete() async {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Hapus Review'),
          content: const Text(
              'Jika anda menghapus review ini akan hilang dari timeline umum dan profile anda!'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await deleteMyReview(data.id);
                  ShowSnackBar(context, "Berhasil menghapus post");
                  if (refreshParent != null) {
                    refreshParent!();
                  }
                } catch (err) {
                  ShowSnackBar(context, err.toString());
                }
                Navigator.pop(context, "OK");
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ReviewDetailScreen.routeName,
              arguments: ReviewDetailScreenArguments(id: data.id));
        },
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: ImageNetworkWShimmer(
                          link:
                              "https://www.thiswaifudoesnotexist.net/example-$randomForProfile.jpg",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(data.nameUser)
                    ]),
                    TextButton(
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: _handleDelete),
                  ],
                )),
            const SizedBox(height: 10),
            ImageNetworkWShimmer(
                link: data.photo[0] == "/"
                    ? "https://travelliu.yaudahlah.my.id${data.photo}"
                    : data.photo),
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star_border_outlined,
                            color: Colors.yellow),
                        Text(data.rating.toString()),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          data.namaTempat,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          data.review,
                          textAlign: TextAlign.left,
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                )),
            const Divider(
              color: Colors.black,
              height: 2.0,
              thickness: 1.0,
            )
          ],
        ),
      ),
    );
  }
}
