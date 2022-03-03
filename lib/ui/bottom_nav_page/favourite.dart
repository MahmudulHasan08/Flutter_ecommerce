import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("user-fav-cart")
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
                                .collection('user-fav-cart')
                                .doc(FirebaseAuth.instance.currentUser?.email)
                                .collection('items')
                                .doc(_documentsnapshot.id)
                                .delete();
                          },
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )),
                    );
                  });
            }),
      ),
    );
  }
}
