import 'dart:convert';
import "../model/review.dart";
import "../model/profile.dart";
import "../model/profile_secure.dart";
import 'package:http/http.dart' as http;
import 'dart:async';

Future<void> loginUser(String email, String password) async {
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

    var profile = await SecureProfile.getStorage();
    profile.setLoggedIn(id, token);
  } else if (response.statusCode == 400) {
    return Future.error("Email atau password salah");
  } else {
    return Future.error("Server sedang bermasalah");
  }
}

Future<String> registerUser(String nama, String email, String password) async {
  var response = await http.post(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/register"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(
        <String, String>{'name': nama, 'email': email, "password": password}),
  );

  if (response.statusCode == 200) {
    return "Sukses";
  } else if (response.statusCode == 400) {
    return Future.error("Nama, Email, atau Password tidak valid");
  } else {
    return Future.error("Server sedang bermasalah");
  }
}

Future<List<ReviewProfile>> getMyReviewById() async {
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
    return Future.error("Session expired, please login again");
  }

  if (response.statusCode == 200) {
    Map<String, dynamic> decoded = jsonDecode(response.body);
    List<ReviewProfile> reviews = [];
    for (var review in decoded["review"]) {
      reviews
          .add(ReviewProfile.fromJson(review, true, decoded["user"]["name"]));
    }
    return reviews;
  } else {
    return Future.error('Failed to load all reviews');
  }
}

Future<Profile> getMyProfileById() async {
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
    return Future.error("Session expired, please login again");
  }

  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    Profile profile = Profile.fromJson(decoded);
    return profile;
  } else {
    return Future.error('Failed to load all reviews');
  }
}

Future<void> deleteMyReview(int id) async {
  var profile = await SecureProfile.getStorage();

  if (!profile.isLoggedIn) {
    return Future.error("User is not logged in");
  }

  final http.Response response = await http.delete(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/review/$id"),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );

  if (response.statusCode == 401) {
    profile.setLoggedOut();
    return Future.error("Session expired, please login again");
  }

  if (response.statusCode != 200) {
    return Future.error("Gagal menghapus post");
  }
}

Future<void> userLogout() async {
  var profile = await SecureProfile.getStorage();

  if (!profile.isLoggedIn) {
    return Future.error("User is not logged in");
  }

  var res = await http.post(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/logout"),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );

  if (res.statusCode == 401) {
    profile.setLoggedOut();
    return Future.error("Session expired, please login again");
  }

  if (res.statusCode != 200) {
    return Future.error("Failed to logout");
  }

  profile.setLoggedOut();
}

// Future<Profile> getMyReviewById() async {
//   var response = await http.get(
//     Uri.https('travelliu.yaudahlah.my.id', '/api/user/2'),
//   );

//   if (response.statusCode == 200) {
//     List decoded = jsonDecode(response.body);
//     Profile profile = const Profile.empty();
//     profile.add(ReviewProfile.fromJson(profile, true));

//     return reviews;
//   } else {
//     throw Exception('Failed to load all reviews');
//   }
// }
