// ignore_for_file: unused_element, annotate_overrides, override_on_non_overriding_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/Cart/my_orders.dart';
import 'package:karaz_shopping_organization/pages/home/favorite/favorite.dart';
import 'package:karaz_shopping_organization/pages/products/add_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import 'package:karaz_shopping_organization/pages/products/my_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  Widget build(BuildContext context) {
    

    return StreamBuilder(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        final docId = FirebaseAuth.instance.currentUser!.uid;
        if (snapshot.hasData) {
          var name = '';
          var image = '';
          var role = '';

          for (var i in snapshot.data!.docs) {
            if (i.id == docId) {
              name = i['name'];
              image = i["image"];
              role = i['role'];
            }
          }
          return Drawer(
            //backgroundColor: AppColors.somo3,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: AppColors.somo2,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15)),
                    ),
                    currentAccountPicture: Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          // child: Image.network(
                          //   image,
                          // ),
                          // child: Image(
                          //   image: NetworkImage(
                          //     image,
                          //   ),
                          // ),
                        ),
                      ),
                    ),
                    accountName: Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueGrey3,
                      ),
                    ),
                    accountEmail: Text(
                      FirebaseAuth.instance.currentUser!.email.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        color: AppColors.blueGrey3,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: role == 'Store',
                    child: InkWell(
                      child: const ListTile(
                        title: Text('Add Product'),
                        leading: Icon(Icons.cloud_upload_outlined),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const AddProduct();
                          },
                        ));
                      },
                    ),
                  ),
                  Visibility(
                    visible: role == 'Store',
                    child: InkWell(
                      child: const ListTile(
                        title: Text('My Product'),
                        leading: Icon(Icons.shopping_bag_outlined),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const MyProduct();
                          },
                        ));
                      },
                    ),
                  ),
                  InkWell(
                    child: const ListTile(
                      title: Text('My orders'),
                      leading: Icon(Icons.shopping_cart_outlined),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const MyOrders();
                        },
                      ));
                    },
                  ),
                  InkWell(
                    child: const ListTile(
                      title: Text('Favorite'),
                      leading: Icon(Icons.favorite_border),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const Favorite();
                        },
                      ));
                    },
                  ),
                  InkWell(
                    child: ListTile(
                      title: const Text('Themes'),
                      leading: const Icon(Icons.color_lens_outlined),
                      trailing: EasyDynamicThemeBtn(),
                      onTap: () {
                        EasyDynamicTheme.of(context).changeTheme();
                      },
                    ),
                  ),
                  InkWell(
                    child: const ListTile(
                      title: Text('Log Out'),
                      leading: Icon(Icons.logout),
                    ),
                    onTap: () async {
                      //showMessage('Do you want log out ?');
                      FirebaseAuth.instance.signOut();
                      var sp = await SharedPreferences.getInstance();
                      sp.remove('login');
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamedAndRemoveUntil(
                          context, LogIn.id, (route) => false);
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
