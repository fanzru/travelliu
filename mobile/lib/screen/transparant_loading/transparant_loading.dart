import 'package:flutter/material.dart';

class TransparentLoading extends StatelessWidget {
  const TransparentLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
            child: Column(children: const [
          CircularProgressIndicator(),
          Text("Uploading")
        ])),
      ),
    );
  }
}
