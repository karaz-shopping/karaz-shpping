import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController priceController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
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
                      hint: const Text('Choose the type'),
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
                            chosenType = value.toString();
                          },
                        );
                      },
                    ),
                    DropdownButton(
                      menuMaxHeight: 150,
                      hint: const Text('Choose the color'),
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
                    hintText: "Name of product",
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
                    hintText: "Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: codeController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: "Code",
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
                    hintText: "Price",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
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
                  onPressed: () {},
                ),
                ElevatedButton(
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
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
