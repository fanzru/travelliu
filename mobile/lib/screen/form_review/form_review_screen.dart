import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile/api/review.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/utils/show_snackbar.dart';

class FormReviewScreenArguments {
  FormReviewScreenArguments();
}

class FormReviewScreen extends StatefulWidget {
  static String routeName = "/form-review";

  const FormReviewScreen({Key? key}) : super(key: key);

  @override
  State<FormReviewScreen> createState() => _FormReviewScreenState();
}

class _FormReviewScreenState extends State<FormReviewScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  bool isSwitched = false;
  final _formKey = GlobalKey<FormState>();
  bool submitActive = true;

  String? photoPath = null;
  Position? _currentPosition;

  _getCurrentLocation() async {
    try {
      setState(() {
        submitActive = false;
      });
      await Geolocator.requestPermission();
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true,
      );
      setState(() {
        _currentPosition = position;
        submitActive = true;
      });
    } on PermissionDefinitionsNotFoundException catch (err) {
      setState(() {
        isSwitched = false;
        submitActive = true;
      });
      throw "Permission tidak diberikan";
    } catch (err) {
      setState(() {
        isSwitched = false;
        submitActive = true;
      });
      throw "Gagal dalam mendapatkan lokasi";
    }
  }

  String? _textRequired(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Masukkan text";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    void _handleFilePicks() async {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        PlatformFile file = result.files.first;
        print(file.size);
        if (file.size > 5000000) {
          ShowSnackBar(context, "File terlalu besar");
          return;
        }
        setState(() {
          photoPath = file.path;
        });
      }
    }

    void submitReview() async {
      if (_formKey.currentState!.validate()) {
        try {
          if (photoPath == null) throw "Need to upload a photo";
          await createReview(
              nama: _nameController.text,
              alamat: _alamatController.text,
              review: _reviewController.text,
              rating: _ratingController.text,
              photoPath: photoPath!,
              latitude: _currentPosition!.latitude,
              longitude: _currentPosition!.longitude);
          ShowSnackBar(context, "Review berhasil terunggah");
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        } catch (err) {
          ShowSnackBar(context, "$err");
        }
      } else {
        ShowSnackBar(context, "There's some form not filled properly");
      }
    }

    void _handleKembaliButton() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.black12)),
                  onPressed: _handleKembaliButton,
                  child: const Text(
                    "Kembali",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
              Center(
                child: SingleChildScrollView(
                  reverse: true,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Share Your Moment",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Nama Tempat Wisata",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          validator: _textRequired,
                          controller: _nameController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Enter Name",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Alamat Tempat Wisata",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextFormField(
                          validator: _textRequired,
                          controller: _alamatController,
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            hintText: "Alamat",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Review Kamu!",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        TextFormField(
                          validator: _textRequired,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          controller: _reviewController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Tulis review",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Beri Rating 0-5",
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: 100,
                              child: TextFormField(
                                validator: _textRequired,
                                controller: _ratingController,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Rating",
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                const Text("Tambahkan Lokasi Saat Ini"),
                                Switch(
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      if (isSwitched) {
                                        _getCurrentLocation();
                                      } else {
                                        _currentPosition = null;
                                      }
                                    });
                                  },
                                  activeTrackColor: Colors.black,
                                  activeColor: Colors.white,
                                ),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        photoPath != null
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50),
                                ),
                                onPressed: _handleFilePicks,
                                child: const Text(
                                    'File Picked, click again if you want to change the photo',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black12,
                                        fontWeight: FontWeight.bold)))
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(50),
                                    primary: Colors.black),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Upload Photo',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    const Text(
                                      'Max 5MB',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                onPressed: _handleFilePicks),
                        const SizedBox(
                          height: 20,
                        ),
                        !submitActive
                            ? Text("Sedang mengambil lokasi")
                            : SizedBox.shrink(),
                        submitActive
                            ? ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.black)),
                                onPressed: submitReview,
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            : OutlinedButton(
                                onPressed: () {},
                                child: const Text('Submit',
                                    style: TextStyle(
                                        color: Colors.black12,
                                        fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
