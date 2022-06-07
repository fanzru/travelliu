import "./user.dart";

class Review {
  final int userId, id, numKomentar;
  final double rating;
  final String namaTempat, alamat, review, photo;
  final User user;
  final double? longitude, latitude;

  const Review(
      {required this.userId,
      required this.id,
      required this.photo,
      required this.rating,
      required this.namaTempat,
      required this.review,
      required this.alamat,
      this.user = const User.empty(),
      this.longitude,
      this.latitude,
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

    if (json["latitude"] != null) {
      if (json["latitude"] is int) {
        json["latitude"] = json["latitude"] as int;
        json["latitude"] = json["latitude"].toDouble();
      }
      json["latitude"] = json["latitude"] as double;
    }

    if (json["longitude"] != null) {
      if (json["longitude"] is int) {
        json["longitude"] = json["longitude"] as int;
        json["longitude"] = json["longitude"].toDouble();
      }
      json["longitude"] = json["longitude"] as double;
    }

    return Review(
        userId: json['user_id'],
        id: json['id'],
        alamat: json["alamat"],
        namaTempat: json["nama_tempat"],
        photo: json["photo"],
        rating: json["rating"].toDouble(),
        review: review,
        latitude: json["latitude"],
        longitude: json["longitude"],
        numKomentar: json["komentar_count"],
        user: user);
  }
}

class ReviewProfile {
  final int userId, id, numKomentar;
  final double rating;
  final String namaTempat, alamat, review, photo, nameUser;
  final double? longitude, latitude;

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

    if (json["latitude"] != null) {
      if (json["latitude"] is int) {
        json["latitude"] = json["latitude"] as int;
        json["latitude"] = json["latitude"].toDouble();
      }
      json["latitude"] = json["latitude"] as double;
    }

    if (json["longitude"] != null) {
      if (json["longitude"] is int) {
        json["longitude"] = json["longitude"] as int;
        json["longitude"] = json["longitude"].toDouble();
      }
      json["longitude"] = json["longitude"] as double;
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
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }
}
