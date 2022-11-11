import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class Message extends StatefulWidget {
  const Message({Key? key}) : super(key: key);

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
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
          'Summer',
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
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
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
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
              Material(
                color: AppColors.somo2,
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                  onPressed: () {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding: EdgeInsets.zero,
                        content: SizedBox(
                          width: 50,
                          height: 130,
                          child: Column(
                            children: [
                              // * camera
                              Expanded(
                                child: ListTile(
                                  title: const Text('camera'),
                                  leading: const Icon(Icons.camera_enhance),
                                  onTap: () async {
                                    //pickCam();
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              // * gallery
                              Expanded(
                                child: ListTile(
                                  title: const Text('gallery'),
                                  leading: const Icon(Icons.image_rounded),
                                  onTap: () async {
                                    //pickImage();
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              // primary: AppTheme.getTheme(context: context)
                              //     ? Colors.white
                              //     : Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('cancel'),
                          )
                        ],
                      ),
                    );
                  },
                  icon: Icon(Icons.add, color: AppColors.blueGrey4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 70,
                  height: 40,
                  child: Material(
                    type: MaterialType.button,
                    color: AppColors.somo2,
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
            ],
          ),
        ],
      ),
    );
  }
}
