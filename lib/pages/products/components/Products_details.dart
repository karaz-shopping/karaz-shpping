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
      appBar: AppBar(
        title: Text(
          "$name details",
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
        backgroundColor: AppColors.somo3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          elevation: 15,
                          shadowColor: AppColors.somo2,
                          color: AppColors.rose2,
                          child: Text(
                            name,
                            style: TextStyle(
                                color: AppColors.blueGreen1, fontSize: 30),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Card(
                          elevation: 15,
                          shadowColor: AppColors.somo2,
                          color: AppColors.rose2,
                          child: Text(
                            description,
                            style: TextStyle(
                                color: AppColors.blueGreen1, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/manPerfume.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.color_lens_outlined),
                title: Text(
                  color,
                  style: TextStyle(
                    color: AppColors.blueGreen4,
                    fontSize: 15,
                  ),
                ),
                trailing: const Icon(Icons.circle),
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
      ),
    );
  }
}
