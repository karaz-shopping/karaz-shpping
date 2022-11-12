import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/Cart/services/add_to_cart_service.dart';
import 'package:karaz_shopping_organization/pages/home/home_page/slider.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  TextEditingController cardNumberController = TextEditingController();
  
get cartSErvice => cartSErvice.deleteCart();  ///************************-  */


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        backgroundColor: AppColors.somo,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                    decoration: InputDecoration(
                        hintText: "Card number",
                        prefixIcon: Icon(Icons.payment_outlined))),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextField(maxLength: 19,
                        decoration: InputDecoration(
                      hintText: "Name",
                      prefixIcon: Icon(Icons.people_alt),
                    ))),
                Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            keyboardType: TextInputType.number,maxLength: 3,
                            decoration: InputDecoration(
                                hintText: "CVV",
                                prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.payments),
                                )))),
                    SizedBox(
                      width: 7,
                    ),
                    Expanded(
                        child: TextFormField(keyboardType: TextInputType.number,maxLength: 4,
                            decoration: InputDecoration(
                      hintText: "MM/YY",
                       prefixIcon: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.payments),)
                    )))
                  ],
                ),
SizedBox(height: 250,),

                SizedBox(
                    height: 100,
                    child: Center(
                        child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.rose3,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed: () {setState(() {
                        cartSErvice.deleteCart();
                      });},
                      child: Text("PAY"),
                    )))
              ],
            ))
          ],
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
