
import 'package:flutter/material.dart';

import 'page_view_item.dart';

class CustomPageView extends StatelessWidget {
  const CustomPageView({super.key, @required this.pageController});
  final PageController? pageController;


  @override
  Widget build(BuildContext context) {
    return PageView(
      controller:pageController ,
      children: [
        Expanded(
          child: PageViewItem(
              image: "assets/images/ff.png",
              title: "Online Shoping",
              subTitle: "Explore  top flowers & get them"),
        ),
        Expanded(
          child: PageViewItem(
              image: "assets/images/onTheWay.png",
              title: "Delivery on the way",
              subTitle: "Get your order by speed delivery"),
        ),
        Expanded(
          child: PageViewItem(
              image: "assets/images/arrived.png",
              title: "Delivery Arrived",
              subTitle: "Order is arrived at your Place"),
        )
      ],
    );
  }
}