import 'package:flutter/material.dart';
import 'package:mobile/screen/profile/login_screen.dart';
import 'package:mobile/screen/profile/register_screen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(children: [
          Text("You're not logged in"),
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ))
                  },
              child: Text("Login")),
          ElevatedButton(
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RegisterScreen();
                    }))
                  },
              child: Text("Daftar"))
        ]),
      ),
    );
  }
}
