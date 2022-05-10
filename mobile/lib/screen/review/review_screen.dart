import 'package:flutter/material.dart';

class ReviewDetails extends StatelessWidget {
  final GlobalKey<NavigatorState> navkey;
  const ReviewDetails({Key? key, required this.navkey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Go Back"),
        onPressed: () {
          navkey.currentState!.pop();
        },
      ),
    );
  }
}
