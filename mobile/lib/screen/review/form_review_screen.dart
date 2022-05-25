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
                        hintText: "Review",
                      ),
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
