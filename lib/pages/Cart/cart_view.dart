// import 'dart:math';
// import 'dart:typed_data';
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/Cart/Itemes_View.dart';
import 'package:karaz_shopping_organization/pages/products/components/product_card.dart';

import '../../Themes/app_colors.dart';

import '../home/components/appBar/custom_app_bar.dart';
import 'payment/confirmSheet.dart';
// import 'payment/pay.dart';

class Cart_View extends StatefulWidget {
  String name;
  String price;
  Cart_View({
    super.key,
    required this.name,
    required this.price,
  });

  @override
  State<Cart_View> createState() => _Cart_ViewState();
}

class _Cart_ViewState extends State<Cart_View> {
  // CartService cartSErvice = CartService();
  // CartList? cartList;
  List<ProductCard> cartItem = [];

  // TextEditingController _quantity = TextEditingController();

  String? quantity;

  int sum = 0;
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(appbartitle: "Basket"),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.somo4,
        child: const ConfirmSheet(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/gifts.jpg"),
            const SizedBox(
              height: 17,
            ),
            Text("Receipt",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.purple2)),
            Container(
                height: 80,
                width: double.infinity,
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 172, 153, 153),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Total amount",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      // total card-------------------------------------------
                      child: Card(
                          elevation: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text("$sum"),
                          )),
                    )
                  ],
                )),
            const ItemesView(),
          ],
        ),
      )),
    );
  }
}
