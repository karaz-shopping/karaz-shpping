import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/part_product.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              InkWell(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage:
                              AssetImage('assets/images/flower3.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Flower',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
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
                    const SizedBox(height: 3),
                    Text(
                      'Perfume',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage:
                              AssetImage('assets/images/watch.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Watche',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
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
                    const SizedBox(height: 3),
                    Text(
                      'Tie',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage:
                              AssetImage('assets/images/cake3.png'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Sweets',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage:
                              AssetImage('assets/images/package2.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Packages',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.blueGrey3,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: CircleAvatar(
                          radius: 33,
                          backgroundImage:
                              AssetImage('assets/images/makeup2.jpg'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Makeup',
                      style: TextStyle(
                        color: AppColors.blueGrey3,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
