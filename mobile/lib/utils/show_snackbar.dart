import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, String message) {
  final snackbar =
      SnackBar(behavior: SnackBarBehavior.floating, content: Text(message));

  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
