// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class ProductsDetails extends StatelessWidget {
  String name;

  String description;
  String color;

  String price;

  String Email;

  String Type;

  ProductsDetails(
      {super.key,
      required this.name,
      required this.description,
      required this.color,
      required this.price,
      required this.Email,
      required this.Type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Products Details")),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$name details",
              style: TextStyle(
                color: AppColors.blueGreen1,
                fontSize: 35,
              ),
            ),
            Container(
              clipBehavior: Clip.none,
              width: double.infinity,
              height: 90,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/manPerfume.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 15,
              shadowColor: AppColors.somo2,
              color: AppColors.rose2,
              child: Text(
                name,
                style: TextStyle(color: AppColors.blueGreen1, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 15,
              shadowColor: AppColors.somo2,
              color: AppColors.rose2,
              child: Text(
                description,
                style: TextStyle(color: AppColors.blueGreen1, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 15,
              shadowColor: AppColors.somo2,
              color: AppColors.rose2,
              child: Text(
                color,
                style: TextStyle(color: AppColors.blueGreen1, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 15,
              shadowColor: AppColors.somo2,
              color: AppColors.rose2,
              child: Text(
                price,
                style: TextStyle(color: AppColors.blueGreen1, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 15,
              shadowColor: AppColors.somo2,
              color: AppColors.rose2,
              child: Text(
                Type,
                style: TextStyle(color: AppColors.blueGreen1, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Card(
              elevation: 15,
              shadowColor: AppColors.somo2,
              color: AppColors.rose2,
              child: Text(
                "contact with us $Email",
                style: TextStyle(color: AppColors.blueGreen1, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
