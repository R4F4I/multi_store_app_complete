
import 'package:flutter/foundation.dart';
import 'package:multi_store_app/providers/product_class.dart';


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

  double get totalPrice{
    var total =0.0;

    for (var item in _list ){
       total += item.price * item.qty;
    }
    return total;
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
  void removeItem(Product product){
    _list.remove(product);
    notifyListeners();
  }
  void clearCart(){
    _list.clear();
    notifyListeners();
  }
  void increment(Product product){
    product.increase();
    notifyListeners();
  }
  void decrement(Product product){
    product.decrease();
    notifyListeners();
  }
}