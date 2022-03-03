import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutterecommerce/ui/bottom_nav_page/home.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductScreen extends StatefulWidget {
  // static const String id = 'productdetailscreen';
  var _product;
  ProductScreen(this._product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<String> _carouselImages = [];
  int _dotPosition = 0;

  Future addToCart() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionref =
        FirebaseFirestore.instance.collection('users-cart-item');
    return _collectionref
        .doc(currentUser?.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._product['product-name'],
      "price": widget._product['product-price'],
      "images": widget._product['product-img']
    }).then((value) => Fluttertoast.showToast(msg: 'Add to cart'));
  }

  Future addToFavourite() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference collectionref =
        FirebaseFirestore.instance.collection('user-fav-cart');
    return collectionref.doc(currentUser?.email).collection('items').doc().set({
      'name': widget._product['product-name'],
      'description': widget._product['product-description'],
      'price': widget._product['product-price'],
    }).then((value) => Fluttertoast.showToast(msg: 'add to  favourite cart'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.deep_colors,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 30.w,
                color: Colors.grey,
              ),
            ),
          ),
        ),
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users-favourite-items")
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .where("name", isEqualTo: widget._product['product-name'])
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Text("");
              }
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    onPressed: () => snapshot.data.docs.length == 0
                        ? addToFavourite()
                        : print("Already Added"),
                    icon: snapshot.data.docs.length == 0
                        ? Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            AspectRatio(
              aspectRatio: 3,
              child: CarouselSlider(
                  items: widget._product['product-img']
                      .map<Widget>((item) => Padding(
                            padding: const EdgeInsets.only(left: 4, right: 4),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                image: DecorationImage(
                                  image: NetworkImage(item),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      onPageChanged: (val, CarouselPageChangedReason) {
                        setState(() {
                          _dotPosition = val;
                        });
                      })),
            ),
            SizedBox(
              height: 10.h,
            ),
            DotsIndicator(
              dotsCount: 2,
              position: _dotPosition.toDouble(),
              decorator: DotsDecorator(
                activeColor: AppColors.deep_colors,
                color: AppColors.deep_colors.withOpacity(0.5),
                spacing: EdgeInsets.all(2),
                activeSize: Size(8, 8),
                size: Size(6, 6),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  widget._product['product-name'],
                  style: TextStyle(
                    fontSize: 25.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  widget._product['product-description'],
                  style: TextStyle(
                    fontSize: 22.sp,
                    letterSpacing: 1.5,
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  widget._product['product-price'].toString(),
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 56.h,
                width: 1.sw,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.deep_colors,
                    elevation: 3.0,
                  ),
                  onPressed: () {
                    addToCart();
                  },
                  child: Text(
                    'Add To Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                    ),
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
