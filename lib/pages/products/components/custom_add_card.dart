// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/products/components/Products_details.dart';
import 'package:share_plus/share_plus.dart';

class CustomAdsCard extends StatefulWidget {
  const CustomAdsCard({super.key});

  @override
  State<CustomAdsCard> createState() => _CustomAdsCardState();
}

class _CustomAdsCardState extends State<CustomAdsCard> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  //update function start-----------------------------------------------------------------------------------------
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      nameController.text = documentSnapshot['name'];
      descriptionController.text = documentSnapshot['description'];
      priceController.text = documentSnapshot['price'];
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
  //update function end-----------------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: products.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.85,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                final docId = streamSnapshot.data!.docs[index].id;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsDetails(
                          name: documentSnapshot['name'],
                          description: documentSnapshot['description'],
                          color: documentSnapshot['color'],
                          price: documentSnapshot['price'],
                          Email: documentSnapshot['StoreEmail'],
                          Type: documentSnapshot['type'],
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
                                  height: 90,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/manPerfume.jpg'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(7)
                                      .copyWith(bottom: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            (documentSnapshot['name']),
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const Spacer(),
                                          Text(
                                            (documentSnapshot['color']),
                                            style:
                                                const TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        (documentSnapshot['description']),
                                        maxLines: 1,
                                        softWrap: false,
                                        style: const TextStyle(fontSize: 10),
                                      ),
                                      //const SizedBox(height: 10),
                                      const Divider(
                                        height: 15,
                                        thickness: 2,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              children: [
                                                Text(
                                                  (documentSnapshot['price']
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                IconButton(
                                                  padding:
                                                      const EdgeInsets.all(1),
                                                  icon: Icon(
                                                    size: 20,
                                                    color: Colors.grey[700],
                                                    Icons
                                                        .add_shopping_cart_rounded,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                SizedBox(
                                                  width: 25,
                                                  height: 30,
                                                  child: FavoriteButton(
                                                    //isFavorite: widget._isFavorite,
                                                    iconSize: 35,
                                                    valueChanged: () {},
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
                          Positioned(
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
                                      .doc(docId)
                                      .delete();
                                  //deletePost();
                                } else if (value.toString() == '3') {
                                  const urlPost = "url post";
                                  Share.share(
                                    'Karaz \n${documentSnapshot['description']} \n\n $urlPost',
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
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
