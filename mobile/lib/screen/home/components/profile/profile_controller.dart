import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/screen/home/components/profile/myprofile/my_profile.dart';
import 'package:mobile/screen/home/components/profile/not_loggedin.dart';

class ProfileSection extends StatefulWidget {
  ProfileSection({Key? key}) : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
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
            return const MyProfile();
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
