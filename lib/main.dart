import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterecommerce/ui/bottomNavbar.dart';
import 'package:flutterecommerce/ui/login_screen.dart';
import 'package:flutterecommerce/ui/product_details_screen.dart';
import 'package:flutterecommerce/ui/registration_screen.dart';
import 'package:flutterecommerce/ui/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterecommerce/ui/user_form.dart';
import 'package:flutterecommerce/ui/bottomNavbar.dart';
import 'package:flutterecommerce/ui/searchscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () {
        return MaterialApp(
          title: 'Flutter e-Commerce',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: SplashScreen(),
          routes: {
            SplashScreen.id: (context) => SplashScreen(),
            RegistrationScreen.id: (context) => RegistrationScreen(),
            BottomNavbar.id: (context) => BottomNavbar(),
            UserFrom.id: (context) => UserFrom(),
            LoginScreen.id: (context) => LoginScreen(),
            BottomNavbar.id: (context) => BottomNavbar(),
            SearchScreen.id: (context) => SearchScreen(),
            // ProductScreen.id: (_) => ProductScreen()
          },
        );
      },
    );
  }
}
