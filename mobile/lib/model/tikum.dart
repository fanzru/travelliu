import "./user.dart";

class Tikum {
  final int userId, id;
  final String tempatTujuan, tempatKumpul;
  final String? deskripsi, linkGroup;
  final DateTime waktuKumpul;
  final User user;

  const Tikum(
      {required this.userId,
      required this.id,
      required this.tempatKumpul,
      required this.tempatTujuan,
      this.deskripsi,
      this.linkGroup,
      required this.waktuKumpul,
      this.user = const User.empty()});

  factory Tikum.fromJson(Map<String, dynamic> json) {
    var user = User.fromJson(json["user"]);
    return Tikum(
        userId: json['user_id'],
        id: json['id'],
        deskripsi: json["deskripsi"],
        linkGroup: json["link_group"],
        tempatKumpul: json["tempat_kumpul"],
        tempatTujuan: json["tempat_tujuan"],
        waktuKumpul: DateTime.parse(json["waktu_kumpul"]),
        user: user);
  }
}
