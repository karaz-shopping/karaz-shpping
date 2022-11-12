import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/Cart/services/add_to_cart_service.dart';

import '../../Themes/app_colors.dart';
import '../../payment/pay_view.dart';

class Cart_View extends StatefulWidget {
  const Cart_View({super.key});

  @override
  State<Cart_View> createState() => _Cart_ViewState();
}

class _Cart_ViewState extends State<Cart_View> {
  CartService cartSErvice = CartService();
  CartList? cartList;
  List totalPrice = [];
  int sum = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.somo3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
          title: Text("Basket", style: TextStyle(color: AppColors.blueGrey3))),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.somo4,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.somo,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(),
                      primary: Theme.of(context).accentColor),
                  onPressed: () {
                    // cartSErvice.deleteCart();
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25))),
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 550,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 204, 155, 210)
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: ListView(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: TextField(
                                      decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    labelText:
                                        'Full name (First and Last name)',
                                  )),
                                ),
                                // SizedBox(height: 1,),
                                Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: TextField(
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
                                    onPressed: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Payment(),
                                            ));
                                      });
                                    },
                                    child: Text("Confirmation Order"),
                                  )),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text("Inquier",
                      style: TextStyle(color: AppColors.blueGrey3)))
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/gifts.jpg"),
            SizedBox(
              height: 17,
            ),
            Text("Receipt",
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: AppColors.purple2)),
            Container(height: 80,
                width: double.infinity,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 172, 153, 153),
                    borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Total amount",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      // swith-------------------------------------------
                      child: Card(
                          elevation: 12,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text("${sum}\$"),
                          )),
                    )
                  ],
                )),
            Text("items",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: AppColors.purple2)),
            StreamBuilder<Object>(
                stream: cartSErvice.getCartProducts().asStream(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  if (data == null) {
                    return CircularProgressIndicator(
                      color: Color.fromARGB(255, 172, 153, 153),
                      strokeWidth: 3,
                    );
                  }

                  cartList = data as CartList;

                  return ListView.builder(
                    shrinkWrap: true, // بدونها ما راح يظهر اشي بالشاشة
                    itemCount: cartList!
                        .Cart.length, // منحط demoCarts.length, حسب الطول بال DB
                    itemBuilder: (context, index) {
                      var item = cartList!.Cart[index];
                      totalPrice.add(item.price);
                    //  totalPrice.map((e) => int.parse(e)).toList();
                      
                    //   totalPrice as int;
                    //   sum = totalPrice.reduce((a, b) => a + b);
                    //   totalPrice.toList().toString();
                      
                      //  for (var i = 0; i < tt.length; ) {
                      //    sum+=i;
                      //    if (i==[tt.length-1]) {
                      //     break;
                           
                      //    }
                      //  }
                      
                      return
                          //  copy the same container fog
                          Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 172, 153, 153),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Row(
                                children: [
                                  Text(
                                    item.name!,
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.color!,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  Text(
                                    "${item.price}\$",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ));
                    },
                  );
                })
          ],
        ),
      )),
    );
  }
}
