import 'package:flutter/material.dart';
import 'splash_body.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(33, 226, 135, 217),
      body: SplashBody(),
    );
  }
}
