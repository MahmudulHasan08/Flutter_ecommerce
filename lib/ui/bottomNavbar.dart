import 'package:flutter/material.dart';
import 'package:flutterecommerce/const/appcolors.dart';
import 'package:flutterecommerce/ui/bottom_nav_page/cart.dart';
import 'package:flutterecommerce/ui/bottom_nav_page/favourite.dart';
import 'package:flutterecommerce/ui/bottom_nav_page/home.dart';
import 'package:flutterecommerce/ui/bottom_nav_page/profile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavbar extends StatefulWidget {
  static const String id = 'bottomNavbar';

  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int _currentIndex = 0;
  final _pages = [Home(), Favourite(), Cart(), Profile()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.w,
        title: Text(
          'E-Commerce',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.w,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.blue,
        currentIndex: _currentIndex,
        selectedLabelStyle:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 40.w,
              ),
              title: Text('Home'),
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
                size: 40.w,
              ),
              title: Text('Favorite'),
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 40.w,
              ),
              title: Text('Cart'),
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 40.w,
              ),
              title: Text('Profile'),
              backgroundColor: Colors.grey),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _pages[_currentIndex],
    );
  }
}
