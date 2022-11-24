import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/chat/chat.dart';
import 'package:karaz_shopping_organization/pages/home/components/Drawer/custom_drawer.dart';
import 'package:karaz_shopping_organization/pages/home/components/appBar/custom_app_bar.dart';
import 'package:karaz_shopping_organization/pages/home/home_page/custom_circle_avatar.dart';
import 'package:karaz_shopping_organization/pages/home/home_page/slider.dart';
import 'package:karaz_shopping_organization/pages/products/components/custom_add_card.dart';

class CustomHome extends StatefulWidget {
  const CustomHome({super.key});


  @override
  State<CustomHome> createState() => _CustomHomeState();
}

class _CustomHomeState extends State<CustomHome> {
  //final searchDB=FirebaseFirestore.instance.collection('products');
  var search = "";
  var searchController = TextEditingController();
  bool change = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:AppColors.blueGreen3 ,
      appBar: CustomAppBar(
        title: 'Home Page',
        action: IconButton(
          color: AppColors.blueGrey3,
          icon: const Icon(Icons.chat_outlined),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return const ChatPage();
              },
            ));
          },
        ),
      ),
      drawer: const CustomDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 40),
            child: SizedBox(
              height: 46,
              child: TextField(
                
                decoration: InputDecoration(
                  label: const Text('Search'),
                  icon: const Icon(
                    Icons.search_rounded,
                  ),
                  suffixIcon: Visibility(
                    visible: change,
                    child: IconButton(
                      icon: const Icon(Icons.highlight_off_rounded),
                      onPressed: () {
                        setState(() {
                          searchController.clear();
                          change = false;
                        });
                      },
                    ),
                  ),
                ),
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    if (value == '') {
                      change = false;
                    } else {
                      change = true;
                    }
                    search = value;
                  });
                },
              ),
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
    );
  }
}
