import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterecommerce/ui/login_screen.dart';
import 'package:flutterecommerce/ui/registration_screen.dart';
import 'package:flutterecommerce/ui/user_form.dart';

class SplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushNamed(context, LoginScreen.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_colors,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'E-Commerce',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
