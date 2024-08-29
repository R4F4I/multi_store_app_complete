
import 'package:flutter/foundation.dart';
import 'package:ms_customer_app/providers/product_class.dart';


/* - class that takes multiple Product objects and appends them to _list
   - it has a method addItem that takes inputs to create a Product object
   - a method to get length of _list
   - initialises with empty _list
 */

class Wish extends ChangeNotifier{ // Wish inherits ChangeNotifier
  final  List<Product> _list = [];
  List<Product> get getWishItems{ //getter to get _list
    return _list;
  }


  int? get count{ // returns length of _list aka amt of products selected by user
    return _list.length;
  }
  Future<void> addWishItem( // method to create a Product Object
  String name,
  double price,
  int qty,
  int qntty,
  List imagesUrl,
  String documentId,
  String suppId,
  )async{
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
  void clearWishlist(){
    _list.clear();
    notifyListeners();
  }
  void removeThis(String id){
    _list.removeWhere((element) => element.documentId==id) ;
    notifyListeners();
  }
}