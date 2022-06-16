import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile/model/komentar.dart';
import 'package:mobile/model/profile_secure.dart';
import 'package:mobile/model/user.dart';

Future<Komentar> postKomentar(int reviewId, String komentar) async {
  var profile = await SecureProfile.getStorage();
  var formData = FormData.fromMap({"komentar": komentar});
  try {
    var response = await Dio()
        .post("https://travelliu.yaudahlah.my.id/api/komentar/$reviewId",
            options: Options(
              headers: {
                'Authorization': 'Bearer ${profile.getApiKey()}',
                "Accept": "application/json",
              },
            ),
            data: formData);
    var data = response.data;
    var user = User.empty(name: profile.name!);
    return Komentar(id: data["id"] as int, komentar: komentar, user: user);
  } on DioError catch (e) {
    if (e.response != null) {
      var response = e.response!;
      if (response.statusCode == 401) {
        await profile.setLoggedOut();
        return Future.error("Session expired");
      }
      if (response.statusCode == 400) {
        return Future.error(response.data);
      }
    }
    return Future.error("Gagal untuk mempost review");
  }
}
