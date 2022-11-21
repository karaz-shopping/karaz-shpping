// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/chat/message.dart';

class ProductsDetails extends StatefulWidget {
  String name;

  String description;
  String color;

  String price;

  String Email;

  String Type;
  String StoreID;
  ProductsDetails({
    super.key,
    required this.name,
    required this.description,
    required this.color,
    required this.price,
    required this.Email,
    required this.Type,
    required this.StoreID,
  });

  @override
  State<ProductsDetails> createState() => _ProductsDetailsState();
}

class _ProductsDetailsState extends State<ProductsDetails> {
  var bayerName = "";
  var bayerEmail = "";
  var bayerAbout = "";
  var bayerID = "";
  var bayerPhoneNumber = "";
  var bayerRole = "";

  var sellerName = "";
  var sellerEmail = "";
  var sellerAbout = "";
  var sellerID = "";
  var sellerPhoneNumber = "";
  var sellerRole = "";

  @override
  void initState() {
    getUsersInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.name} details",
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
        backgroundColor: AppColors.somo3,
        iconTheme: IconThemeData(color: AppColors.blueGrey3),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 15,
                          shadowColor: AppColors.somo2,
                          color: AppColors.rose2,
                          child: Text(
                            widget.name,
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
                            widget.description,
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
                  widget.color,
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
                  widget.price,
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
                  widget.Type,
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
                child: InkWell(
                  onTap: () {
                    getBayerData();
                  },
                  child: Text(
                    "contact with us ${widget.Email}",
                    style: TextStyle(color: AppColors.blueGreen1, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getBayerData() async {
    var bayerid = FirebaseAuth.instance.currentUser!.uid;
    var contact = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("contact")
        .doc(widget.StoreID)
        .get();
    if (widget.StoreID == bayerid) {
    } else if (contact.exists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Message(
              name: "name",
              img: "",
              id: "id",
            );
          },
        ),
      );
    } else {
      //add seller to bayer contact
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("contact")
          .doc(sellerID)
          .set({
        "Name": sellerName,
        "id": sellerID,
        "About": sellerAbout,
        "Email": sellerEmail,
        "PhoneNumber": sellerPhoneNumber,
        "Role": sellerRole,
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.StoreID)
          .collection("contact")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "Name": bayerName,
        "id": bayerID,
        "About": bayerAbout,
        "Email": bayerEmail,
        "PhoneNumber": bayerPhoneNumber,
        "Role": bayerRole,
      });
    }
  }

  getUsersInfo() async {
    var bayerInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var SellerInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.StoreID)
        .get();
    setState(() {
      bayerName = bayerInfo["name"];
      bayerEmail = bayerInfo["Email"];
      bayerAbout = bayerInfo["about"];
      bayerID = bayerInfo["id"];
      bayerPhoneNumber = bayerInfo["phoneNum"];
      bayerRole = bayerInfo["role"];

      sellerName = SellerInfo["name"];
      sellerEmail = SellerInfo["Email"];
      sellerAbout = SellerInfo["about"];
      sellerID = SellerInfo["id"];
      sellerPhoneNumber = SellerInfo["phoneNum"];
      sellerRole = SellerInfo["role"];
    });
  }
}
