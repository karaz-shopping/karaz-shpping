import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/cart/cart.dart';
import 'package:karaz_shopping_organization/pages/home/home_page/custom_home.dart';
import 'package:karaz_shopping_organization/pages/user_profile/user_profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _indexPage = 0;
  final List _pages = const [
    CustomHome(),
    Cart(),
    UserProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 47,
        color: AppColors.somo3,
        buttonBackgroundColor: AppColors.blueGrey3,
        backgroundColor: Colors.transparent,
        items: [
          Icon(Icons.home,
              color: _indexPage == 0 ? AppColors.somo3 : Colors.black),
          Icon(Icons.shopping_cart_outlined,
              color: _indexPage == 1 ? AppColors.somo3 : Colors.black),
          Icon(Icons.person_outline,
              color: _indexPage == 2 ? AppColors.somo3 : Colors.black),
        ],
        onTap: (value) {
          setState(() {
            _indexPage = value;
          });
        },
      ),
      body: _pages[_indexPage],
    );
  }
}
