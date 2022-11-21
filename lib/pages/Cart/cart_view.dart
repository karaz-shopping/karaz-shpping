// ignore_for_file: must_be_immutable, camel_case_types

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/components/product_card.dart';
import '../home/components/appBar/custom_app_bar.dart';
import 'payment/confirmSheet.dart';

class Cart_View extends StatefulWidget {
  String name;
  String price;
  Cart_View({
    Key? key,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  State<Cart_View> createState() => _Cart_ViewState();
}

class _Cart_ViewState extends State<Cart_View> {
  // CartService cartSErvice = CartService();
  // CartList? cartList;
  List<ProductCard> cartItem = [];

  // TextEditingController _quantity = TextEditingController();

  String? quantity;

  int counter = 1;
  int number = 1;
  int count = 1;
  bool isVis = false;
  final CollectionReference Itemes =
      FirebaseFirestore.instance.collection('basket');
  @override
  Widget build(BuildContext context) {
    int sum = 0;
    return Scaffold(
      appBar: CustomAppBar(
        title: "Basket",
        action: const SizedBox(),
      ),
      body: StreamBuilder(
        stream: Itemes.where("BuyerEmail",
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            isVis = false;

            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            isVis = false;

            return const Center(
              child: Text('Try again'),
            );
          }
          List items = snapshot.data!.docs;
          if (items.isEmpty) {
            sum = 0;
            number = 0;
            isVis = false;
          }
          for (int i = 0; i < items.length; i++) {
            isVis = true;
            if (count >= 1) {}
            sum = sum + int.parse(items[i]['price']);
            //number = number + int.parse(items[i]['price']);

          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Receipt",
                  //   style: Theme.of(context).textTheme.headline6!.copyWith(
                  //         color: AppColors.purple2,
                  //       ),
                  // ),

                  Container(
                    color: AppColors.blueGrey1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot = items[index];
                        final docId = items[index].id;

                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            FirebaseFirestore.instance
                                .collection('basket')
                                .doc(docId)
                                .delete();
                            setState(() {});
                          },
                          background: Container(
                            color: AppColors.blueGrey4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delete),
                                ),
                              ],
                            ),
                          ),
                          
                          child: Card(
                            color: AppColors.somo5,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    documentSnapshot['name'],
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                  subtitle: Text(
                                    documentSnapshot['StoreEmail'],
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  trailing: Text(
                                    "${documentSnapshot['price']} JD",
                                    style: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        'The number of pieces',
                                        style: TextStyle(
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // int numb = number;
                                            // setState(() {
                                            //   if (count <= 1) {
                                            //     count++;
                                            //   }
                                            // });
                                          },
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          count.toString(),
                                          style: const TextStyle(
                                            color: Colors.black87,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            //  setState(() {
                                            //     if (count >= 1) {
                                            //       count--;
                                            //     }
                                            //   });
                                          },
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Visibility(
                    visible: isVis,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            color: AppColors.somo5,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total amount",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blueGrey4,
                                  ),
                                ),
                              ),
                              SizedBox(
                                //width: 100,
                                // total card--------------------------------
                                child: Card(
                                  color: AppColors.blueGrey1,
                                  elevation: 7,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Text(
                                      "$sum JD",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueGrey4,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const ConfirmSheet(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
