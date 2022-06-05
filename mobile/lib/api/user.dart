import 'dart:convert';

import 'package:mobile/model/user.dart';
import 'package:http/http.dart' as http;

Future<User> loginUser(String email, String password) async {
  var response = await http.post(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/login"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'email': email, "password": password}),
  );

  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    var token = decoded["token"];
    var id = decoded["user"]["id"];
    var name = decoded["user"]["name"];
    return User(id: id, name: name, token: token);
  } else if (response.statusCode == 400) {
    throw "Email atau password salah";
  } else {
    throw "Server sedang bermasalah";
  }
}
