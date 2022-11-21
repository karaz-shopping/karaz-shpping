// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:karaz_shopping_organization/pages/chat/models/message_model.dart';
import 'package:karaz_shopping_organization/pages/chat/models/chat_send_mesage.dart';

class Message extends StatefulWidget {
  String id;
  String name;
  String img;
  Message({super.key, required this.id, required this.name, required this.img});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  var myImage = '';
  getMyImage() async {
    var bayerInfo = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      myImage = bayerInfo['image'];
    });
  }

  @override
  void initState() {
    getMyImage();
    super.initState();
  }

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
          widget.name,
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(widget.img),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("contact")
                  .doc(widget.id)
                  .collection("messages")
                  .orderBy("time", descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                List<MessageCard> message = [];
                if (snapshot.hasData) {
                  for (var i in snapshot.data!.docs) {
                    message.add(
                      MessageCard(
                        message: i["message"],
                        messageId: i["senderID"],
                        kind: i["kind"],
                        imgSender: myImage,
                        imgResever: widget.img,
                      ),
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: message,
                  );
                }
                return const Text("NO Messages");
              },
            ),
          ),
          ChatSendMessage(
            id: widget.id,
          ),
        ],
      ),
    );
  }
}
