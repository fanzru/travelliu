import 'package:flutter/material.dart';
import 'package:mobile/screen/test_screen/back_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: ElevatedButton(
        child: Text("Test Navigation"),
        onPressed: () => {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BackTestNavigation();
          }))
        },
      )),
    );
  }
}
