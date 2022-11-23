// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/products/components/product_card.dart';

class CustomAdsCard extends StatefulWidget {
  const CustomAdsCard({super.key});

  @override
  State<CustomAdsCard> createState() => _CustomAdsCardState();
}

class _CustomAdsCardState extends State<CustomAdsCard> {
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
    return StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          List<ProductCard> productCard = [];
          if (streamSnapshot.hasData) {
            for (var i in streamSnapshot.data!.docs) {
              if (favList.contains(i.id)) {
                productCard
                    .add(ProductCard(documentSnapshot: i, isFavorite: true));
              } else {
                productCard
                    .add(ProductCard(documentSnapshot: i, isFavorite: false));
              }
            }
            return GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: productCard,
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
