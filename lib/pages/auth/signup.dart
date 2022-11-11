// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  List myList = ["Store", "Buyer"];
  String dropdownValue = "Buyer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: userName,
              decoration: InputDecoration(
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 253, 191, 99)),
                hintText: "Enter your user name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: email,
              decoration: InputDecoration(
                label: const Text("Example@example.com"),
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 253, 191, 99)),
                hintText: "Enter your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                label:
                    const Text("the passowrd must be more than 8 charactars"),
                hintStyle:
                    const TextStyle(color: Color.fromARGB(255, 252, 186, 87)),
                hintText: "Enter your Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Store', 'Buyer']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 99, 61, 5),
                backgroundColor: const Color.fromARGB(255, 253, 191, 99)),
            onPressed: (() async {
              try {
                FirebaseAuth authObj = FirebaseAuth.instance;
                UserCredential myUser =
                    await authObj.createUserWithEmailAndPassword(
                  email: email.text,
                  password: password.text,
                );
                final userRef =
                    FirebaseFirestore.instance.collection("users").doc();
                userRef.set({
                  'name': userName.text,
                  "role": dropdownValue,
                });
                email.clear();
                password.clear();
                userName.clear();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Your email is add successfully")));
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const HomePage();
                  },
                ));
              } on FirebaseAuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message.toString())));
              }
            }),
            child: const Text(
              "sign up",
              style: TextStyle(
                  fontSize: 30, color: Color.fromARGB(255, 61, 22, 7)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return const LogIn();
                },
              ));
            },
            child: const Text("Allready have Email!"),
          ),
        ],
      ),
    );
  }
}
