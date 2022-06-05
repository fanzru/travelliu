import "./user.dart";

class Review {
  final int userId, id, numKomentar;
  final double longitude, latitude, rating;
  final String namaTempat, alamat, review, photo;
  final User user;

  const Review(
      {required this.userId,
      required this.id,
      required this.photo,
      required this.rating,
      required this.namaTempat,
      required this.review,
      required this.alamat,
      this.user = const User.empty(),
      this.longitude = 0,
      this.latitude = 0,
      this.numKomentar = 0});

  factory Review.fromJson(Map<String, dynamic> json, bool concatReview) {
    var user = User.fromJson(json["user"]);
    String review = json["review"];
    if (concatReview) {
      if (review.length > 200) {
        review = review.substring(0, 195);
        review = review + " ...";
      }
    }
    return Review(
        userId: json['user_id'],
        id: json['id'],
        alamat: json["alamat"],
        namaTempat: json["nama_tempat"],
        photo: json["photo"],
        rating: json["rating"].toDouble(),
        review: review,
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        numKomentar: json["komentar_count"],
        user: user);
  }
}

class ReviewProfile {
  final int userId, id, numKomentar;
  final double longitude, latitude, rating;
  final String namaTempat, alamat, review, photo, nameUser;

  const ReviewProfile(
      {required this.nameUser,
      required this.userId,
      required this.id,
      required this.photo,
      required this.rating,
      required this.namaTempat,
      required this.review,
      required this.alamat,
      this.longitude = 0,
      this.latitude = 0,
      this.numKomentar = 0});

  const ReviewProfile.empty(
      {this.nameUser = "",
      this.id = 0,
      this.userId = 0,
      this.photo = "",
      this.rating = 0,
      this.namaTempat = "",
      this.alamat = "",
      this.latitude = 0,
      this.longitude = 0,
      this.numKomentar = 0,
      this.review = ""});
  factory ReviewProfile.fromJson(
      Map<String, dynamic> json, bool concatReview, String name) {
    String review = json["review"];
    if (concatReview) {
      if (review.length > 200) {
        review = review.substring(0, 195);
        review = review + " ...";
      }
    }
    return ReviewProfile(
      nameUser: name,
      userId: json['user_id'],
      id: json['id'],
      alamat: json["alamat"],
      namaTempat: json["nama_tempat"],
      photo: json["photo"],
      rating: json["rating"].toDouble(),
      review: review,
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
    );
  }
}
