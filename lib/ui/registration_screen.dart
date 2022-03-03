import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterecommerce/ui/user_form.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'resgistration_Screen';
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText = true;
  String email = '';
  String password = '';
  final _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  signUp() async {
    try {
      // UserCredential userCredential = await FirebaseAuth.instance
      //     .createUserWithEmailAndPassword(
      //         email: _emailController.text, password: _passwordController.text);
      final userId = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // var authentical = userId.user;
      // if (authentical!.uid.isNotEmpty) {
      //   Navigator.pushNamed(context, UserFrom.id);
      // } else {
      //   Fluttertoast.showToast(msg: 'Something is wrong');

      if (userId != null) {
        Navigator.pushNamed(context, UserFrom.id);
      } else {
        Fluttertoast.showToast(msg: 'something is worng');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
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
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                    width: ScreenUtil().screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.light,
                          ),
                          color: Colors.transparent,
                        ),
                        Text(
                          'Sign Up',
                          style:
                              TextStyle(fontSize: 22.sp, color: Colors.white),
                        ),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28.r),
                    topRight: Radius.circular(28.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Buddy!',
                          style: TextStyle(
                            fontSize: 20.sp,
                            color: AppColors.deep_colors,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          'Glad to see you back my buddy.',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
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
                                color: AppColors.deep_colors,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
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
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Enter Your Email',
                                  hintStyle: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                  ),
                                  labelText: 'EMAIL',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.deep_colors,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 41.h,
                              width: 48.w,
                              decoration: BoxDecoration(
                                color: AppColors.deep_colors,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.lock_outline,
                                  color: Colors.white,
                                ),
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
                                controller: _passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                    hintText: 'Password must be 6 Characters',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14.sp,
                                    ),
                                    label: Text('PASSWORD'),
                                    labelStyle: TextStyle(
                                      color: AppColors.deep_colors,
                                      fontSize: 15.sp,
                                    ),
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(
                                          () {
                                            _obscureText = !_obscureText;
                                          },
                                        );
                                      },
                                      child: Icon(
                                        _obscureText
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        size: 20.w,
                                        color: AppColors.deep_colors,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        SizedBox(
                          height: 56.h,
                          width: 1.sw,
                          child: ElevatedButton(
                            onPressed: () {
                              signUp();
                            },
                            child: Text(
                              'Continue',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.deep_colors,
                              elevation: 3.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Do you have an account ?",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.deep_colors,
                                ),
                              ),
                              onTap: () {},
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
