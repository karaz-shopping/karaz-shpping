import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class MessageCard extends StatelessWidget {
  String message;
  String messageId;
  String kind;
  MessageCard(
      {super.key,
      required this.message,
      required this.messageId,
      required this.kind});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 10),
          messageId == FirebaseAuth.instance.currentUser!.uid
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // mainAxisAlignment:
                  //     messageId == FirebaseAuth.instance.currentUser!.uid
                  //         ? MainAxisAlignment.end
                  //         : MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      // width: MediaQuery.of(context).size.width / 1.5,
                      // height: 40,
                      child: Material(
                        type: MaterialType.button,
                        color: AppColors.blueGrey1,
                        elevation: 5,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            message,
                            textAlign: TextAlign.justify,
                            //style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // mainAxisAlignment:
                  //     messageId == FirebaseAuth.instance.currentUser!.uid
                  //         ? MainAxisAlignment.end
                  //         : MainAxisAlignment.start,
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
                      // width: MediaQuery.of(context).size.width / 1.5,
                      // height: 40,
                      child: Material(
                        type: MaterialType.button,
                        color: AppColors.somo4,
                        elevation: 5,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            message,
                            textAlign: TextAlign.justify,
                            //style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
