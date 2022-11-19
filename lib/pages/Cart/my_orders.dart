import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/components/appBar/custom_app_bar.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({super.key});

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final CollectionReference basket =
      FirebaseFirestore.instance.collection('basket');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        appbartitle: 'My orders',
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
                  return Card(
                    child: Column(
                      children: [
                        Text(documentSnapshot['name']),
                        Text(documentSnapshot['description']),
                        Text(documentSnapshot['price']),
                        Text(documentSnapshot['color']),
                        Text(documentSnapshot['type']),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
