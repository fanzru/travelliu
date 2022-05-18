import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/screen/myprofile/my_profile.dart';
import 'package:mobile/screen/profile/login_screen.dart';
import 'package:mobile/screen/profile/register_screen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<SecureProfile> futureProfile;

  @override
  void initState() {
    futureProfile = SecureProfile.getStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SecureProfile>(
      future: futureProfile,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Kalau misalkan logged in
          if (snapshot.data!.getLoggedInStatus()) {
            print(snapshot.data!.isLoggedIn);
            return MyProfile();
          } else {
            return const _NotLoggedIn();
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text("Error when local data"));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _NotLoggedIn extends StatelessWidget {
  const _NotLoggedIn({Key? key}) : super(key: key);

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
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ));
                },
                child: const Text(
                  "Masuk",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
                onPressed: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RegisterScreen();
                      }))
                    },
                child: const Text(
                  "Daftar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ]),
        ));
  }
}
