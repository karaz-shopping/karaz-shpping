import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/home/components/appBar/custom_app_bar.dart';
import 'package:karaz_shopping_organization/pages/products/components/Products_details.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final CollectionReference favorite = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('favorite');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorite',
        action: const SizedBox(),
      ),
      body: StreamBuilder(
        stream: favorite
            .where(
              "userid",
              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
            )
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                final docId = snapshot.data!.docs[index].id;
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('favorite')
                        .doc(docId)
                        .delete();
                    setState(() {});
                  },
                  background: Container(
                    color: AppColors.blueGrey4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  child: InkWell(
                    child: Card(
                      elevation: 10,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 12),
                              child: Row(
                                children: [
                                  Text(
                                    documentSnapshot['Type'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blueGrey3,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    documentSnapshot['price'] + ' JD',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.blueGrey3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Card(
                              elevation: 5,
                              color: AppColors.somo5,
                              child: ListTile(
                                title: Text(
                                  documentSnapshot['name'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                subtitle: Text(
                                  documentSnapshot['description'],
                                  style: const TextStyle(color: Colors.black),
                                ),
                                leading: Text(
                                  documentSnapshot['color'] + '\ncolor',
                                  style: const TextStyle(color: Colors.black),
                                ),
                                trailing: Container(
                                  width: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          documentSnapshot['image']),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductsDetails(
                            name: documentSnapshot['name'],
                            description: documentSnapshot['description'],
                            color: documentSnapshot['color'],
                            price: documentSnapshot['price'],
                            Email: documentSnapshot['Email'],
                            Type: documentSnapshot['Type'],
                            StoreID: documentSnapshot['userid'],
                            image: documentSnapshot['image'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
