import 'package:flutter/material.dart';

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
        title: const Text('Chat'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: const Text('Sohib Al-Bakri'),
              subtitle: const Text('Hello'),
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
          );
        },
      ),
    );
  }
}
