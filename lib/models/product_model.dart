import 'package:collection/collection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:multi_store_app/minor_screens/edit_product.dart';
import 'package:multi_store_app/minor_screens/product_details.dart';
import 'package:multi_store_app/providers/wish_provider.dart';
import 'package:provider/provider.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;
  const ProductModel({
    super.key, required this.products
  });

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  late var existingItemWishlist = context.read<Wish>().getWishItems.firstWhereOrNull((product) => product.documentId==widget.products['proid']);
  @override
  Widget build(BuildContext context) {
    var onSale = widget.products['discount'];
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(proList: widget.products)));
      },
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Card(
          elevation: 10,
          shadowColor: Colors.black,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),),
                child: Column(
                  children:[
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 100,maxHeight: 250),
                        child: Image(image: NetworkImage(widget.products['proimages'][0]),)
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                          widget.products['proname'],
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.w600
                           ),
                          ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                onSale !=0
                                ?  Row(
                                  children: [
                                    Text(
                                        ('\$ ')+widget.products['price'].toStringAsFixed(2), //original price
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.lineThrough
                                        ),
                                      ),
                                    const SizedBox(width: 6,),
                                    Text(
                                        ('\$ ')+((1-(onSale/100))*widget.products['price']).toStringAsFixed(2)+(' !!!'), //discounted price
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600
                                          ),
                                        ),
                                    ],
                                )
                                : Text(
                                    ('\$ ')+widget.products['price'].toStringAsFixed(2), //original price
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                widget.products['sid'] == FirebaseAuth.instance.currentUser!.uid
                                    ? IconButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProduct(items: widget.products)));
                                      },
                                      icon: const Icon(Icons.edit,color: Colors.black,))
                                    : IconButton(
                                      onPressed: (){
                                        existingItemWishlist !=null
                                        ? context.read<Wish>().removeThis(widget.products['proid']) //now reclicking the heart icon removes the product from wishlist
                                        : context.read<Wish>().addWishItem(          
                                            widget.products['proname'],
                                            onSale!=0
                                              ? (1-(onSale/100))*widget.products['price']
                                              : widget.products['price'],
                                            1,
                                            widget.products['instock'],
                                            widget.products['proimages'],
                                            widget.products['proid'],
                                          widget.products['sid'],
                                        );
                                      },
                                      icon: context.watch<Wish>().getWishItems.firstWhereOrNull((product) => product.documentId==widget.products['proid']) !=null
                                        ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                        size: 30,
                                        )
                                        : const Icon(
                                        Icons.favorite_border_outlined,
                                        color: Colors.red,
                                        size: 30,
                                        )
                                      ),
                          ],)]
                      ),
                    ),
                    ])
              ),
              onSale != 0
              ? Positioned(
                top: 30,
                left: 0,
                child: Container(
                  height: 25,
                  width: 80,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )
                  ),
                  child: Center(child: Text('Save $onSale %')),
                ),
              )
              : Container(color: Colors.transparent,),
            ],
          ),
        ),
      ),
    );
  }
}