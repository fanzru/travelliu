import 'package:mobile/model/user.dart';

class Komentar {
  final int id;
  final String komentar;
  User? user;

  Komentar({required this.id, required this.komentar, this.user});

  factory Komentar.fromJson(Map<String, dynamic> json) {
    var user = User.empty(id: json["user"]["id"], name: json["user"]["name"]);
    return Komentar(id: json["id"], komentar: json["komentar"], user: user);
  }
}
