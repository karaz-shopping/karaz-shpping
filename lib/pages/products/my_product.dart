// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/part_product_card.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({
    super.key,
  });
  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    // var search = "";
    // var searchController = TextEditingController();
    // bool change = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.somo3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          iconTheme: IconThemeData(color: AppColors.blueGrey3),
          title: Text(
            'My Product',
            style: TextStyle(color: AppColors.blueGrey3),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: products
                .where(
                  "StoreID",
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                )
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              List<PartProductCard> partProductCard = [];
              if (streamSnapshot.hasData) {
                for (var i in streamSnapshot.data!.docs) {
                  partProductCard.add(PartProductCard(
                    documentSnapshot: i,
                    isFavorite: false,
                  ));
                }
                return ListView(children: partProductCard);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
