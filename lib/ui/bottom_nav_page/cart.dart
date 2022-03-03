import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users-cart-item")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection('items')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var data = snapshot.data;
              if (snapshot.hasError) {
                return Center(
                  child: Text('something is worng'),
                );
              }
              if (data == null) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    DocumentSnapshot _documentsnapshot =
                        snapshot.data!.docs[index];
                    return ListTile(
                      leading: Text(_documentsnapshot['name']),
                      title: Text(
                        _documentsnapshot['price'].toString(),
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: GestureDetector(
                          onTap: () {
                            FirebaseFirestore.instance
                                .collection("users-cart-item")
                                .doc(FirebaseAuth.instance.currentUser?.email)
                                .collection('items')
                                .doc(_documentsnapshot.id)
                                .delete();
                          },
                          child: Icon(Icons.remove_circle_outlined)),
                    );
                  });
            }),
      ),
    );
  }
}
