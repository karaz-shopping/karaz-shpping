import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

final imageList = [
  'assets/images/flowerBouquet.jpg',
  'assets/images/makeupBox.jpg',
  'assets/images/gifts.jpg',
  'assets/images/flower2.jpg',
  'assets/images/phoneAccessories.jpeg',
];

final textList = [
  'باقات الورد',
  'بكجات المكياجات والعطور',
  'الافراح والمناسبات',
  'عروض مسكات العرايس',
  'اكسسوارات الهواتف والتصوير',
];

class _CustomSliderState extends State<CustomSlider> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 170,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Swiper(
          autoplay: true,
          duration: 4,
          scrollDirection: Axis.vertical,
          controller: SwiperController(),
          layout: SwiperLayout.TINDER,
          itemWidth: MediaQuery.of(context).size.width,
          itemHeight: 200.0,
          itemBuilder: (context, index) {
            return InkWell(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(
                          imageList[index],
                        ),
                        fit: BoxFit.fitWidth,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.3),
                          BlendMode.colorDodge,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                        color: AppColors.somo2,
                      ),
                      child: Text(
                        ' ${textList[index]} ',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          //backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PremiumPage(),
                //     //! MyPosts()
                //   ),
                // );
              },
            );
          },
          itemCount: imageList.length,
        ),
      ),
    );
  }
}
