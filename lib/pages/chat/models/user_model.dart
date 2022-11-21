// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/chat/message.dart';

class UserCard extends StatefulWidget {
  String img;
  String name;
  String id;
  String uid;
  String read;
  String lastMessage;

  UserCard({
    super.key,
    required this.img,
    required this.name,
    required this.id,
    required this.uid,
    required this.read,
    required this.lastMessage,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  chekmessage() {
    if (widget.read == '1') {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Message(
              name: widget.name,
              img: "",
              id: widget.uid,
            );
          },
        ));
      },
      child: Card(
        child: ListTile(
          title: Text(widget.name),
          subtitle: Text(widget.lastMessage),
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Icon(
                Icons.album_outlined,
                color: chekmessage(),
                size: 20,
              )),
              Text(
                '02:33 AM',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
