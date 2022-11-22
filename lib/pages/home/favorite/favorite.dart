import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/home/components/appBar/custom_app_bar.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final CollectionReference favorite =
      FirebaseFirestore.instance.collection('favorite');
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
                return Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 12),
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
                            title: Text(documentSnapshot['name']),
                            subtitle: Text(documentSnapshot['description']),
                            leading:
                                Text(documentSnapshot['color'] + '\ncolor'),
                            trailing: Image.network(documentSnapshot['image']),
                          ),
                        )
                      ],
                    ),
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
