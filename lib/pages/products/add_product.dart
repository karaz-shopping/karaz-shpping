import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  XFile? image;
  File? imageFile;
  final ImagePicker picker = ImagePicker();
  var imgeURL = "";
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      imageFile = File(image!.path);
    });
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
      final addProduct =
          FirebaseFirestore.instance.collection("products").doc();
      addProduct.set({
        "type": chosenType.toString(),
        'image': imgeURL,
        "color": chosenColor.toString(),
        'name': nameController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "StoreID": FirebaseAuth.instance.currentUser!.uid,
        "StoreEmail": FirebaseAuth.instance.currentUser!.email,
      });
      nameController.clear();
      descriptionController.clear();
      priceController.clear();
      Navigator.pop(context);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product is add successfully")));
    }
  }

  List colors = [
    "White",
    "Black",
    "Gold",
    "Silver",
    "Red",
    "Blue",
    "Yellow",
    "Green",
    "Pink",
    "Purple",
    "Orange",
    "Brouwn",
  ];
  List typeOfProduct = [
    "Flower",
    "Perfume",
    "Watche",
    "Tie",
    "Makeup",
    "Sweets",
    "Packages",
  ];
  String chosenColor = "White";
  String chosenType = "Flower";
  bool flagType = true;
  bool flagColor = true;
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
          'Add Product',
          style: TextStyle(color: AppColors.blueGrey3),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropdownButton(
                      menuMaxHeight: 150,
                      hint: flagType
                          ? const Text('Choose the type')
                          : Text(chosenType),
                      items: typeOfProduct
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            flagType = false;
                            chosenType = value.toString();
                          },
                        );
                      },
                    ),
                    DropdownButton(
                      menuMaxHeight: 150,
                      hint: flagColor
                          ? const Text('Choose the color')
                          : Text(chosenColor),
                      items: colors
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            flagColor = false;
                            chosenColor = value.toString();
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    label: const Text('Product Name'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    label: const Text('Description'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    label: const Text('Price'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.blueGrey3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Upload Photos',
                      ),
                      Spacer(flex: 1),
                      Icon(Icons.image_search),
                    ],
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.blueGrey3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Add Product',
                      ),
                      Spacer(flex: 1),
                      Icon(Icons.cloud_upload_outlined),
                    ],
                  ),
                  onPressed: () {
                    try {
                      uploadPhoto(context);
                    } on FirebaseException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message.toString())));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Product add failed")));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
