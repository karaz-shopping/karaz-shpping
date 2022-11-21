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
          color: AppColors.somo5,
          //color: const Color.fromARGB(221, 222, 212, 212),
          //decoration: BoxDecoration(color:),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 10, 10),
                    child: Row(
                      children: [
                        Container(
                          width: 75,
                          height: 75,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/k.png'),
                            ),
                          ),
                        ),
                        const Spacer(),
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
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.somo2,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: email,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gapPadding: 20,
                                borderSide: BorderSide(
                                  width: 2,
                                  color: AppColors.blueGrey4,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gapPadding: 20,
                                borderSide: BorderSide(
                                  width: 20,
                                  color: AppColors.blueGrey4,
                                ),
                              ),
                              prefixIcon: const Icon(Icons.email),
                              label: const Text("Email"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                gapPadding: 20,
                                borderSide: BorderSide(
                                  width: 2,
                                  color: AppColors.blueGrey4,
                                ),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  gapPadding: 20,
                                  borderSide: BorderSide(width: 20)),
                              prefixIcon: const Icon(Icons.lock),
                              label: const Text("Password"),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    backgroundColor: AppColors.blueGrey3),
                                onPressed: () async {
                                  try {
                                    FirebaseAuth authObject =
                                        FirebaseAuth.instance;

                                    UserCredential loginMethod =
                                        await authObject
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
                                        content: Text(
                                          e.message.toString(),
                                        ),
                                      ),
                                    );
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
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const ResetPassword();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              "Forget password",
                              style: TextStyle(color: AppColors.blueGrey4),
                            ),
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
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: AppColors.blueGrey4,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 4.0,
                          color: AppColors.somo,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Or Login With',
                          style: TextStyle(
                            color: AppColors.blueGrey3,
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 4.0,
                          color: AppColors.somo,
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
