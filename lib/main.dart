import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karaz_shopping_organization/firebase_options.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';
import 'package:karaz_shopping_organization/pages/splash/splach_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    EasyDynamicThemeWidget(
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Karaz',
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: EasyDynamicTheme.of(context).themeMode!,
      routes: {
        HomePage.id: (context) => const HomePage(),
        SplashView.id: (context) => const SplashView(),
        LogIn.id: (context) => const LogIn(),
      },
      initialRoute: SplashView.id,
    );
  }
}
