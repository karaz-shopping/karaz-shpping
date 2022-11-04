import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();

  List myList = ["Store", "Buyer"];
  String dropdownValue = "Buyer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: userName,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 253, 191, 99)),
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
                controller: Email,
                decoration: InputDecoration(
                  label: Text("Example@example.com"),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 253, 191, 99)),
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
                controller: Password,
                obscureText: true,
                decoration: InputDecoration(
                  label: Text("the passowrd must be more than 8 charactars"),
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 252, 186, 87)),
                  hintText: "Enter your Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
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
                  onPrimary: const Color.fromARGB(255, 99, 61, 5),
                  primary: const Color.fromARGB(255, 253, 191, 99)),
              onPressed: (() async {
                try {
                  FirebaseAuth AuthObj = FirebaseAuth.instance;
                  UserCredential myUser =
                      await AuthObj.createUserWithEmailAndPassword(
                    email: Email.text,
                    password: Password.text,
                  );
                  final userRef =
                      FirebaseFirestore.instance.collection("users").doc();
                  userRef.set({
                    'name': userName.text,
                    "role": dropdownValue,
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Your email is add successfully")));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Sorry the email is already exist")));
                }
                ;
              }),
              child: const Text(
                "sign up",
                style: TextStyle(
                    fontSize: 30, color: Color.fromARGB(255, 61, 22, 7)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
