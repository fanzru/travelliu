import 'package:flutter/material.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/_global/components/image_network.dart';
import "dart:math" as math;

import 'package:mobile/screen/review_detail/review_detail_screen.dart';
import 'package:mobile/utils/show_snackbar.dart';

// final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();
class TimelineCard extends StatefulWidget {
  final ReviewProfile data;
  final int randomForProfile = math.Random().nextInt(1000);
  TimelineCard({Key? key, required this.data, int? randomForProfile})
      : super(key: key);

  @override
  State<TimelineCard> createState() => _TimelineCardState();
}

class _TimelineCardState extends State<TimelineCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ReviewDetailScreen.routeName,
              arguments: ReviewDetailScreenArguments(id: widget.data.id));
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
                              "https://www.thiswaifudoesnotexist.net/example-${widget.randomForProfile}.jpg",
                          width: 40,
                          height: 40,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(widget.data.nameUser)
                    ]),
                    TextButton(
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => showDialog<String>(
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
                                  await deleteMyReview(widget.data.id);
                                  ShowSnackBar(context,
                                      "Berhasil menghapus post, harap pindah halaman untuk melihat perubahan");
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
                      ),
                      // onPressed: () async {
                      //   setState(() {
                      //     _futureStatus = deleteMyReview(widget.data.id);
                      //   });
                      // },
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            ImageNetworkWShimmer(
                link: widget.data.photo[0] == "/"
                    ? "https://travelliu.yaudahlah.my.id${widget.data.photo}"
                    : widget.data.photo),
            Container(
                margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star_border_outlined,
                            color: Colors.yellow),
                        Text(widget.data.rating.toString()),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.data.namaTempat,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          widget.data.review,
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
