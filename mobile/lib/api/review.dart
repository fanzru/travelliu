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
      reviews.add(Review.fromJson(review));
    }
    return reviews;
  } else {
    return Future.error('Failed to load all reviews');
  }
}

Future<Review> getReviewById(int id) async {
  try {
    var response = await http
        .get(Uri.parse("https://travelliu.yaudahlah.my.id/api/review/$id"));
    if (response.statusCode == 200) {
      return Review.fromJson(jsonDecode(response.body));
    }
    Future.error("Tidak dapat mengambil review");
  } catch (e) {
    return Future.error(e);
  }
  return Future.error("Tidak dapat mengambil review");
}

Future<void> createReview(
    {required String nama,
    required String alamat,
    required String review,
    required double rating,
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
  Map<String, dynamic> request = {
    "nama_tempat": nama,
    "alamat": alamat,
    "rating": rating,
    "review": review,
    "photo": file
  };
  if (latitude != null && longitude != null) {
    request["latitude"] = latitude;
    request["longitude"] = longitude;
  }
  var formData = FormData.fromMap(request);
  try {
    var response =
        await Dio().post("https://travelliu.yaudahlah.my.id/api/review",
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
