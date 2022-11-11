import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/home/components/Drawer/custom_drawer.dart';
import 'package:karaz_shopping_organization/pages/home/components/appBar/custom_app_bar.dart';
import 'package:karaz_shopping_organization/pages/home/home_page/custom_circle_avatar.dart';
import 'package:karaz_shopping_organization/pages/home/home_page/slider.dart';
import 'package:karaz_shopping_organization/pages/products/components/custom_add_card.dart';
import 'package:karaz_shopping_organization/pages/products/view_product.dart';

class CustomHome extends StatefulWidget {
  const CustomHome({super.key});

  @override
  State<CustomHome> createState() => _CustomHomeState();
}

class _CustomHomeState extends State<CustomHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: Container(
        color: Colors.white10,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.topRight,
        //     end: Alignment.bottomLeft,
        //     colors: AppColors.mixList,
        //   ),
        // ),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              height: 46,
              child: const TextField(
                decoration: InputDecoration(
                  label: Text('Search'),
                  icon: Icon(
                    Icons.search_rounded,
                  ),

                  // suffixIcon: Visibility(
                  //   visible: change,
                  //   child: IconButton(
                  //     icon: Icon(Icons.highlight_off_rounded),
                  //     onPressed: () {
                  //       setState(() {
                  //         searchController.clear();
                  //         change = false;
                  //       });
                  //     },
                  //   ),
                  // ),
                ),
                // controller: searchController,
                // onChanged: (value) {
                //   setState(() {
                //     if (value == '') {
                //       change = false;
                //     } else {
                //       change = true;
                //     }
                //     search = value;
                //   });
                // },
              ),
            ),
            const CustomCircleAvatar(),
            const CustomSlider(),
            const CustomAdsCard(),
            // Container(
            //   width: double.infinity,
            //   height: 500,
            //   color: Colors.blueAccent,
            //   child: const CustomAdsCard(),
            // ),
            //const CustomAdsCard(),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute(
            //       builder: (context) {
            //         return const ViewProduct();
            //       },
            //     ));
            //   },
            //   child: const Text('view data'),
            // ),
          ],
        ),
      ),
    );
  }
}
