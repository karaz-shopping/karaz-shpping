import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class MessageCard extends StatelessWidget {
  String message;
  String messageId;
  String kind;
  String imgSender;
  String imgResever;
  MessageCard({
    super.key,
    required this.message,
    required this.messageId,
    required this.kind,
    required this.imgSender,
    required this.imgResever,
  });

  @override
  Widget build(BuildContext context) {
    if (kind == '1') {
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(imgSender),
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(imgResever),
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
    } else {
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
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(message),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(imgSender),
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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(imgResever),
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
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              image: DecorationImage(
                                image: NetworkImage(message),
                                fit: BoxFit.fill,
                              ),
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
}
