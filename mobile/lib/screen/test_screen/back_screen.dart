import 'package:flutter/material.dart';

class BackTestNavigation extends StatelessWidget {
  const BackTestNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        child: Text("Back"),
        onPressed: () => {Navigator.pop(context)},
      )),
    );
  }
}
