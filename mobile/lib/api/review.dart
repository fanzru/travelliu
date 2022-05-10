import 'dart:convert';
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
    throw Exception('Failed to load all reviews');
  }
}
