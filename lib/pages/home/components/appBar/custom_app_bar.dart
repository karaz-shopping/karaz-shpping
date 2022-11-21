import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/chat/chat.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, required this.title, this.action});
  String title;
  Widget? action;
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
        title,
        style: TextStyle(color: AppColors.blueGrey3),
      ),
      centerTitle: true,
      actions: [action!],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
