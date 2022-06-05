import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FormReview extends StatefulWidget {
  const FormReview({Key? key}) : super(key: key);

  @override
  State<FormReview> createState() => _FormReviewState();
}

class _FormReviewState extends State<FormReview> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  bool isSwitched = false;
  final _formKey = GlobalKey<FormState>();
  String fullName = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                      "Share Your Moment",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                      controller: _nameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Name",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Alamat Tempat Wisata",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      controller: _alamatController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Alamat",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Review Kamu!",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      controller: _reviewController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "Tulis review",
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Beri Rating 0-5",
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Flexible(
                            child: TextFormField(
                              controller: _ratingController,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                hintText: "Rating",
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Text("Tambahkan Lokasi Saat Ini"),
                        ),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                              print(isSwitched);
                            });
                          },
                          activeTrackColor: Colors.black,
                          activeColor: Colors.white,
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('UPLOAD FILE'),
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(type: FileType.image);

                        if (result != null) {
                          PlatformFile file = result.files.first;

                          print(file.name);
                          print(file.size);
                          print(file.extension);
                          print(file.path);
                        } else {
                          // User canceled the picker
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
