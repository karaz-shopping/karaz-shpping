import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController cardNumberController = TextEditingController();

  get cartSErvice => cartSErvice.deleteCart();
  FirebaseAuth wido = FirebaseAuth.instance;
  CollectionReference widowitem =
      FirebaseFirestore.instance.collection('basket'); //*-*-*-*--*
  ReadItems() {
    widowitem
        .where('BuyerID', isEqualTo: wido.currentUser!.uid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element["price"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
        backgroundColor: AppColors.somo,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19),
                        CardInputFormatter(),
                      ],
                      decoration: const InputDecoration(
                          hintText: "Card number",
                          prefixIcon: Icon(Icons.payment_outlined))),
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: TextField(
                          maxLength: 19,
                          decoration: InputDecoration(
                            hintText: "Name",
                            prefixIcon: Icon(Icons.people_alt),
                          ))),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 3,
                              decoration: const InputDecoration(
                                  hintText: "CVV",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.payments),
                                  )))),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              maxLength: 4,
                              decoration: const InputDecoration(
                                  hintText: "MM/YY",
                                  prefixIcon: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.payments),
                                  ))))
                    ],
                  ),
                  const SizedBox(
                    height: 250,
                  ),
                  SizedBox(
                    height: 100,
                    child: Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.rose3,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50))),
                        onPressed: () async {
                          final CollectionReference<Map<String, dynamic>>
                              basketColl =
                              FirebaseFirestore.instance.collection('basket');
                          final QuerySnapshot<Map<String, dynamic>> basket =
                              await basketColl
                                  .where("BuyerEmail",
                                      isEqualTo: FirebaseAuth
                                          .instance.currentUser!.email)
                                  .get();
                          final CollectionReference<Map<String, dynamic>>
                              orders =
                              FirebaseFirestore.instance.collection('orders');
                          for (int i = 0; i < basket.docs.length; i++) {
                            await orders.add(basket.docs[i].data());
                            await basketColl.doc(basket.docs[i].id).delete();
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("PAY"),
                      ),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class CardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    String inputData = newValue.text;
    StringBuffer buffer = StringBuffer();

    for (var i = 0; i < inputData.length; i++) {
      buffer.write(inputData[i]);
      int index = i + 1;

      if (index % 4 == 0 && inputData.length != index) {
        buffer.write("  ");
      }
    }
    return TextEditingValue(
        text: buffer.toString(),
        selection: TextSelection.collapsed(offset: buffer.toString().length));
  }
}
