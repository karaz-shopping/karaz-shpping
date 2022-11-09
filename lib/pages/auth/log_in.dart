// ignore_for_file: non_constant_identifier_names, camel_case_types, use_key_in_widget_constructors, unused_local_variable, use_build_context_synchronously, dead_code_on_catch_subtype

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/auth/ResetPassword.dart';
import 'package:karaz_shopping_organization/pages/auth/signup.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'login_with_google.dart';

class Log_in extends StatefulWidget {
  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(221, 222, 212, 212),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Log_in",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: Email,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
              controller: Password,
              obscureText: true,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
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
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  onPressed: () async {
                    try {
                      FirebaseAuth authObject = FirebaseAuth.instance;

                      UserCredential LoginMethod =
                          await authObject.signInWithEmailAndPassword(
                              email: Email.text, password: Password.text);
                      String id = LoginMethod.user!.uid;
                      final userRef = FirebaseFirestore.instance
                          .collection('users')
                          .doc(id);
                      final userData = await userRef.get();
                      if (LoginMethod.user!.emailVerified == false) {
                        User? verifyUser = FirebaseAuth.instance.currentUser;
                        await verifyUser!.sendEmailVerification();
                      }
                      // print(LoginMethod.user!.emailVerified);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    } on FirebaseAuthException catch (e) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(e.message.toString()),
                            );
                          });
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message.toString())));
                    }
                  },
                  child: const Text(
                    "Log in",
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Do not have an account? ",
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
              children: const [
                Expanded(
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Or Login With',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    thickness: 4.0,
                    color: Colors.white,
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
    );
  }
}
