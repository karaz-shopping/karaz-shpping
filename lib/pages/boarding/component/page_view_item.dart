import 'package:flutter/material.dart';
import '../../splash/component/size_confige.dart';

class PageViewItem extends StatelessWidget {
  const PageViewItem({super.key, this.title, this.subTitle, this.image});

  final String? title;
  final String? subTitle;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const VerticalSpace(15),

//  PageView Image

      SizedBox(
          height: SizeConfig.defaultSize! * 30, child: Image.asset(image!)),
      const VerticalSpace(5),

      //  PageView Title

      Text(
        title!,
        style: const TextStyle(
          fontSize: 20,
          color: Color(0xff2f2e41),
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.left,
      ),
      const VerticalSpace(1),

      //  PageView Subtitle

      Text(
        subTitle!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Color(0xff78787c),
        ),
        textAlign: TextAlign.left,
      ),
    ]);
  }
}

// space virtecal & horizantal

class HorizintalSpace extends StatelessWidget {
  const HorizintalSpace(this.value, {super.key});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.defaultSize! * value!,
    );
  }
}

class VerticalSpace extends StatelessWidget {
  const VerticalSpace(this.value, {super.key});
  final double? value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.defaultSize! * value!,
    );
  }
}
