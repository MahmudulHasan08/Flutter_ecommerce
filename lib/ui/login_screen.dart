import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterecommerce/ui/bottomNavbar.dart';
import 'package:flutterecommerce/ui/registration_screen.dart';
import 'package:flutterecommerce/ui/user_form.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = true;
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  SignIn() async {
    final userId = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    try {
      if (userId != null) {
        Navigator.pushNamed(context, BottomNavbar.id);
      } else {
        Fluttertoast.showToast(
            msg: 'Something is worng ', textColor: Colors.black);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_colors,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  SizedBox(
                    width: ScreenUtil().screenWidth,
                    height: 150.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.light,
                            size: 20.w,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Sing In',
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(22.r),
                    topRight: Radius.circular(22.r),
                  ),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.deep_colors,
                          ),
                        ),
                        SizedBox(
                          height: 6.h,
                        ),
                        Text(
                          'Glad to see you back my buddy.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 41.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                color: AppColors.deep_colors,
                              ),
                              child: Icon(
                                Icons.email,
                                size: 22.w,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  email = value;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Enter Your Email',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16.sp,
                                    ),
                                    label: Text(
                                      'EMAIL',
                                      style: TextStyle(
                                        color: AppColors.deep_colors,
                                        fontSize: 16.sp,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 41.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                color: AppColors.deep_colors,
                              ),
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.white,
                                size: 22.w,
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  password = value;
                                },
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: 'Password at least 6 character',
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 16.sp,
                                  ),
                                  labelText: 'PASSWORD',
                                  labelStyle: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.deep_colors,
                                  ),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                    child: Icon(_obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        SizedBox(
                          height: 56.h,
                          width: 1.sw,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.deep_colors,
                              elevation: 3.0,
                            ),
                            onPressed: () {
                              SignIn();
                            },
                            child: Text(
                              'Sign IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Don't have an account ?",
                              style: TextStyle(
                                color: Colors.grey.shade800,
                                fontSize: 14.sp,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, RegistrationScreen.id);
                              },
                              child: Text('Sing Up',
                                  style: TextStyle(
                                    color: AppColors.deep_colors,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
// }
// }
