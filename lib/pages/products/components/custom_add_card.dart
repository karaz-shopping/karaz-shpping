// ignore_for_file: unused_local_variable, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class CustomAdsCard extends StatefulWidget {
  const CustomAdsCard({super.key});

  @override
  State<CustomAdsCard> createState() => _CustomAdsCardState();
}

class _CustomAdsCardState extends State<CustomAdsCard> {
  final CollectionReference Products =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Products.snapshots(),
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
                return Padding(
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
                          child: InkWell(
                            onTap: () {},
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
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 12,
                            child: IconButton(
                              padding: const EdgeInsets.fromLTRB(0, 1, 3, 1),
                              iconSize: 35,
                              onPressed: () {
                                const urlPost = "url post";
                                Share.share(
                                  'Karaz \n${documentSnapshot['description']} \n\n $urlPost',
                                );
                              },
                              icon: Icon(
                                size: 20,
                                Icons.share,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ),
                      ],
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
