import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/part_product.dart';

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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Flower",
                      );
                    },
                  ));
                },
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Perfume",
                      );
                    },
                  ));
                },
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Watche",
                      );
                    },
                  ));
                },
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
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Tie",
                      );
                    },
                  ));
                },
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
                      backgroundImage: AssetImage('assets/images/cake3.png'),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Sweets",
                      );
                    },
                  ));
                },
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
                      backgroundImage: AssetImage('assets/images/package2.jpg'),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Packages",
                      );
                    },
                  ));
                },
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
                      backgroundImage: AssetImage('assets/images/makeup2.jpg'),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return PartOfTheProduct(
                        productType: "Makeup",
                      );
                    },
                  ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
