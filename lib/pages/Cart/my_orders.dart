import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

import '../home/components/appBar/custom_app_bar.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final CollectionReference basket =
      FirebaseFirestore.instance.collection('orders');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Orders',
        action: const SizedBox(),
      ),
      body: StreamBuilder(
          stream: basket
              .where("BuyerEmail",
                  isEqualTo: FirebaseAuth.instance.currentUser!.email)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  final docId = snapshot.data!.docs[index].id;
                  return InkWell(
                    onTap: () async {
                      final recipintInfo = await FirebaseFirestore.instance
                          .collection("recipintInfo")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .get();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(documentSnapshot['name']),
                              content: SingleChildScrollView(
                                  child: Column(
                                children: [
                                  Text(recipintInfo['recipientName']),
                                  Text(recipintInfo['city']),
                                  Text(recipintInfo['country']),
                                ],
                              )),
                            );
                          });
                    },
                    child: Card(
                      elevation: 10,
                      //color: AppColors.blueGrey3,
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
                                    documentSnapshot['type'],
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
                                trailing:
                                    Image.network(documentSnapshot['image']),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
