import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/Cart/my_orders.dart';
import 'package:karaz_shopping_organization/pages/home/favorite/favorite.dart';
import 'package:karaz_shopping_organization/pages/products/add_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import 'package:karaz_shopping_organization/pages/user_profile/user_profile.dart';
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
    showMessage(msg) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(msg),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.blueGreen3,
                  ),
                ),
                onPressed: () async {
                  FirebaseAuth.instance.signOut();
                  var sp = await SharedPreferences.getInstance();
                  sp.remove('login');
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const LogIn(),
                  //   ),
                  // );
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LogIn.id,
                    (_) => false,
                  );
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black87),
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    AppColors.blueGreen2,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.black87),
                ),
              )
            ],
          );
        },
      );
    }

    return StreamBuilder(
      stream: users.snapshots(),
      builder: (context, snapshot) {
        final docId = FirebaseAuth.instance.currentUser!.uid;
        if (snapshot.hasData) {
          var name = '';

          for (var i in snapshot.data!.docs) {
            if (i.id == docId) {
              name = i['name'];
              //UserProfile.userName = name;
            }
          }
          return Drawer(
            //backgroundColor: AppColors.somo3,
            elevation: 0,
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
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          child: Image(
                            image: AssetImage('assets/images/profile.png'),
                          ),
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

                  InkWell(
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
                  // InkWell(
                  //   child: const ListTile(
                  //     title: Text('Terms and Conditions'),
                  //     leading: Icon(Icons.),
                  //   ),
                  //   onTap: () {},
                  // ),
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
                    onTap: () {
                      showMessage('Do you want log out ?');
                    },
                  ),
                ],
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
