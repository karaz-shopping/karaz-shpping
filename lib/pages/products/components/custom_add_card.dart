// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/products/components/product_card.dart';

class CustomAdsCard extends StatefulWidget {
  const CustomAdsCard({super.key});

  @override
  State<CustomAdsCard> createState() => _CustomAdsCardState();
}

class _CustomAdsCardState extends State<CustomAdsCard> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  //update function start-----------------------------------------------------------------------------------------

  //update function end-----------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          List<ProductCard> productCard = [];
          if (streamSnapshot.hasData) {
            for (var i in streamSnapshot.data!.docs) {
              productCard.add(ProductCard(documentSnapshot: i));
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
