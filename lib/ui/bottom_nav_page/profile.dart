import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  Widget SetDataTextField(dynamic data) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(fillColor: Colors.blue),
          controller: _nameController =
              TextEditingController(text: data['name']),
        ),
        TextField(
          decoration: InputDecoration(fillColor: Colors.blue),
          controller: _phoneController =
              TextEditingController(text: data['contract']),
        ),
        TextField(
          decoration: InputDecoration(fillColor: Colors.blue),
          controller: _dobController = TextEditingController(text: data['dob']),
        ),
        TextField(
          decoration: InputDecoration(fillColor: Colors.blue),
          controller: _genderController =
              TextEditingController(text: data['gender']),
        ),
        TextField(
          decoration: InputDecoration(fillColor: Colors.blue),
          controller: _ageController = TextEditingController(text: data['age']),
        ),
        SizedBox(
          height: 40.h,
        ),
        SizedBox(
          height: 56.h,
          width: 1.sw,
          child: ElevatedButton(
            onPressed: () {
              updateUi();
            },
            child: Text(
              'UPDATE YOUR PROFILE',
              style: TextStyle(fontSize: 18.sp),
            ),
          ),
        ),
      ],
    );
  }

  updateUi() {
    CollectionReference _collectionref =
        FirebaseFirestore.instance.collection('users-data-form');
    return _collectionref.doc(FirebaseAuth.instance.currentUser?.email).update({
      'name': _nameController.text,
      'contract': _phoneController.text,
      'dob': _dobController.text,
      'gender': _genderController.text,
      'age': _ageController.text,
    }).then(
      (value) => print('update successfully'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users-data-form')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return SetDataTextField(data);
            },
          ),
        ),
      ),
    );
  }
}
