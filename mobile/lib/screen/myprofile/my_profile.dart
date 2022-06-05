import 'package:flutter/material.dart';
import 'package:mobile/component/show_snackbar.dart';
import 'package:mobile/model/profile_secure.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Column(
        children: [
          Text("Kaenova"),
          Text("Mahendra"),
          Text("Auditama"),
          ElevatedButton(
              onPressed: () async {
                var profile = await SecureProfile.getStorage();
                profile.setLoggedOut();
                ShowSnackBar(context, "Berhasil keluar, harap pindah halaman");
              },
              child: const Text("Log Out"))
        ],
      )),
    );
  }
}
