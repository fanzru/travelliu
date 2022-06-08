import "../model/tikum.dart";
import 'package:http/http.dart' as http;
import "../model/profile_secure.dart";
import 'dart:convert';

Future<List<Tikum>> getAllTikum() async {
  var response =
      await http.get(Uri.parse('https://travelliu.yaudahlah.my.id/api/tikum'));
  if (response.statusCode == 200) {
    List decoded = jsonDecode(response.body);
    List<Tikum> tikums = [];
    for (var tikum in decoded) {
      tikums.add(Tikum.fromJson(tikum));
    }
    return tikums;
  } else {
    throw Exception('Failed to load all tikums');
  }
}

Future<List<TikumProfile>> getMyTikum() async {
  var profile = await SecureProfile.getStorage();
  var response = await http.get(
    Uri.https('travelliu.yaudahlah.my.id', '/api/user'),
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<TikumProfile> tikums = [];
    for (var tikum in decoded["tikum"]) {
      tikums.add(TikumProfile.fromJson(tikum, decoded["user"]["name"]));
    }
    return tikums;
  } else {
    throw Exception('Failed to load my tikums');
  }
}

Future<void> deleteMyTikum(int id) async {
  var profile = await SecureProfile.getStorage();

  if (!profile.isLoggedIn) {
    throw "User is not logged in";
  }

  final http.Response response = await http.delete(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/tikum/$id"),
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );

  if (response.statusCode != 200) {
    throw "Gagal menghapus post";
  }
}
