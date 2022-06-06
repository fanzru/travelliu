import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile/api/user.dart';
import 'package:mobile/screen/form_register/register_screen.dart';
import 'package:mobile/utils/show_snackbar.dart';
import 'package:mobile/model/profile_secure.dart';

class LoginScreenArguments {
  LoginScreenArguments();
}

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";

  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleMasuk() async {
    if (_formKey.currentState!.validate()) {
      // If valid
      try {
        var user =
            await loginUser(_emailController.text, _passwordController.text);
        var profile = await SecureProfile.getStorage();
        profile.setLoggedIn(user.id, user.token);
        ShowSnackBar(
            context, "Selamat datang ${user.name}, harap pindah halaman");
        Navigator.pop(context);
      } catch (err) {
        ShowSnackBar(context, "$err");
      }
    }
  }

  void _handleKembaliButton() {
    Navigator.pop(context);
  }

  String? _validEmail(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Masukkan email";
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(txt)) {
      return "Email tidak valid";
    }
    return null;
  }

  String? _validPassword(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Masukkan password";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.black12)),
                        onPressed: _handleKembaliButton,
                        child: const Text(
                          "Kembali",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )),
                    Expanded(
                        child: Center(
                            child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Travelliu",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const Text(
                          "Log in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 21),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Email"),
                                    TextFormField(
                                      controller: _emailController,
                                      validator: _validEmail,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Password"),
                                    TextFormField(
                                      controller: _passwordController,
                                      validator: _validPassword,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.black)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.black)),
                                    onPressed: _handleMasuk,
                                    child: const Text(
                                      "Masuk",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Belum punya akun ? "),
                            InkWell(
                                onTap: () =>
                                    Navigator.push(context, MaterialPageRoute(
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
                    )))
                  ],
                )),
          )),
    );
  }
}
