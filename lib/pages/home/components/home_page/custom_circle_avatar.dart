import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
      child: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.somo2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage: AssetImage('assets/images/flower1.jpg'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.somo2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage:
                          AssetImage('assets/images/manPerfume.jpg'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.somo2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage: AssetImage('assets/images/watch.jpg'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.somo2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage: AssetImage('assets/images/Tie.jpg'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.somo2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage:
                          AssetImage('assets/images/womenPerfume.jpg'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
              InkWell(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.somo2,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(3),
                    child: CircleAvatar(
                      radius: 33,
                      backgroundImage:
                          AssetImage('assets/images/sunglasses.jpg'),
                    ),
                  ),
                ),
                onTap: () {},
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      ),
    );
  }
}
