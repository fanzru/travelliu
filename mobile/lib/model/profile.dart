import "./user.dart";
import "./review.dart";

class Profile {
  final dynamic avgRating, totalReview;
  // final List<ReviewProfile> reviews;
  final User user;

  const Profile({
    this.user = const User.empty(),
    // required this.reviews,
    this.totalReview = 0,
    this.avgRating = 0,
  });
  const Profile.empty({
    this.totalReview = 0,
    this.avgRating = 0,
    this.user = const User.empty(),
    // this.reviews = const Review.empty(),
  });
  factory Profile.fromJson(Map<String, dynamic> json) {
    var user = User.fromJson(json["user"]);
    print(user);
    return Profile(
      user: user,
      // reviews: json["reviews"],
      totalReview: json["total_review"],
      avgRating: json["avg_ratings"],
    );
  }
}
