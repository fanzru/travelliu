import 'package:flutter/material.dart';
import 'package:mobile/model/tikum.dart';
import 'package:intl/intl.dart';
import 'package:mobile/screen/_global/components/image_network.dart';
import 'package:url_launcher/url_launcher.dart';

class TikumCard extends StatelessWidget {
  final Tikum tikum;
  const TikumCard({Key? key, required this.tikum}) : super(key: key);

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
                  child: ImageNetworkWShimmer(
                    link: "https://travelliu.yaudahlah.my.id/affan-imut.jpeg",
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(tikum.user.name)
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Icon(Icons.location_pin),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  tikum.tempatTujuan,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Jam, Tanggal",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                    DateFormat('hh:mm aa dd-MM-yyyy').format(tikum.waktuKumpul))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Titik Kumpul",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(tikum.tempatTujuan)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (tikum.deskripsi != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0))),
                    padding: const EdgeInsets.all(15.0),
                    child: Text(tikum.deskripsi!),
                  )
                ],
              ),
            if (tikum.linkGroup != null &&
                Uri.tryParse(tikum.linkGroup!)!.isAbsolute)
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () async {
                    final Uri _url = await Uri.parse(tikum.linkGroup!);
                    if (!await launchUrl(_url,
                        mode: LaunchMode.externalApplication)) {
                      throw const AlertDialog(
                          title: Text("Failed to open the link"));
                    }
                  },
                  child: const Text(
                    "Join Group",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
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
