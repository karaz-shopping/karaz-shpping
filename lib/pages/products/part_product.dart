// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/part_product_card.dart';

class PartOfTheProduct extends StatefulWidget {
  PartOfTheProduct({super.key, required this.productType});
  String productType;
  @override
  State<PartOfTheProduct> createState() => _PartOfTheProductState();
}

class _PartOfTheProductState extends State<PartOfTheProduct> {
  List<String> favList = [];
  getFavorit() async {
    var faveDocs = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("favorite")
        .get();
    for (var i in faveDocs.docs) {
      favList.add(i.id);
    }
    setState(() {
      favList = favList;
    });
    print(favList);
  }

  @override
  void initState() {
    getFavorit();
    super.initState();
  }

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
            widget.productType,
            style: TextStyle(color: AppColors.blueGrey3),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: products
                .where("type", isEqualTo: widget.productType)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              List<PartProductCard> partProductCard = [];
              if (streamSnapshot.hasData) {
                for (var i in streamSnapshot.data!.docs) {
                  if (favList.contains(i.id)) {
                    partProductCard.add(PartProductCard(
                      documentSnapshot: i,
                      isFavorite: true,
                    ));
                  } else {
                    partProductCard.add(PartProductCard(
                      documentSnapshot: i,
                      isFavorite: false,
                    ));
                  }
                }
                return ListView(children: partProductCard);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
