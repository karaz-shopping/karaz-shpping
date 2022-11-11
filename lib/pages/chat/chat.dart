import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/chat/models/user_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
          'Chat',
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("contacts")
                  .snapshots(),
              builder: (context, snapshot) {
                List<UserCard> user = [];
                if (snapshot.hasData) {
                  for (var i in snapshot.data!.docs) {
                    user.add(UserCard(
                      id: i.id,
                      img: "",
                      lastMessage: i["name"],
                      name: i["name"],
                      read: "",
                      uid: "",
                    ));
                  }
                }
                return Column(
                  children: user,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
