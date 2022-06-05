import 'dart:convert';
import "../model/review.dart";
import "../model/user.dart";
import "../model/profile.dart";
import "../model/profile_secure.dart";
import 'package:http/http.dart' as http;
import 'dart:async';

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

Future<List<ReviewProfile>> getMyReviewById() async {
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
    List<ReviewProfile> reviews = [];
    for (var review in decoded["review"]) {
      reviews
          .add(ReviewProfile.fromJson(review, true, decoded["user"]["name"]));
    }
    return reviews;
  } else {
    throw Exception('Failed to load all reviews');
  }
}

Future<Profile> getMyProfileById() async {
  var profile = await SecureProfile.getStorage();
  var response = await http.get(
    Uri.https('travelliu.yaudahlah.my.id', '/api/user'),
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer ${profile.getApiKey()}',
    },
  );

  if (response.statusCode == 200) {
    var decoded = jsonDecode(response.body);
    Profile profile = Profile.fromJson(decoded);
    return profile;
  } else {
    throw Exception('Failed to load all reviews');
  }
}

Future<bool> deleteMyReview(int id) async {
  if (id == 0) {
    return false;
  }
  final http.Response response = await http.delete(
    Uri.parse("https://travelliu.yaudahlah.my.id/api/review/$id"),
    headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer 55|7O6jSGXSFJyK8i9rnnlPmDrzLPsQmj4wfiIIgjyF',
    },
  );
  if (response.statusCode == 200) {
    return true;
  }
  return false;
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
