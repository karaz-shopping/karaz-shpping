// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class PartOfTheProduct extends StatefulWidget {
  PartOfTheProduct({super.key, required this.productType});
  String productType;
  @override
  State<PartOfTheProduct> createState() => _PartOfTheProductState();
}

class _PartOfTheProductState extends State<PartOfTheProduct> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    var search = "";
    var searchController = TextEditingController();
    bool change = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.somo3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        iconTheme: IconThemeData(color: AppColors.blueGrey3),
        title: Text(
          'data',
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: products.where("type", isEqualTo: "Perfume").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              // void getData() async {}
              for (var i in streamSnapshot.data!.docs) {
                print(i.id);
              }
              return SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 40),
                      child: SizedBox(
                        height: 46,
                        child: TextField(
                          decoration: InputDecoration(
                            label: const Text('Search'),
                            icon: const Icon(
                              Icons.search_rounded,
                            ),
                            suffixIcon: Visibility(
                              visible: change,
                              child: IconButton(
                                icon: const Icon(Icons.highlight_off_rounded),
                                onPressed: () {
                                  setState(() {
                                    searchController.clear();
                                    change = false;
                                  });
                                },
                              ),
                            ),
                          ),
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              if (value == '') {
                                change = false;
                              } else {
                                change = true;
                              }
                              search = value;
                            });
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var result = await products
                              .where("type", isEqualTo: widget.productType)
                              .get();
                          print(result.toString());
                        },
                        child: Text(".."))
                    //* stream
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
