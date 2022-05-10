class User {
  final int id;
  final String name;

  const User({
    required this.name,
    required this.id,
  });

  const User.empty({this.id = 0, this.name = ""});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      id: json['id'],
    );
  }
}
