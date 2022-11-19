import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/chat/chat.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required String appbartitle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.somo3,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25))),
      iconTheme: IconThemeData(color: AppColors.blueGrey3),
      title: Text(
        'Home Page',
        style: TextStyle(color: AppColors.blueGrey3),
      ),
      centerTitle: true,
      actions: [
        IconButton(
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
        // IconButton(
        //   color: AppColors.blueGrey3,
        //   icon: const Icon(Icons.shopping_cart_outlined),
        //   onPressed: () {},
        // ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
