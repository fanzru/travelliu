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
      required this.user,
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
