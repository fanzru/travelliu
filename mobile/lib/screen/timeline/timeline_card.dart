import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/review/review_screen.dart';

class TimelineCard extends StatelessWidget {
  final Review data;
  final GlobalKey<NavigatorState> navKey;
  const TimelineCard({Key? key, required this.data, required this.navKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Card(
            child: InkWell(
                onTap: () {
                  navKey.currentState!
                      .push(MaterialPageRoute(builder: (context) {
                    return ReviewDetails(navkey: navKey, id: data.id);
                  }));
                },
                child: Column(children: [
                  Container(
                      margin:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              "https://travelliu.yaudahlah.my.id/affan-imut.jpeg",
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(data.user.name)
                        ],
                      )),
                  const SizedBox(height: 10),
                  Image.network(data.photo),
                  Container(
                      margin: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
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
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.comment),
                              Text(data.numKomentar.toString())
                            ],
                          )
                        ],
                      )),
                ]))));
  }
}
