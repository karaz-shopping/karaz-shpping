// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/components/appBar/custom_app_bar.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController email = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Reset password',
      ),
      body: Center(
          child: Container(
        width: 320,
        height: 500,
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 248, 156, 187),
            borderRadius: BorderRadius.all(Radius.circular(35))),
        child: Column(
          children: [
            const Text("Receive an Email to reset your password"),
            const SizedBox(
              height: 50,
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    gapPadding: 20,
                    borderSide: BorderSide(width: 50)),
                prefixIcon: Icon(Icons.email),
                label: Text("Email"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                try {
                  await FirebaseAuth.instance
                      .sendPasswordResetEmail(email: email.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Reset Email send successfully"),
                    ),
                  );
                  Navigator.of(context).pop();
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message.toString()),
                    ),
                  );
                }
              },
              child: const Text("Send "),
            ),
          ],
        ),
      )),
    );
  }
}
