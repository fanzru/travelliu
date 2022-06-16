import 'package:flutter/material.dart';
import 'package:mobile/api/komentar.dart';
import 'package:mobile/model/komentar.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/review_detail/components/komentar_card.dart';
import 'package:mobile/utils/show_snackbar.dart';

class DetailReviewKomentarSection extends StatefulWidget {
  final Review data;
  DetailReviewKomentarSection({Key? key, required this.data}) : super(key: key);

  @override
  State<DetailReviewKomentarSection> createState() =>
      _DetailReviewKomentarSectionState();
}

class _DetailReviewKomentarSectionState
    extends State<DetailReviewKomentarSection> {
  bool isLoggedIn = false;
  final TextEditingController _commentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late List<Komentar> comments;

  void _checkLogin() async {
    var profile = await SecureProfile.getStorage();
    setState(() {
      isLoggedIn = profile.getLoggedInStatus();
    });
  }

  String? _validRequired(String? txt) {
    if (txt == null || txt.isEmpty) {
      return "Komentar harus diisi";
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      comments = widget.data.komentar;
    });
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    void _handlePostComment() async {
      if (_formKey.currentState!.validate()) {
        try {
          showDialog(
              context: context,
              builder: (context) => const Center(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator(),
                    ),
                  ));
          String komentar = _commentController.text;
          Komentar sentKomentar = await postKomentar(widget.data.id, komentar);
          _commentController.clear();
          setState(() {
            comments.insert(0, sentKomentar);
          });
          Navigator.pop(context);
        } catch (e) {
          Navigator.pop(context);
          ShowSnackBar(context, e.toString());
        }
      }
    }

    return Column(
      children: [
        isLoggedIn
            ? Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _commentController,
                        validator: _validRequired,
                        decoration: InputDecoration(
                          hintText: "Masukkan komentar",
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 13,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: _handlePostComment,
                      child: const Center(
                        child: Text(
                          "Kirim",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ))
            : const SizedBox.shrink(),
        for (var komentar in comments)
          Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              KomentarCard(data: komentar),
            ],
          ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
