
import 'package:flutter/material.dart';
import 'package:transition/transition.dart';

import '../boarding/boarding_view.dart';
import 'component/size_confige.dart';

class SplashBody extends StatefulWidget {
  const SplashBody({super.key});

  @override
  State<SplashBody> createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? fadingAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 850));
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
    goToNextView();   //commet----------------------------
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
      Duration(seconds: 5),
      () {
        setState(() {
          Navigator.push(context, MaterialPageRoute(builder: (context) => OnBordingView(),));
        });
      },
    );
  }
}