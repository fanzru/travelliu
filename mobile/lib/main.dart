import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mobile/screen/form_login/login_screen.dart';
import 'package:mobile/screen/form_register/register_screen.dart';
import 'package:mobile/screen/form_review/form_review_screen.dart';
import 'package:mobile/screen/form_tikum/form_tikum_screen.dart';
import 'package:mobile/screen/home/home_screen.dart';
import 'package:mobile/screen/permission/permission_screen.dart';
import 'package:mobile/screen/review_detail/review_detail_screen.dart';
import "dart:async";
import 'package:mobile/screen/profile_detail/profile_detail_screen.dart';
import 'package:permission_handler/permission_handler.dart';

Future timeoutTest10s() {
  Future foo = Future.delayed(const Duration(seconds: 2));
  return foo.timeout(Duration(seconds: 2), onTimeout: () {});
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await timeoutTest10s();

  bool isHomeScreen = await checkShowPermission();

  String initialRoute = PermissionScreen.routeName;
  if (isHomeScreen) initialRoute = HomeScreen.routeName;
  runApp(MyApp(
    initialRoute: initialRoute,
  ));
  FlutterNativeSplash.remove();
}

Future<bool> checkShowPermission() async {
  var storage = await Permission.storage.isGranted;
  var location = await Permission.location.isGranted;

  return storage && location;
}

class MyApp extends StatelessWidget {
  String initialRoute = HomeScreen.routeName;
  MyApp({Key? key, required this.initialRoute}) : super(key: key);

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
        ReviewDetailScreen.routeName: (context) => ReviewDetailScreen(),
        FormReviewScreen.routeName: (context) => const FormReviewScreen(),
        FormTikumScreen.routeName: (context) => const FormTikumScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        ProfilePeopleScreen.routeName: (context) => ProfilePeopleScreen(),
        PermissionScreen.routeName: (context) => PermissionScreen()
      },
      initialRoute: initialRoute,
    );
  }
}
