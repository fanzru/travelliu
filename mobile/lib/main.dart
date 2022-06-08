import 'package:flutter/material.dart';
import 'package:mobile/screen/form_login/login_screen.dart';
import 'package:mobile/screen/form_register/register_screen.dart';
import 'package:mobile/screen/form_review/form_review_screen.dart';
import 'package:mobile/screen/form_tikum/form_tikum_screen.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/screen/review_detail/review_detail_screen.dart';
import 'package:mobile/screen/profile_detail/profile_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travelliu',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        fontFamily: "Poppins",
      ),
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        ReviewDetailScreen.routeName: (context) => const ReviewDetailScreen(),
        FormReviewScreen.routeName: (context) => const FormReviewScreen(),
        FormTikumScreen.routeName: (context) => const FormTikumScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ProfilePeopleScreen.routeName: (context) => ProfilePeopleScreen(),
      },
      initialRoute: HomeScreen.routeName,
    );
  }
}
