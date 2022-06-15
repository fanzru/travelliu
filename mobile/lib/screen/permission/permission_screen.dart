import 'package:flutter/material.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/screen/permission/components/permission_tile.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionScreenArguments {
  PermissionScreenArguments();
}

class PermissionScreen extends StatefulWidget {
  static String routeName = "/permission";
  PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool _permissionLocation = false;
  bool _permissionStroage = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void checkPermission() async {
    var storage = await Permission.storage.isGranted;
    var location = await Permission.location.isGranted;

    setState(() {
      _permissionStroage = storage;
      _permissionLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    void _givePermission() async {
      await [Permission.location, Permission.storage].request();
      if (await Permission.location.isDenied ||
          await Permission.storage.isDenied) {
        await openAppSettings();
      }
      checkPermission();
    }

    Widget _requestPermissionBox(bool isActive) {
      return isActive
          ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: _givePermission,
                  child: const Text(
                    "Minta Persetujuan",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          : SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Minta Persetujuan",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
            );
    }

    Widget _lanjutkanBox(bool isActive) {
      return isActive
          ? SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, HomeScreen.routeName, (route) => false);
                  },
                  child: const Text(
                    "Lanjutkan",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            )
          : SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Lanjutkan",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )),
            );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "Travelliu",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Text(
                      "Sebelum Mulai",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        "Kami Butuh beberapa Persetujuan untuk dapat menjalankan aplikasi ini dengan baik",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .55,
                  child: ListView(
                    children: [
                      PermissionTile(
                        title: "Izin Lokasi",
                        description:
                            "Digunakan untuk mengambil lokasi anda sekarang ketika anda hendak mengunggah review",
                        isActive: _permissionLocation,
                      ),
                      PermissionTile(
                        title: "Izin Penyimpanan",
                        description:
                            "Digunakan untuk mendapatkan akses untuk mengambil foto ketika anda hendak mengunggah review serta menyimpan data login anda",
                        isActive: _permissionStroage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                _requestPermissionBox(
                    !(_permissionLocation && _permissionStroage)),
                _lanjutkanBox(_permissionStroage)
              ],
            )
          ],
        ),
      ),
    );
  }
}
