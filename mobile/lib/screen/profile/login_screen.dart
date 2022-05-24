import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/screen/profile/register_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Center(
                  child: Column(
            children: [
              const Text("Travelliu"),
              const Text("Log in"),
              Column(
                children: [
                  const Text("Email"),
                  TextField(
                    onChanged: (value) => {email = value},
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "fanzru@gmail.com"),
                  )
                ],
              ),
              Column(
                children: [
                  const Text("Password"),
                  TextField(
                    onChanged: (value) => {password = value},
                    obscureText: true,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "YourPassword"),
                  )
                ],
              ),
              ElevatedButton(
                  onPressed: () async {
                    print("Tertekan!");
                  },
                  child: const Text("Masuk")),
              Row(
                children: [
                  const Text("Belum punya akun ? "),
                  InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RegisterScreen();
                            },
                          )),
                      child: const Text(
                        "Daftar!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          )))),
    );
  }
}
