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
  'assets/images/chocolate.jpg',
  'assets/images/watches.png',
];

final textList = [
  'Flower bouquet',
  'The best maekup',
  'Gift box',
  'Bouquet bride',
  'Delicious chocolate',
  'Brand watches',
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
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: AssetImage(
                        imageList[index],
                      ),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.3),
                        BlendMode.colorDodge,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                      color: AppColors.somo2,
                    ),
                    child: Text(
                      '  ${textList[index]}  ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blueGrey4,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          itemCount: imageList.length,
        ),
      ),
    );
  }
}
