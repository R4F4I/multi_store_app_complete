

import 'package:flutter/material.dart';

/* class that will create an object of the item chosen by customer to be sent to cart_screen*/
class Product{
  String name;
  double price;
  int qty = 1; // amount of items in customer's cart
  int qntty;   // amount of items in stock
  List imagesUrl;
  String documentId;
  String suppId;
  Product({
    required this.name,
    required this.price,
    required this.qty,
    required this.qntty,
    required this.imagesUrl,
    required this.documentId,
    required this.suppId,
  });
}

/* - class that takes multiple Product objects and appends them to _list
   - it has a method addItem that takes inputs to create a Product object
   - a method to get length of _list
   - initialises with empty _list
 */

class Cart extends ChangeNotifier{ // Cart inherits ChangeNotifier
  final  List<Product> _list = [];
  List<Product> get getItems{ //getter to get _list
    return _list;
  }

  int? get count{ // returns length of _list aka amt of products selected by user
    return _list.length;
  }
  void addItem( // method to create a Product Object
  String name,
  double price,
  int qty,
  int qntty,
  List imagesUrl,
  String documentId,
  String suppId,
  ){
    final product = Product(
      name: name,
      price: price, 
      qty: qty, 
      imagesUrl: imagesUrl, 
      qntty: qntty, 
      documentId: documentId, 
      suppId: suppId,
    );
    _list.add(product); // append the Product Object to _list
    notifyListeners();
  }
}