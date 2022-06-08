import 'package:flutter/material.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/form_review/form_review_screen.dart';
import 'package:mobile/screen/profile_detail/profile_detail_screen.dart';
import "dart:math" as math;

import 'package:mobile/screen/review_detail/review_detail_screen.dart';

class TimelineCard extends StatelessWidget {
  final Review data;
  final int randomForProfile = math.Random().nextInt(1000);
  TimelineCard({Key? key, required this.data, int? randomForProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Container(
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, ReviewDetailScreen.routeName,
                      arguments: ReviewDetailScreenArguments(id: data.id));
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
                              "https://www.thiswaifudoesnotexist.net/example-$randomForProfile.jpg",
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            child: Text(data.user.name),
                            splashColor: Colors.transparent,
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProfilePeopleScreen.routeName,
                                arguments: ProfilePeopleScreenArguments(
                                    id: data.userId),
                              );
                            },
                          )
                        ],
                      )),
                  const SizedBox(height: 10),
                  Image.network(data.photo[0] == "/"
                      ? "https://travelliu.yaudahlah.my.id${data.photo}"
                      : data.photo),
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
                  const Divider(
                    color: Colors.black,
                    height: 2.0,
                    thickness: 1.0,
                  )
                ]))));
  }
}
