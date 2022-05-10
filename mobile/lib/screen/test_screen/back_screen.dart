import 'package:flutter/material.dart';

class BackTestNavigation extends StatelessWidget {
  const BackTestNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
          child: ElevatedButton(
        child: Text("Back"),
        onPressed: () => {Navigator.pop(context)},
      )),
    );
  }
}
