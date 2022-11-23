// ignore_for_file: file_names, non_constant_identifier_names, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/chat/message.dart';

class ProductsDetails extends StatefulWidget {
  String name;
  String description;
  String color;
  String price;
  String Email;
  String image;
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
    required this.image,
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
  var bayerImage = '';

  var sellerName = "";
  var sellerEmail = "";
  var sellerAbout = "";
  var sellerID = "";
  var sellerPhoneNumber = "";
  var sellerRole = "";
  var sellerImage = '';
  bool isFavorite = false;
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
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.favorite,
        //       size: 30,
        //       color: isFavorite ? Colors.red : Colors.grey,
        //     ),
        //     onPressed: () async {
        //       await FirebaseFirestore.instance.collection('favorite').add({
        //         'name': widget.name,
        //         'description': widget.description,
        //         'color': widget.color,
        //         'price': widget.price,
        //         'Email': widget.Email,
        //         'Type': widget.Type,
        //         'userid': FirebaseAuth.instance.currentUser!.uid,
        //         'image': widget.image,
        //       });
        //       setState(() {
        //         isFavorite = !isFavorite;
        //       });
        //     },
        //   )
        // ],
      ),
      floatingActionButton: CircleAvatar(
        backgroundColor: AppColors.somo3,
        radius: 30,
        child: IconButton(
          padding: const EdgeInsets.all(1),
          icon: Icon(
            size: 25,
            color: AppColors.blueGrey3,
            Icons.add_shopping_cart_rounded,
          ),
          onPressed: () async {
            CollectionReference addProduct =
                FirebaseFirestore.instance.collection("basket");
            addProduct.add({
              "type": widget.Type,
              "color": widget.color,
              'name': widget.name,
              "description": widget.description,
              "price": widget.price,
              "StoreID": widget.StoreID,
              "StoreEmail": widget.Email,
              "BuyerID": FirebaseAuth.instance.currentUser!.uid,
              "BuyerEmail": FirebaseAuth.instance.currentUser!.email,
              'image': widget.image,
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Successfuly added to cart',
                ),
              ),
            );
          },
        ),
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 222,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(height: 3),
                const SizedBox(height: 10),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text(
                            'Product Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 17),
                          Text(widget.name),
                          const SizedBox(width: 30),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 3),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text(
                            'Product Description',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 17),
                          Text(widget.description),
                          const SizedBox(width: 30),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 3),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text(
                            'Product type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 17),
                          const Icon(Icons.space_dashboard_outlined),
                          const SizedBox(width: 15),
                          Text(widget.Type),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 3),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text(
                            'Color',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 17),
                          const Icon(Icons.color_lens_outlined),
                          const SizedBox(width: 15),
                          Text(widget.color),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 3),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          SizedBox(width: 10),
                          Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const SizedBox(width: 17),
                          const Icon(Icons.attach_money_rounded),
                          const SizedBox(width: 15),
                          Text(widget.price + ' JD'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(height: 3),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                InkWell(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 10),
                            Text(
                              'Contact With Us (Press here)',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const SizedBox(width: 17),
                            const Icon(Icons.connect_without_contact_rounded),
                            const SizedBox(width: 15),
                            Text(widget.Email),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 3),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  onTap: () {
                    getBayerData();
                  },
                ),
              ],
            ),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Can not Connect yore self',
          ),
        ),
      );
    } else if (contact.exists) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Message(
              name: sellerName,
              img: sellerImage,
              id: sellerID,
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
        "image": sellerImage,
        "About": sellerAbout,
        "Email": sellerEmail,
        "PhoneNumber": sellerPhoneNumber,
        "Role": sellerRole,
        "time": '',
        "read": '0',
        "lastMessage": ''
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.StoreID)
          .collection("contact")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "Name": bayerName,
        "id": bayerID,
        "image": bayerImage,
        "About": bayerAbout,
        "Email": bayerEmail,
        "PhoneNumber": bayerPhoneNumber,
        "Role": bayerRole,
        "time": '',
        "read": '0',
        "lastMessage": ''
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
      bayerImage = bayerInfo["image"];
      bayerID = bayerInfo["id"];
      bayerPhoneNumber = bayerInfo["phoneNum"];
      bayerRole = bayerInfo["role"];

      sellerName = SellerInfo["name"];
      sellerEmail = SellerInfo["Email"];
      sellerAbout = SellerInfo["about"];
      sellerImage = SellerInfo["image"];
      sellerID = SellerInfo["id"];
      sellerPhoneNumber = SellerInfo["phoneNum"];
      sellerRole = SellerInfo["role"];
    });
  }
}
