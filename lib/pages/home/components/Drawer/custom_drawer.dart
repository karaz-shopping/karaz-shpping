import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/add_product.dart';

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
                    // Navigator.pushNamedAndRemoveUntil(
                    //     context, LogIn.id, (route) => false);
                    // FirebaseAuth.instance.signOut();
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
                  color: Colors.white,
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
                'User Name',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueGrey3,
                ),
              ),
              accountEmail: Text(
                'user@exmple.com',
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
            InkWell(
              child: const ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_bag_outlined),
              ),
              onTap: () {},
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
