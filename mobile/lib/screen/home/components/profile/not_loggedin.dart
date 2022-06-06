import 'package:flutter/material.dart';
import 'package:mobile/screen/form_login/login_screen.dart';
import 'package:mobile/screen/form_register/register_screen.dart';

class NotLoggedIn extends StatelessWidget {
  const NotLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Kamu belum Masuk nih"),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName,
                      arguments: LoginScreenArguments());
                },
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            OutlinedButton(
                style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(color: Colors.black)),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName,
                      arguments: RegisterScreenArguments());
                },
                child: const Text(
                  "Daftar",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ))
          ]),
        ));
  }
}
