// ignore_for_file: avoid_unnecessary_containers, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/Cart/payment/pay.dart';

import '../../../Themes/app_colors.dart';

class ConfirmSheet extends StatefulWidget {
  const ConfirmSheet({super.key});

  @override
  State<ConfirmSheet> createState() => _ConfirmSheetState();
}

class _ConfirmSheetState extends State<ConfirmSheet> {
  TextEditingController recipientNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.somo,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                shape: const RoundedRectangleBorder(),
              ),
              onPressed: () {
                // cartSErvice.deleteCart();
                showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(25))),
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 550,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 204, 155, 210)
                                .withOpacity(0.9),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: TextField(
                                  controller: recipientNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText: 'The recipient name (Full name)',
                                  )),
                            ),
                            // SizedBox(height: 1,),
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: TextField(
                                  controller: countryController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText: 'Country/Region',
                                  )),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: TextField(
                                  controller: cityController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText: 'City',
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: TextField(
                                  controller: zipCodeController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText: 'Zip Code',
                                  )),
                            ),

                            SizedBox(
                              height: 100,
                              child: Center(
                                  child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50))),
                                onPressed: () async {
                                  String userID =
                                      FirebaseAuth.instance.currentUser!.uid;
                                  try {
                                    final recipintInfo = FirebaseFirestore
                                        .instance
                                        .collection("recipintInfo");

                                    recipintInfo.add({
                                      "recipientName":
                                          recipientNameController.text,
                                      "country": countryController.text,
                                      "city": cityController.text,
                                      "zipCode": zipCodeController.text,
                                      "BuyerID": FirebaseAuth
                                          .instance.currentUser!.uid,
                                      "BuyerEmail": FirebaseAuth
                                          .instance.currentUser!.email,
                                    });
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Payment(),
                                        ));
                                  } on FirebaseException catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(e.message.toString())));
                                  }
                                },
                                child: const Text("Confirmation Order"),
                              )),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child:
                  Text("Inquier", style: TextStyle(color: AppColors.blueGrey3)))
        ],
      ),
    );
  }
}
