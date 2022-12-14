// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class ChatSendMessage extends StatefulWidget {
  String id;

  ChatSendMessage({super.key, required this.id});

  @override
  State<ChatSendMessage> createState() => _ChatSendMessageState();
}

class _ChatSendMessageState extends State<ChatSendMessage> {
  TextEditingController message = TextEditingController();
  XFile? image;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  var imgeURL = "";
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    if (img == null) return;
    setState(() {
      image = img;
      imageFile = File(image!.path);
    });
    uploadPhoto(context);
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
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("contact")
          .doc(widget.id)
          .collection("messages")
          .add({
        "senderID": FirebaseAuth.instance.currentUser!.uid,
        "message": result["path"],
        "kind": "2",
        "time": DateTime.now().millisecondsSinceEpoch,
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.id)
          .collection("contact")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("messages")
          .add({
        "senderID": FirebaseAuth.instance.currentUser!.uid,
        "message": result["path"],
        "kind": "2",
        "time": DateTime.now().millisecondsSinceEpoch,
      });

      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("contact")
          .doc(widget.id)
          .set({
        "lastMessage": 'photo',
        "read": '1',
        "time": DateTime.now().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
      FirebaseFirestore.instance
          .collection("users")
          .doc(widget.id)
          .collection("contact")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "lastMessage": 'photo',
        "read": '1',
        "time": DateTime.now().millisecondsSinceEpoch,
      }, SetOptions(merge: true));
    }
  }

  sendMessage() async {
    //add the message to seller
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("contact")
        .doc(widget.id)
        .collection("messages")
        .add({
      "senderID": FirebaseAuth.instance.currentUser!.uid,
      "message": message.text,
      "kind": "1",
      "time": DateTime.now().millisecondsSinceEpoch,
    });
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.id)
        .collection("contact")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("messages")
        .add({
      "senderID": FirebaseAuth.instance.currentUser!.uid,
      "message": message.text,
      "kind": "1",
      "time": DateTime.now().millisecondsSinceEpoch,
    });

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("contact")
        .doc(widget.id)
        .set({
      "lastMessage": message.text,
      "read": '1',
      "time": DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.id)
        .collection("contact")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "lastMessage": message.text,
      "read": '1',
      "time": DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: message,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: const InputDecoration(
                hintText: 'Your Messages',
              ),
              onChanged: (value) {
                setState(
                  () {
                    //msgg = value;
                  },
                );
              },
              //controller: msgCtrl,
            ),
          ),
        ),
        // Material(
        //   color: AppColors.blueGrey1,
        //   elevation: 5,
        //   borderRadius: BorderRadius.circular(30),
        //   child: IconButton(
        //     padding: EdgeInsets.zero,
        //     alignment: Alignment.center,
        //     onPressed: () {
        //       showDialog(
        //         barrierDismissible: false,
        //         context: context,
        //         builder: (context) => AlertDialog(
        //           contentPadding: EdgeInsets.zero,
        //           content: SizedBox(
        //             width: 50,
        //             height: 130,
        //             child: Column(
        //               children: [
        //                 // * camera
        //                 Expanded(
        //                   child: ListTile(
        //                     title: const Text('camera'),
        //                     leading: const Icon(Icons.camera_enhance),
        //                     onTap: () async {
        //                       //pickCam();
        //                       Navigator.pop(context);
        //                     },
        //                   ),
        //                 ),
        //                 // * gallery
        //                 Expanded(
        //                   child: ListTile(
        //                     title: const Text('gallery'),
        //                     leading: const Icon(Icons.image_rounded),
        //                     onTap: () async {
        //                       //pickImage();
        //                       Navigator.pop(context);
        //                     },
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           actions: [
        //             OutlinedButton(
        //               onPressed: () => Navigator.pop(context),
        //               style: OutlinedButton.styleFrom(
        //                 // primary: AppTheme.getTheme(context: context)
        //                 //     ? Colors.white
        //                 //     : Colors.black,
        //                 shape: RoundedRectangleBorder(
        //                   borderRadius: BorderRadius.circular(10),
        //                 ),
        //               ),
        //               child: const Text('cancel'),
        //             )
        //           ],
        //         ),
        //       );
        //     },
        //     icon: Icon(Icons.add, color: AppColors.blueGrey4),
        //   ),
        // ),
        Material(
          color: AppColors.blueGrey1,
          elevation: 5,
          borderRadius: BorderRadius.circular(30),
          child: IconButton(
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            icon: Icon(
              Icons.image_rounded,
              color: AppColors.blueGrey4,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            sendMessage();
            message.clear();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 70,
              height: 40,
              child: Material(
                type: MaterialType.button,
                color: AppColors.blueGrey1,
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Send',
                      style: TextStyle(
                        color: AppColors.blueGrey4,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.send, color: AppColors.blueGrey4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
/*Expanded(
          child: SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                        AssetImage('assets/images/profile.png'),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 40,
                      child: Material(
                        type: MaterialType.button,
                        color: AppColors.blueGreen2,
                        elevation: 5,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            textAlign: TextAlign.justify,
                            'hello i am a sender',
                            //style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),*/