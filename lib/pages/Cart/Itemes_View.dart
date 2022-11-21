// ignore_for_file: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class ItemesView extends StatefulWidget {
  const ItemesView({super.key});

  @override
  State<ItemesView> createState() => _ItemesViewState();
}

class _ItemesViewState extends State<ItemesView> {
  final CollectionReference Itemes =
      FirebaseFirestore.instance.collection('basket');
  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.blueGrey3,
        child: SingleChildScrollView(
          child: StreamBuilder(
              stream: Itemes
                .where("BuyerEmail",
                    isEqualTo: FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        final docId = streamSnapshot.data!.docs[index].id;
                        return GestureDetector(
                          onHorizontalDragEnd: (details) {
                            FirebaseFirestore.instance
                                .collection('basket')
                                .doc(docId)
                                .delete();
                          },
                          child: Card(
                            elevation: 10,
                            color: AppColors.somo2,
                            margin: const EdgeInsets.all(10),
                            child: ListTile(
                              title: Text(documentSnapshot['name']),
                              subtitle: Text(documentSnapshot['StoreEmail']),
                              trailing: Text(
                                "${documentSnapshot['price']} JD",
                              ),
                            ),
                          ),
                        );
                      });
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
