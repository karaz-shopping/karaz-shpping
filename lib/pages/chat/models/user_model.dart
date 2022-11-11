// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/pages/chat/message.dart';

class UserCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const Message();
          },
        ));
      },
      child: Card(
        child: ListTile(
          title: Text(name),
          subtitle: Text(lastMessage),
          leading: const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Expanded(
                  child: Icon(
                Icons.album_outlined,
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
