import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/screen/myprofile/my_profile.dart';
import 'package:mobile/screen/profile/not_loggedin.dart';

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
            return const NotLoggedIn();
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
