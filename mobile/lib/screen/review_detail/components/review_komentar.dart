import 'package:flutter/material.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/model/review.dart';
import 'package:mobile/screen/review_detail/components/komentar_card.dart';

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

  void _handlePostComment() async {}

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isLoggedIn
            ? Form(
                child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _commentController,
                      validator: _validRequired,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.black)),
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
        for (var komentar in widget.data.komentar)
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
