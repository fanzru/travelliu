import 'package:flutter/material.dart';

class ReviewDetailsScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navkey;
  final int id;
  const ReviewDetailsScreen({Key? key, required this.navkey, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text("Hello from $id Go Back"),
        onPressed: () {
          navkey.currentState!.pop();
        },
      ),
    );
  }
}
