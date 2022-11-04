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
  TextEditingController SelectedController = TextEditingController();
  Map<String, dynamic> userData = {};
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
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white12,
                filled: true,
              ),
              items: const [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Store'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Buyer'),
                ),
              ],
              onChanged: (int? value) {},
              validator: (int? value) {
                if (value == null) {
                  return 'Please choose your role';
                }
                return null;
              },
              onSaved: (int? value) {
                // userData['role'] = value;
                SelectedController = value as TextEditingController;
              },
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
                  // String id = user.user!.uid;
                  final userRef =
                      FirebaseFirestore.instance.collection("users").doc();
                  userRef.set({
                    'name': userName.text,
                    'role': SelectedController.text,
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
