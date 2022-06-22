import 'package:flutter/material.dart';
import 'package:mobile/model/komentar.dart';

class KomentarCard extends StatelessWidget {
  final Komentar data;

  const KomentarCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
          )),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          data.user!.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(data.komentar)
      ]),
    );
  }
}
