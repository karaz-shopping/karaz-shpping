import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/add_product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
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
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LogIn(),
                      ),
                    );
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => const LogIn(),
                    //     ),
                    //     (route) => false);
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
          });
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
                'Name',
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
                title: Text('Dashboard'),
                leading: Icon(Icons.dashboard_rounded),
              ),
              onTap: () {},
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
                title: Text('Favorite'),
                leading: Icon(Icons.favorite_border),
              ),
              onTap: () {},
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
}
