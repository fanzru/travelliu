import 'package:flutter/material.dart';

class ReviewDetailScreenArguments {
  final int id;
  ReviewDetailScreenArguments({required this.id});
}

class ReviewDetailScreen extends StatelessWidget {
  static String routeName = "/review-detail";

  const ReviewDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)!.settings.arguments
        as ReviewDetailScreenArguments;

    var id = arg.id;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Review"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Hello from $id Go Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
