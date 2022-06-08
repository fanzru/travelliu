import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:mobile/model/profile_secure.dart';

import "../model/review.dart";
import 'package:http/http.dart' as http;

Future<List<Review>> getAllReview() async {
  var response =
      await http.get(Uri.parse('https://travelliu.yaudahlah.my.id/api/review'));
  if (response.statusCode == 200) {
    List decoded = jsonDecode(response.body);
    List<Review> reviews = [];
    for (var review in decoded) {
      reviews.add(Review.fromJson(review, true));
    }
    return reviews;
  } else {
    return Future.error('Failed to load all reviews');
  }
}

Future<void> createReview(
    {required String nama,
    required String alamat,
    required String review,
    required String rating,
    required String photoPath,
    double? latitude,
    double? longitude}) async {
  if (latitude != null || longitude != null) {
    if (latitude == null || longitude == null) {
      return Future.error("Longitude and Latitude needs to be filled");
    }
  }

  var profile = await SecureProfile.getStorage();
  var token = profile.getApiKey();

  MultipartFile file = await MultipartFile.fromFile(photoPath);

  var formData = FormData.fromMap({
    "nama_tempat": nama,
    "alamat": alamat,
    "rating": rating.toString(),
    "review": review,
    "latitude": latitude,
    "longitude": longitude,
    "photo": file
  });

  var response =
      await Dio().post("https://travelliu.yaudahlah.my.id/api/review",
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              "Accept": "application/json",
            },
          ),
          data: formData);
  if (response.statusCode == 401) {
    profile.setLoggedOut();
    return Future.error("Session expired");
  }
  if (response.statusCode != 200) {
    return Future.error("Failed to post a review");
  }
}
