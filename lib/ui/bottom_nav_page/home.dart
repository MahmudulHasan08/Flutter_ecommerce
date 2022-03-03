import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutterecommerce/ui/product_details_screen.dart';
import 'package:flutterecommerce/ui/searchscreen.dart';

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _searchControler = TextEditingController();

  List<String> _carouselImages = [];
  int _dotPosition = 0;

  fetchCarsoulImages() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot _qn =
        await _firestoreInstance.collection('carousel-slider').get();
    setState(() {
      for (int i = 0; i < _qn.docs.length; i++) {
        _carouselImages.add(
          _qn.docs[i]['img-path'],
        );
        print(_qn.docs[i]['img-path']);
      }
    });
    return _qn.docs;
  }

  List _products = [];
  fetchProducts() async {
    var _firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot _qn = await _firestoreInstance.collection('products').get();
    setState(() {
      for (int i = 0; i < _qn.docs.length; i++) {
        _products.add({
          "product-name": _qn.docs[i]["product-name"],
          "product-price": _qn.docs[i]["product-price"],
          "product-description": _qn.docs[i]["product-description"],
          "product-img": _qn.docs[i]["product-img"]
        });
      }
    });
    return _qn.docs;
  }

  @override
  void initState() {
    super.initState();
    fetchCarsoulImages();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 15.w, right: 15.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 60.h,
                        child: TextField(
                          controller: _searchControler,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            hintText: 'Search Product Here',
                            hintStyle: TextStyle(
                              fontSize: 15.sp,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.w),
                              borderSide: BorderSide(
                                color: Colors.teal,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.w),
                              borderSide: BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SearchScreen.id);
                      },
                      child: Container(
                        color: AppColors.deep_colors,
                        height: 60.h,
                        width: 60.w,
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30.w,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              AspectRatio(
                aspectRatio: 3,
                child: CarouselSlider(
                    items: _carouselImages
                        .map((item) => Padding(
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
                dotsCount:
                    _carouselImages.length == 0 ? 1 : _carouselImages.length,
                position: _dotPosition.toDouble(),
                decorator: DotsDecorator(
                  activeColor: AppColors.deep_colors,
                  color: AppColors.deep_colors.withOpacity(0.5),
                  spacing: EdgeInsets.all(2),
                  activeSize: Size(8, 8),
                  size: Size(6, 6),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) {
                            //       ProductScreen(_products[index]);
                            //     },
                            //   ),
                            // );
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        ProductScreen(_products[index])));
                          },
                          child: Card(
                            elevation: 3.w,
                            child: Column(
                              children: [
                                AspectRatio(
                                    aspectRatio: 1.3,
                                    child: Image.network(
                                        _products[index]['product-img'][0])),
                                Text(_products[index]['product-name']),
                                Text(_products[index]['product-price']
                                    .toString())
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
