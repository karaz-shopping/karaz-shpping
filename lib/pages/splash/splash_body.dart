import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../boarding/boarding_view.dart';
import 'component/size_confige.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

void checkUser(context) async {
  var sp = await SharedPreferences.getInstance();
  String login = sp.getString('login') ?? '';
  String bording = sp.getString('bording') ?? '';

  if (bording == '1' || bording != '') {
    if (login == '1' || login != '') {
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   HomePage.id,
      //   (route) => false,
      // );
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.id,
        (_) => false,
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LogIn.id,
        (_) => false,
      );
    }
  } else {}
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    fadingAnimation =
        Tween<double>(begin: 0.2, end: 1).animate(animationController!)
          ..addListener(() {
            setState(() {
              if (animationController!.isCompleted) {
                animationController?.repeat(reverse: true);
              }
            });
          });

    animationController?.forward();
// fuction to navigat next view automaticly
    goToNextView(); //commet----------------------------
  }

  @override
  Widget build(BuildContext context) {
// init for sizeConfig
    SizeConfig().init(context);

    return Center(
      child: Opacity(
          opacity: fadingAnimation?.value,
          child: Image.asset("assets/images/k.png")),
    );
  }

  void goToNextView() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OnBordingView(),
            ),
          );
        });
      },
    );
  }
}
