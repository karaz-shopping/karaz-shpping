import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/firebase_options.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';
import 'pages/auth/log_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

// Ideal time to initialize
//...
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Karaz',
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //return Log_in();
    return HomePage();
  }
}
