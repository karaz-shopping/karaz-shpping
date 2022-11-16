import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

String about = 'Not added yet';
String phoneNumber = 'Not added yet';

class _UserProfileState extends State<UserProfile> {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  TextEditingController aboutController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.somo3,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        iconTheme: IconThemeData(color: AppColors.blueGrey3),
        title: Text(
          'User Profile',
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showBottomSheet(
                context: context,
                elevation: 10,
                enableDrag: true,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: aboutController,
                          decoration: const InputDecoration(
                            labelText: 'About',
                          ),
                          // onChanged: (value) {
                          //   setState(() {
                          //     about = value;

                          //   });
                          // },
                        ),
                        TextField(
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          controller: phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Phone Number',
                          ),
                          // onChanged: (value) {
                          //   setState(() {
                          //     phoneNumber = value.toString();
                          //   });
                          // },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 25,
                              ),
                            ),
                            onPressed: () {
                              final userInfo = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc();
                              userInfo.set({
                                'about': aboutController.text,
                                'phoneNum': phoneController.text,
                              });

                              // setState(() {

                              //   about = aboutController.toString();
                              //   phoneNumber = phoneController.toString();
                              // });

                              Navigator.of(context).pop();
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: users.snapshots(),
        builder: (context, snapshot) {
          final docId = FirebaseAuth.instance.currentUser!.uid;
          final DocumentSnapshot documentSnapshot = snapshot.data!.docs[1];

          if (snapshot.hasData) {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.somo2,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(3),
                                child: CircleAvatar(
                                  radius: 33,
                                  backgroundImage:
                                      AssetImage('assets/images/profile.png'),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(documentSnapshot['name']),
                            const SizedBox(height: 10),
                            Text(
                              FirebaseAuth.instance.currentUser!.email
                                  .toString(),
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              child: Divider(thickness: 3),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'About',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        aboutController.text,
                        style: const TextStyle(fontSize: 15, height: 1),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 5),
                      const Text(
                        'phone Number',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        phoneController.text,
                        style: const TextStyle(fontSize: 15, height: 1),
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
