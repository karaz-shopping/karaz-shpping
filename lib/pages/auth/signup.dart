// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:karaz_shopping_organization/pages/auth/log_in.dart';
import 'package:karaz_shopping_organization/pages/home/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController userName = TextEditingController();
  TextEditingController aboutU = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  XFile? image;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  var imgeURL = "";
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageFile = File(image!.path);
    });
  }

  uploadPhoto(context) async {
    var data = {};
    File file = File(image!.path);
    String base64 = base64Encode(file.readAsBytesSync());
    String imageName = image!.path.split("/").last;
    data["imagename"] = imageName;
    data["image64"] = base64;
    var response = await post(
        Uri.parse("http://aqarakdns.com/karaz/uploadphoto.php"),
        body: data);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      setState(() {
        imgeURL = result["path"];
      });
      String ID = FirebaseAuth.instance.currentUser!.uid;
      DocumentReference<Map<String, dynamic>> userRef =
          FirebaseFirestore.instance.collection("users").doc(ID);
      userRef.set({
        'name': userName.text,
        'about': aboutU.text,
        'phoneNum': phoneNum.text,
        "role": dropdownValue,
        'Email': email.text,
        'id': ID,
        'image': result["path"],
      });
      email.clear();
      password.clear();
      userName.clear();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your email is add successfully")));
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.id,
        (route) => false,
      );
    }
  }

  List myList = ["Store", "Buyer"];
  String dropdownValue = "Buyer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.somo5,
      body: SafeArea(
        child: SingleChildScrollView(
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
                      width: 111,
                      height: 50,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                          color: AppColors.blueGrey3,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          )),
                      child: Text(
                        "Sign up",
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
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Select your photo :'),
                        Stack(
                          children: [
                            InkWell(
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: image == null
                                    ? Image.asset("assets/images/profile.png")
                                    : Image.file(
                                        imageFile!,
                                        fit: BoxFit.fill,
                                      ),
                              ),
                              onTap: () {
                                getImage(ImageSource.gallery);
                              },
                            ),
                            const Positioned(
                              bottom: -1,
                              right: -1,
                              child: Icon(
                                Icons.add_a_photo_outlined,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: userName,
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
                          label: const Text("Enter your user name"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: aboutU,
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
                          label: const Text("Enter about you"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        controller: phoneNum,
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
                          label: const Text("Enter phone number"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
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
                          label: const Text("Example@example.com"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: password,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: const Text("Enter your password"),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            gapPadding: 20,
                            borderSide: BorderSide(
                              width: 2,
                              color: AppColors.blueGrey4,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text('Select your role :'),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(
                            Icons.arrow_drop_down_circle_outlined,
                            color: AppColors.blueGrey4,
                          ),
                          iconSize: 30,
                          elevation: 10,
                          style: TextStyle(color: AppColors.blueGrey4),
                          underline: Container(
                            height: 2,
                            color: AppColors.blueGrey4,
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
                              child: Text(
                                value,
                                style: const TextStyle(fontSize: 18),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blueGrey4,
                      ),
                      onPressed: (() async {
                        try {
                          FirebaseAuth authObj = FirebaseAuth.instance;
                          UserCredential myUser =
                              await authObj.createUserWithEmailAndPassword(
                            email: email.text,
                            password: password.text,
                          );
                          uploadPhoto(context);
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message.toString())));
                        }
                      }),
                      child: Text(
                        "sign up",
                        style: TextStyle(
                          fontSize: 30,
                          color: AppColors.somo2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const LogIn();
                        },
                      ));
                    },
                    child: const Text(
                      "Already have account!",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const LogIn();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: AppColors.blueGrey4,
                        fontSize: 17,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
