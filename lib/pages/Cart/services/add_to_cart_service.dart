import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class CartService {
  final _firestore = FirebaseFirestore.instance;
  final String collectionName = 'cart';
  int statusCode = 0;
  String msg = '';

  Future<void> addToCart(CartModel model) async {
    await _firestore
        .collection(collectionName)
        .add(model.toJson())
        .whenComplete(() {
      log('post data added successful');
      statusCode = 200;
      msg = 'post data added successful';
    }).catchError((onError) {
      handleAuthErrors(onError);
      log('statusCode : $statusCode , error msg : $msg');
    });
  }
//************************************************************ */
  Future<CartList> getCartProducts() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection(collectionName).get().catchError((error) {
      handleAuthErrors(error);
      log('statusCode : $statusCode , error msg : $msg');
    });
    var cartMap = <String, dynamic>{}; //*-*-*-*-**--*

    CartModel cartModel;

    CartList cartList;

    List<CartModel> data = [];

    for (var item in querySnapshot.docs) {
      cartMap['color'] = item.get('color');
      cartMap['description'] = item.get('description');
      cartMap['id'] = item.get('id');
      cartMap['name'] = item.get('name');
      cartMap['price'] =item.get('price'); //*---*-*-*-*
      cartMap['type'] = item.get('type');

      cartModel = CartModel.fromJson(cartMap);
      data.add(cartModel);
    }
    log('message');
    cartList = CartList(Cart: data);
    return cartList;
  }

  Future<void> deleteCart()async{
    var collection = FirebaseFirestore.instance.collection(collectionName);
    var snapshots = await collection.get();
    for(var doc in snapshots.docs){
      await doc.reference.delete();
    }

  }

  void handleAuthErrors(ArgumentError error) {
    String errorCode = error.message;
    switch (errorCode) {
      case "ABORTED":
        {
          statusCode = 400;
          msg = "The operation was aborted";
        }
        break;
      case "ALREADY_EXISTS":
        {
          statusCode = 400;
          msg = "Some document that we attempted to create already exists.";
        }
        break;
      case "CANCELLED":
        {
          statusCode = 400;
          msg = "The operation was cancelled";
        }
        break;
      case "DATA_LOSS":
        {
          statusCode = 400;
          msg = "Unrecoverable data loss or corruption.";
        }
        break;
      case "PERMISSION_DENIED":
        {
          statusCode = 400;
          msg =
              "The caller does not have permission to execute the specified operation.";
        }
        break;
      default:
        {
          statusCode = 400;
          msg = error.message;
        }
        break;
    }
  }
}

class CartList {
  List<CartModel> Cart;

  CartList({required this.Cart});

  factory CartList.fromJson(List<dynamic> data) {
    List<CartModel> dataList = [];
    dataList = data.map((e) {
      return CartModel.fromJson(Map<String, dynamic>.from(e));
    }).toList();
    return CartList(Cart: dataList);
  }
}


class CartModel {
  String? id;
  String? name;
  String? price;
  String? color;
  String? type;
  String? description;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.color,
      this.type,
      this.description});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price']; //*--*----***--*-*-*
    color = json['color'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price; //*-*-*--*-*-*-*
    data['color'] = this.color;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}


