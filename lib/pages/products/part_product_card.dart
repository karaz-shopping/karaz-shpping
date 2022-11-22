// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/products/components/Products_details.dart';
import 'package:share_plus/share_plus.dart';

class PartProductCard extends StatefulWidget {
  PartProductCard(this.documentSnapshot, {super.key});
  DocumentSnapshot documentSnapshot;

  @override
  State<PartProductCard> createState() => _PartProductCardState();
}

class _PartProductCardState extends State<PartProductCard> {
  //update function start -----------------------------------------------------------------------------------------------------------
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  bool isFavorite = false;

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    TextEditingController nameController =
        TextEditingController(text: widget.documentSnapshot['name']);
    TextEditingController descriptionController =
        TextEditingController(text: widget.documentSnapshot['description']);
    TextEditingController priceController =
        TextEditingController(text: widget.documentSnapshot['price']);
    if (documentSnapshot != null) {
      nameController.text = widget.documentSnapshot['name'];
      descriptionController.text = widget.documentSnapshot['description'];
      priceController.text = widget.documentSnapshot['price'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.only(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'name',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'description',
                  ),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    onPressed: () async {
                      final String name = nameController.text;
                      final String decoration = descriptionController.text;
                      final String price = priceController.text;

                      await products.doc(documentSnapshot!.id).update({
                        "name": name,
                        "description": decoration,
                        "price": price,
                      });
                      nameController.text = '';
                      priceController.text = '';
                      priceController.text = '';

                      if (mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

//update function ends -----------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductsDetails(
              name: widget.documentSnapshot['name'],
              description: widget.documentSnapshot['description'],
              color: widget.documentSnapshot['color'],
              price: widget.documentSnapshot['price'],
              Email: widget.documentSnapshot['StoreEmail'],
              Type: widget.documentSnapshot['type'],
              StoreID: widget.documentSnapshot['StoreID'],
              image: widget.documentSnapshot['image'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SizedBox(
          //width: 150,

          child: Stack(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.none,
                      width: double.infinity,
                      height: 130,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.documentSnapshot['image']),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7).copyWith(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                (widget.documentSnapshot['name']),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                (widget.documentSnapshot['color']),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            (widget.documentSnapshot['description']),
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(fontSize: 10),
                          ),
                          //const SizedBox(height: 10),
                          const Divider(
                            height: 25,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                      (widget.documentSnapshot['price']
                                          .toString()),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'JD',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  width: 5,
                                  thickness: 1.5,
                                  indent: 5,
                                  //endIndent: 7,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.all(1),
                                      icon: Icon(
                                        size: 20,
                                        color: Colors.grey[700],
                                        Icons.add_shopping_cart_rounded,
                                      ),
                                      onPressed: () async {
                                        CollectionReference addProduct =
                                            FirebaseFirestore.instance
                                                .collection("basket");
                                        addProduct.add({
                                          "type":
                                              widget.documentSnapshot['type'],
                                          "color":
                                              widget.documentSnapshot['color'],
                                          'name':
                                              widget.documentSnapshot['name'],
                                          "description": widget
                                              .documentSnapshot['description'],
                                          "price":
                                              widget.documentSnapshot['price'],
                                          "StoreID": widget
                                              .documentSnapshot['StoreID'],
                                          "StoreEmail": widget
                                              .documentSnapshot['StoreEmail'],
                                          "BuyerID": FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "BuyerEmail": FirebaseAuth
                                              .instance.currentUser!.email,
                                          'image':
                                              widget.documentSnapshot['image'],
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: 35,
                                      height: 45,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('favorite')
                                              .add({
                                            'name':
                                                widget.documentSnapshot['name'],
                                            'description':
                                                widget.documentSnapshot[
                                                    'description'],
                                            'color': widget
                                                .documentSnapshot['color'],
                                            'price': widget
                                                .documentSnapshot['price'],
                                            'Email': widget
                                                .documentSnapshot['StoreEmail'],
                                            'Type':
                                                widget.documentSnapshot['type'],
                                            'productid':
                                                widget.documentSnapshot.id,
                                            'userid': FirebaseAuth
                                                .instance.currentUser!.uid,
                                            'image': widget
                                                .documentSnapshot['image'],
                                          });
                                          setState(() {
                                            isFavorite = !isFavorite;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: FirebaseAuth.instance.currentUser!.uid !=
                    widget.documentSnapshot['StoreID'],
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    iconSize: 18,
                    onPressed: () {
                      const urlPost = "url post";
                      Share.share(
                        'Karaz \n${widget.documentSnapshot['description']} \n\n $urlPost',
                      );
                    },
                    icon: const Icon(Icons.share),
                  ),
                ),
              ),
              Visibility(
                visible: FirebaseAuth.instance.currentUser!.uid ==
                    widget.documentSnapshot['StoreID'],
                child: Positioned(
                  top: 0,
                  right: -10,
                  child: PopupMenuButton(
                    tooltip: 'Setting',
                    elevation: 10,
                    onSelected: (value) {
                      if (value.toString() == '1') {
                        _update();
                      } else if (value.toString() == '2') {
                        FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.documentSnapshot.id)
                            .delete();
                        //deletePost();
                      } else if (value.toString() == '3') {
                        const urlPost = "url post";
                        Share.share(
                          'Karaz \n${widget.documentSnapshot['description']} \n\n $urlPost',
                        );
                      } else {}
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text('Delete'),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text('Share'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
