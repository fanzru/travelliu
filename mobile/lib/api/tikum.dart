import "../model/tikum.dart";
import 'package:http/http.dart' as http;
import "../model/profile_secure.dart";
import 'dart:convert';
import 'package:dio/dio.dart';

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
    return Future.error('Failed to load all tikums');
  }
}

Future<List<TikumProfile>> getMyTikum() async {
  var profile = await SecureProfile.getStorage();
  var response = await http.get(
    Uri.https('travelliu.yaudahlah.my.id', '/api/user'),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );

  if (response.statusCode == 401) {
    profile.setLoggedOut();
    return Future.error("Session expired");
  }

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
    return Future.error("User is not logged in");
  }

  final http.Response response = await http.delete(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/tikum/$id"),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );

  if (response.statusCode == 401) {
    profile.setLoggedOut();
    return Future.error("Session expired");
  }

  if (response.statusCode != 200) {
    return Future.error("Gagal menghapus post");
  }
}

Future<void> createTikum({
  required String tujuan,
  required String kumpul,
  required String date,
  required String time,
  required String grup,
  required String deskripsi,
}) async {
  var profile = await SecureProfile.getStorage();
  var token = profile.getApiKey();

  Map<String, dynamic> request = {
    "tempat_tujuan": tujuan,
    "tempat_kumpul": kumpul,
    "waktu_kumpul": DateTime.parse("${date + "T" + time + ":00"}"),
    "link_group": grup,
    "deskripsi": deskripsi,
  };
  var formData = FormData.fromMap(request);
  try {
    var response =
        await Dio().post("https://travelliu.yaudahlah.my.id/api/tikum",
            options: Options(
              headers: {
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              },
            ),
            data: formData);
  } on DioError catch (e) {
    if (e.response != null) {
      var response = e.response!;
      if (response.statusCode == 401) {
        profile.setLoggedOut();
        return Future.error("Session expired");
      }
      if (response.statusCode == 400) {
        return Future.error(response.data);
      }
    }

    return Future.error("Gagal untuk mempost tikum");
  }
}
