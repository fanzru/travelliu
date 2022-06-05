class User {
  final int id;
  final String name;
  final String token;

  User({required this.name, required this.id, required this.token});

  const User.empty({this.id = 0, this.name = "", this.token = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], id: json['id'], token: "");
  }
}
