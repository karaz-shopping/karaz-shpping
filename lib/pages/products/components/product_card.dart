import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:karaz_shopping_organization/Themes/app_colors.dart';
import 'package:karaz_shopping_organization/pages/products/components/Products_details.dart';
import 'package:share_plus/share_plus.dart';

class ProductCard extends StatefulWidget {
  ProductCard({
    super.key,
    required this.documentSnapshot,
    required this.isFavorite,
  });
  DocumentSnapshot documentSnapshot;
  bool isFavorite;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  //*update function start -----------------------------------------------------------------------------------------------------------

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    TextEditingController nameController =
        TextEditingController(text: widget.documentSnapshot['name']);
    TextEditingController descriptionController =
        TextEditingController(text: widget.documentSnapshot['description']);
    TextEditingController priceController =
        TextEditingController(text: widget.documentSnapshot['price']);
    if (documentSnapshot != null) {
      setState(() {
        nameController.text = widget.documentSnapshot['name'];
        descriptionController.text = widget.documentSnapshot['description'];
        priceController.text = widget.documentSnapshot['price'];
      });
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    controller: priceController,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.somo2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blueGrey4,
                        ),
                      ),
                      onPressed: () async {
                        final String name = nameController.text;
                        final String decoration = descriptionController.text;
                        final String price = priceController.text;

                        await products.doc(widget.documentSnapshot.id).update({
                          "name": name,
                          "description": decoration,
                          "price": price,
                        });
                        nameController.text = '';
                        priceController.text = '';
                        priceController.text = '';

                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

//*update function ends -----------------------------------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductsDetails(
              name: widget.documentSnapshot['name'],
              description: widget.documentSnapshot['description'],
              color: widget.documentSnapshot['color'],
              price: widget.documentSnapshot['price'],
              Email: widget.documentSnapshot['StoreEmail'],
              Type: widget.documentSnapshot['type'],
              StoreID: widget.documentSnapshot['StoreID'],
              image: widget.documentSnapshot['image'],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: SizedBox(
          //width: 150,

          child: Stack(
            children: [
              Card(
                clipBehavior: Clip.antiAlias,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.none,
                      width: double.infinity,
                      height: 90,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            widget.documentSnapshot['image'],
                          ),
                          onError: (exception, stackTrace) {
                            const AssetImage(
                                'assets/images/image-not-found.png');
                          },
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(7).copyWith(bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                (widget.documentSnapshot['name']),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                (widget.documentSnapshot['color']),
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            (widget.documentSnapshot['description']),
                            maxLines: 1,
                            softWrap: false,
                            style: const TextStyle(fontSize: 10),
                          ),
                          //const SizedBox(height: 10),
                          const Divider(
                            height: 15,
                            thickness: 2,
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    Text(
                                      (widget.documentSnapshot['price']
                                          .toString()),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      'JD',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                                child: VerticalDivider(
                                  width: 5,
                                  thickness: 1.5,
                                  indent: 5,
                                  //endIndent: 7,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      padding: const EdgeInsets.all(1),
                                      icon: const Icon(
                                        size: 20,
                                        Icons.add_shopping_cart_rounded,
                                      ),
                                      onPressed: () async {
                                        CollectionReference addProduct =
                                            FirebaseFirestore.instance
                                                .collection("basket");

                                        addProduct.add({
                                          "type":
                                              widget.documentSnapshot['type'],
                                          "color":
                                              widget.documentSnapshot['color'],
                                          'name':
                                              widget.documentSnapshot['name'],
                                          "description": widget
                                              .documentSnapshot['description'],
                                          "price":
                                              widget.documentSnapshot['price'],
                                          "StoreID": widget
                                              .documentSnapshot['StoreID'],
                                          "StoreEmail": widget
                                              .documentSnapshot['StoreEmail'],
                                          "BuyerID": FirebaseAuth
                                              .instance.currentUser!.uid,
                                          "BuyerEmail": FirebaseAuth
                                              .instance.currentUser!.email,
                                          'image':
                                              widget.documentSnapshot['image'],
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Successfuly added to cart',
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      width: 35,
                                      height: 45,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: widget.isFavorite
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                        onPressed: () async {
                                          var chekProductId = FirebaseFirestore
                                              .instance
                                              .collection('favorite');

                                          await FirebaseFirestore.instance
                                              .collection('favorite')
                                              .add({
                                            'name':
                                                widget.documentSnapshot['name'],
                                            'description':
                                                widget.documentSnapshot[
                                                    'description'],
                                            'color': widget
                                                .documentSnapshot['color'],
                                            'price': widget
                                                .documentSnapshot['price'],
                                            'Email': widget
                                                .documentSnapshot['StoreEmail'],
                                            'Type':
                                                widget.documentSnapshot['type'],
                                            'productid':
                                                widget.documentSnapshot.id,
                                            'userid': FirebaseAuth
                                                .instance.currentUser!.uid,
                                            'image': widget
                                                .documentSnapshot['image'],
                                          });
                                          setState(() {
                                            widget.isFavorite =
                                                !widget.isFavorite;
                                          });
                                        },
                                      ),
                                      // child: FavoriteButton(
                                      //   isFavorite: isFavorite,
                                      //   iconSize: 35,
                                      //   valueChanged: () {
                                      //     setState(() {
                                      //       isFavorite = !isFavorite;
                                      //     });
                                      //     print(widget.documentSnapshot.id);
                                      //     // await FirebaseFirestore.instance
                                      //     //     .collection(
                                      //     //         'favorite')
                                      //     //     .add({
                                      //     //   'name':
                                      //     //       documentSnapshot[
                                      //     //           'name'],
                                      //     //   'description':
                                      //     //       documentSnapshot[
                                      //     //           'description'],
                                      //     //   'color':
                                      //     //       documentSnapshot[
                                      //     //           'color'],
                                      //     //   'price':
                                      //     //       documentSnapshot[
                                      //     //           'price'],
                                      //     //   'Email':
                                      //     //       documentSnapshot[
                                      //     //           'StoreEmail'],
                                      //     //   'Type':
                                      //     //       documentSnapshot[
                                      //     //           'type'],
                                      //     //   'productid':
                                      //     //       documentSnapshot.id,
                                      //     //   'userid': FirebaseAuth
                                      //     //       .instance
                                      //     //       .currentUser!
                                      //     //       .uid,
                                      //     // });
                                      //   },
                                      // ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: FirebaseAuth.instance.currentUser!.uid !=
                    widget.documentSnapshot['StoreID'],
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    iconSize: 18,
                    onPressed: () {
                      const urlPost = "url post";
                      Share.share(
                        'Karaz \n${widget.documentSnapshot['description']} \n\n $urlPost',
                      );
                    },
                    icon: const Icon(Icons.share),
                  ),
                ),
              ),
              Visibility(
                visible: FirebaseAuth.instance.currentUser!.uid ==
                    widget.documentSnapshot['StoreID'],
                child: Positioned(
                  top: 0,
                  right: -10,
                  child: PopupMenuButton(
                    tooltip: 'Setting',
                    elevation: 10,
                    onSelected: (value) {
                      if (value.toString() == '1') {
                        _update();
                      } else if (value.toString() == '2') {
                        FirebaseFirestore.instance
                            .collection("products")
                            .doc(widget.documentSnapshot.id)
                            .delete();
                        //deletePost();
                      } else if (value.toString() == '3') {
                        const urlPost = "url post";
                        Share.share(
                          'Karaz \n${widget.documentSnapshot['description']} \n\n $urlPost',
                        );
                      } else {}
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 1,
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Text('Delete'),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Text('Share'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
