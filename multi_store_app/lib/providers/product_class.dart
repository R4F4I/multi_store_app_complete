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
  void increase(){
    qty++;
  }
  void decrease(){
    qty--;
  }
}