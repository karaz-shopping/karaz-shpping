import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import '../../splash/component/size_confige.dart';
import 'custom_indicator_dots.dart';
import 'custom_page_view.dart';

class OnBordaingBody extends StatefulWidget {
  const OnBordaingBody({super.key});

  @override
  State<OnBordaingBody> createState() => _OnBordaingBodyState();
}

class _OnBordaingBodyState extends State<OnBordaingBody> {
  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 0)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPageView(
          pageController: pageController,
        ),

        // dots
        Positioned(
            bottom: SizeConfig.defaultSize! * 20,
            left: 0,
            right: 0,
            child: CustomIndicator(
                dotIndex:
                    pageController!.hasClients ? pageController?.page : 0)),

        // skip

        Visibility(
          visible: pageController!.hasClients
              ? (pageController!.page == 2 ? false : true)
              : true,
          child: Positioned(
            top: SizeConfig.defaultSize! * 10,
            right: 32,
            child: const Text("Skip",
                style: TextStyle(fontSize: 14, color: Color(0xff898989)),
                textAlign: TextAlign.left),
          ),
        ),

        // button
        Positioned(
            bottom: SizeConfig.defaultSize! * 10,
            left: SizeConfig.defaultSize! * 10,
            right: SizeConfig.defaultSize! * 10,
            child: CustomGeneralButton(
              // text: pageController!.hasClients ? (pageController!.page == 2 ? "Get Strated" :"Next") : "Next",

              onTap: () {
                if (pageController!.page! < 2) {
                  pageController?.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeIn);
                } else {
                  setState(() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Log_in(),
                        ));
                    duration:
                    const Duration(milliseconds: 500);
                  });
                }
              },
              text: pageController!.hasClients
                  ? (pageController?.page == 2 ? 'Get started' : 'Next')
                  : 'Next',
            )),
      ],
    );
  }
}

//  custom button -----------------------------------------------------
class CustomGeneralButton extends StatelessWidget {
  const CustomGeneralButton({Key? key, this.text, this.onTap})
      : super(key: key);
  final String? text;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 134, 39, 162),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text!,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xffffffff),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
