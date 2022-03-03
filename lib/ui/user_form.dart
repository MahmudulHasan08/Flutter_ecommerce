import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterecommerce/ui/bottomNavbar.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserFrom extends StatefulWidget {
  static const String id = 'userfrom';
  const UserFrom({Key? key}) : super(key: key);

  @override
  _UserFromState createState() => _UserFromState();
}

class _UserFromState extends State<UserFrom> {
  List<String> gender = ['Male', 'Female', 'other'];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contractController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _GenderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  Future<void> selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year),
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 2),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  sendUserDB() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionref =
        FirebaseFirestore.instance.collection('users-data-form');
    return _collectionref
        .doc(currentUser?.email)
        .set({
          'name': _nameController.text,
          'contract': _contractController.text,
          'dob': _dobController.text,
          'gender': _GenderController.text,
          'age': _ageController.text
        })
        .then((value) => print('datebase added'))
        .catchError(
          (error) => Fluttertoast.showToast(msg: 'something is worng'),
        );
  }

  Future<void> _selectDateFromPicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked != null)
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deep_colors,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 150.h,
              width: ScreenUtil().screenWidth,
              child: Padding(
                padding: EdgeInsets.only(top: 25.w, left: 10.w, bottom: 5.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Submit the form to continue',
                      style: TextStyle(
                        fontSize: 25.sp,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'We will not share your information with anyone.',
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x782F9FCB),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r)),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Reusabletextfield(
                        controller: _nameController,
                        hint: 'Enter your name',
                        label: 'Name',
                      ),
                      Reusabletextfield(
                        controller: _contractController,
                        hint: 'Enter your Phone number',
                        label: 'Contract',
                      ),
                      Reusabletextfield(
                        controller: _dobController,
                        hint: 'Enter your Date of birth',
                        label: 'Date OF Birth',
                        suffixIcon: IconButton(
                          onPressed: () => selectDateFromPicker(context),
                          icon: Icon(Icons.calendar_today_outlined),
                        ),
                      ),
                      Reusabletextfield(
                        prefixIcon: DropdownButton<String>(
                          items: gender.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                              onTap: () {
                                setState(() {
                                  _GenderController.text = value;
                                });
                              },
                            );
                          }).toList(),
                          onChanged: (_) {},
                        ),
                        controller: _GenderController,
                        hint: 'Choose Gender',
                        label: 'Gender',
                      ),
                      Reusabletextfield(
                        controller: _ageController,
                        hint: 'Enter your Age',
                        label: 'AGE',
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 56,
                        width: 1.sw,
                        child: ElevatedButton(
                          onPressed: () {
                            sendUserDB();
                            Navigator.pushNamed(context, BottomNavbar.id);
                          },
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18.sp,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: AppColors.deep_colors),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Reusabletextfield extends StatelessWidget {
  Reusabletextfield(
      {required this.label,
      required this.hint,
      required this.controller,
      this.suffixIcon,
      this.prefixIcon});
  final String hint;
  final String label;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Expanded(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              hintText: hint,
              fillColor: Colors.cyan,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: Colors.cyan,
              ),
              suffixIcon: suffixIcon,
              labelText: label,
              labelStyle: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
