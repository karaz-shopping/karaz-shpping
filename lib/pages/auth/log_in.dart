// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/auth/reset_password.dart';
import 'package:karaz_shopping_organization/pages/auth/signup.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_with_google.dart';

class LogIn extends StatefulWidget {
  static String id = "LogIn";

  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          //color: const Color.fromARGB(221, 222, 212, 212),
          //decoration: BoxDecoration(color:),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.somo2,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            alignment: AlignmentDirectional.center,
                            decoration: BoxDecoration(
                                color: AppColors.blueGrey3,
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                )),
                            child: Text(
                              "Log_in",
                              style: TextStyle(
                                color: AppColors.somo2,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: email,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  gapPadding: 20,
                                  borderSide: BorderSide(width: 20)),
                              prefixIcon: Icon(Icons.email),
                              label: Text("Email"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: const InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  gapPadding: 20,
                                  borderSide: BorderSide(width: 20)),
                              prefixIcon: Icon(Icons.lock),
                              label: Text("Password"),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              SizedBox(
                                width: 160,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            width: 320,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: AppColors.blueGrey3),
                              onPressed: () async {
                                try {
                                  FirebaseAuth authObject =
                                      FirebaseAuth.instance;

                                  UserCredential loginMethod = await authObject
                                      .signInWithEmailAndPassword(
                                          email: email.text,
                                          password: password.text);
                                  String id = loginMethod.user!.uid;
                                  final userRef = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(id);
                                  final userData = await userRef.get();
                                  if (loginMethod.user!.emailVerified ==
                                      false) {
                                    User? verifyUser =
                                        FirebaseAuth.instance.currentUser;
                                    await verifyUser!.sendEmailVerification();
                                  }
                                  // print(LoginMethod.user!.emailVerified);
                                  var sp =
                                      await SharedPreferences.getInstance();
                                  sp.setString('login', '1');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomePage(),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(e.message.toString())));
                                }
                              },
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                  color: AppColors.somo2,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Do not have account? ",
                        style: TextStyle(color: Colors.grey),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SignUp();
                            },
                          ));
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return const ResetPassword();
                          },
                        ));
                      },
                      child: const Text("Forget password")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 4.0,
                          color: AppColors.blueGrey3,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Or Login With',
                          style: TextStyle(
                            color: AppColors.somo2,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 4.0,
                          color: AppColors.blueGrey3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const GoogleLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
