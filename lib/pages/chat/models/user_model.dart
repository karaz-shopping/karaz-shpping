// ignore_for_file: must_be_immutable
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/chat/message.dart';

class UserCard extends StatefulWidget {
  String img;
  String name;
  String id;
  String uid;
  String read;
  String lastMessage;
  int time;

  UserCard({
    super.key,
    required this.img,
    required this.name,
    required this.id,
    required this.uid,
    required this.read,
    required this.lastMessage,
    required this.time,
  });

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Message(
              name: widget.name,
              img: widget.img,
              id: widget.uid,
            );
          },
        ));
      },
      child: Card(
        child: ListTile(
          title: Text(widget.name),
          subtitle: Text(widget.lastMessage),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.img),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children:  [
              const Expanded(
                  child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 20,
              )),
              Text(
                DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(widget.time)).toString(),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
