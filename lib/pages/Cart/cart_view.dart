import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../Themes/app_colors.dart';

class Cart_View extends StatefulWidget {
  const Cart_View({super.key});

  @override
  State<Cart_View> createState() => _Cart_ViewState();
}

class _Cart_ViewState extends State<Cart_View> {
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
            title:
                Text("Basket", style: TextStyle(color: AppColors.blueGrey3))),
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
                    onPressed: () {},
                    child: Text("Inquier",
                        style: TextStyle(color: AppColors.blueGrey3)))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
        
          child: 
            
          
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/images/gifts.jpg"),
              SizedBox(
                height: 17,
              ),
              Text("Save Basket",
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: AppColors.purple2)),
              Container(
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
                          "Do you want to save your basket?",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        // swith-------------------------------------------
                        child: SwitchListTile(
                          dense: false,
                          value: false,
                          onChanged: (bool? newValue) {},
                        ),
                      )
                    ],
                  )),
              Text("items",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: AppColors.purple2)),
              ListView.builder(
                shrinkWrap: true, // بدونها ما راح يظهر اشي بالشاشة
                itemCount: 4, // منحط demoCarts.length, حسب الطول بال DB
                itemBuilder: (context, index) {
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
                                "1x",
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Text(
                                  "ROZE",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Text(
                                "4.99\$",
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ));
                },
              )
            ],
          ),
        )),
        );
  }
}
