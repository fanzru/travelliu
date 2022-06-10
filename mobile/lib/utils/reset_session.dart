import 'package:flutter/material.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/utils/show_snackbar.dart';

class ResetSession extends StatelessWidget {
  const ResetSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShowSnackBar(context, "Session tidak valid");

    Navigator.pushNamedAndRemoveUntil(
        context, HomeScreen.routeName, (route) => false);

    return Container();
  }
}
