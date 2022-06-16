import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/_global/components/image_network.dart';
import 'package:mobile/screen/review_detail/components/review_komentar.dart';
import "dart:math" as math;

import 'package:url_launcher/url_launcher.dart';

class ReviewDetail extends StatelessWidget {
  final Review data;
  ReviewDetail({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ImageNetworkWShimmer(
          link: data.photo[0] == "/"
              ? "https://travelliu.yaudahlah.my.id${data.photo}"
              : data.photo,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                __ReviewSection(data: data),
                const SizedBox(
                  height: 10,
                ),
                DetailReviewKomentarSection(data: data)
              ],
            )),
      ],
    );
  }
}

class __ReviewSection extends StatelessWidget {
  final Review data;
  final int randomForProfile = math.Random().nextInt(1000);
  __ReviewSection({Key? key, required this.data}) : super(key: key);

  void _handleMapsButton() async {
    if (data.latitude == null || data.longitude == null) {
      return;
    }
    String link =
        "https://www.google.com/maps/search/?api=1&query=${data.latitude}%2C${data.longitude}";
    final Uri _url = Uri.parse(link);
    if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
      throw const AlertDialog(title: Text("Failed to open the link"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: ImageNetworkWShimmer(
                link:
                    "https://www.thiswaifudoesnotexist.net/example-$randomForProfile.jpg",
                width: 40,
                height: 40,
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(data.user.name)
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const Icon(Icons.star_border_outlined, color: Colors.yellow),
            Text(data.rating.toStringAsFixed(2)),
            const SizedBox(
              width: 10,
            ),
            Text(
              data.namaTempat,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          data.review,
          textAlign: TextAlign.justify,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: _handleMapsButton,
              child: const Center(
                child: Icon(
                  Icons.map_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(child: Text(data.alamat))
          ],
        )
      ],
    );
  }
}
